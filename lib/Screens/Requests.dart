
import 'dart:convert';

import 'package:documentary_approval/ApiConnection/Api.dart';
import 'package:documentary_approval/Model/Documents.dart';
import 'package:documentary_approval/Model/Request.dart';
import 'package:documentary_approval/Model/User.dart';
import 'package:documentary_approval/Screens/RequestsDetails.dart';
import 'package:documentary_approval/Tools/Methods.dart';
import 'package:documentary_approval/app_localizations.dart';
import 'package:documentary_approval/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';

class Requests extends StatefulWidget {
  Documents doc ;
  Requests(this.doc ,{Key key}): super(key: key);//add also

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new  RequestsState();
  }

}
class RequestsState  extends State<Requests> with SingleTickerProviderStateMixin {
  TabController _tabController;
  Methods methods = new Methods() ;

  SharedPreferences sharedPrefs;
  User userLocalData ;
  Future <void> getUserData() async{
    sharedPrefs = await SharedPreferences.getInstance();
    userLocalData = User.fromJsonShared(json.decode( sharedPrefs.getString("user") )) ;
    print( userLocalData.toString());
    api.getDocList(userId: userLocalData.userId , functionName: document.functionApiName,
        orgId: userLocalData.orgId ,
        onError: (){
        } , onSuccess: (List<Request> requestsList){
      setState(() {
        loading = false ;
        this.requestsList  = requestsList ;
      });

    });

  }
  Api api = new Api();
  int count  =  0  ;
  int count2  =  0  ;
  Documents document   ;

  void initState() {
    super.initState();
    document = widget.doc ;
    getUserData();
  }
  List<Request> requestsList = new List() ;

  bool loading = true ;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: MyColors.redColor,
         title: new Text(document.name,),
           // style: new TextStyle(color: MyColors.grey_background),),
        ),
        body: loading? new Center(
          child: CircularProgressIndicator(),
        ):
        getView(requestsList)

    );
  }

  Widget getView(List<Request>orderList) {
    return new ListView.builder(
      itemBuilder: (context, index) {
        return listCard(index, orderList);
      }, itemCount: orderList.length,);
  }

  GestureDetector listCard(int index, List<Request>orderList) {
    Request request = orderList[index];
    request.requestDoc  = document;
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(request.prDate);
    String date = DateFormat("yyyy-MM-dd").format(tempDate);

    return GestureDetector(
        onTap: () {
          print(request)  ;
        Navigator.push(context, MaterialPageRoute(builder: (context) => RequestsDetails(request)),).then((value) => getUserData());
          // String name  =  list[index].  name ;
          //  print(name )  ;
        },
        child: new Padding(padding: EdgeInsets.all(8.0),
            child: new Card(
              color: Theme.of(context).cardColor,
              //RoundedRectangleBorder, BeveledRectangleBorder, StadiumBorder
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(10.0),
                    top: Radius.circular(10.0)),
              ),
              child: new Container(
                padding: EdgeInsets.all(8.0),
                child:  new Column (
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Padding(padding: EdgeInsets.only(top:5.0 , bottom: 5.0),child:
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new  RichText(
                          softWrap: true,
                          textAlign: TextAlign.start,
                          text:
                          TextSpan(
                            children: [WidgetSpan(
                              child: Icon(Icons.date_range , color: MyColors.redColor,),
                            ),
                              TextSpan(
                                text:  date,
                                style: TextStyle(color: MyColors.greyDark),
                              ),
                            ],
                          ),
                        ),
                        new  RichText(
                          softWrap: true,
                          textAlign: TextAlign.start,
                          text:
                          TextSpan(
                            children: [

                              TextSpan(
                                text: "#" ,
                                style: TextStyle(color: MyColors.redColor),
                              ),
                              TextSpan(
                                text: request.prNO.toString() ,
                                style: TextStyle(color: MyColors.greyDark),
                              ),
                            ],
                          ),
                        )
                      ],)),
                    new Padding(padding: EdgeInsets.only(top:5.0 , bottom: 2.0),
                      child: new Text( request.reqName ==null?  "" :request.reqName,style:
                      new TextStyle(color: MyColors.greyDark),) ,

                    ),
                    new Padding(padding: EdgeInsets.only(top:2.0 ,),
                      child: new Text( request.prDesc ==null?  "" :request.prDesc,style:
                    new TextStyle(color: MyColors.greyDark),) ,

                    ),


                    Divider(
                        color: Colors.grey
                    ) ,
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                    FlatButton.icon(onPressed: null, icon:Icon(Icons.arrow_forward , color: MyColors.redColor,), label: Text('عرض المستند')),
                     request.approved==2?
                     RichText(
                       text: TextSpan(
                         children: [

                           WidgetSpan(
                             child: Icon(Icons.done_outline, color:Colors.green ,),
                           ),
                           TextSpan(
                              text: "معتمد",
                             style: TextStyle(
                                 color: Colors.green, fontSize: 14, fontWeight: FontWeight.bold),

                           ),
                         ],
                       ),
                     )
                     :FlatButton.icon(onPressed: (){
                          api.setApprove(docType:request.requestDoc.docType , reqSer: request.prSer.toString(), onError: (String  msg ){
                            print(msg) ;
                          } , onApproved: ( var jsonData){
                            String  serial  = jsonData['PK_SERIAL']  ;

                            methods.Dialog(context: context , message: serial +" تم اعتماد المستند بنجاح" ,
                                isCancelBtn:false  , onOkClick: (){
                              setState(() {
                                getUserData() ;
                              });
                           //   Navigator.of(context).pop();

                            } , title: "" ) ;
                          }  ) ;
                        }



                        , icon:Icon(Icons.approval , color: MyColors.redColor,),
                            label: Text('اعتماد'))

                        ,

           /*   IconButton(
                          icon: Icon(Icons.arrow_forward , color: MyColors.redColor,),
                          tooltip: 'عرض',
                          onPressed: () {
                          //  Navigator.push( context, MaterialPageRoute(builder: (context) => MyNotification())) ;

                          },
                        ),
                        IconButton(

                          icon: Icon(Icons.approval , color: MyColors.redColor,),
                          tooltip: 'اعتماد',
                          onPressed: () {
                            //  Navigator.push( context, MaterialPageRoute(builder: (context) => MyNotification())) ;

                          },
                        ),*/
                      ],
                    )

                  ],
                ),
              ), )

        ));
  }
}