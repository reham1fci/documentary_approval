
import 'package:documentary_approval/ApiConnection/Api.dart';
import 'package:documentary_approval/Model/Request.dart';
import 'package:documentary_approval/Tools/Methods.dart';
import 'package:documentary_approval/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../app_localizations.dart';
class RequestsDetails extends StatefulWidget{
  Request request ;
  RequestsDetails(this.request ,{Key key}): super(key: key);
  @override
  State<StatefulWidget> createState() {

    // TODO: implement createState
    return new StateRequest();
  }



}
class StateRequest extends State<RequestsDetails>  {
  String selectDate = "";
  TextEditingController noteEd = new TextEditingController();
  int isFinancial = 0  ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _request  = widget.request;
    isFinancial = _request.isFinancial;

   /* setState(() {
      date = "تاريخ  التآجيل" ;
     /* selectedStatues = _request.statues ;
      if(_order.statuesID  == 3 || _request.statuesID == 6){
        change = true  ;
      }*/

    });
    api.getStatues((List<Statues>list){
      setState(() {
        statuesList = list ;

      });
    }, _order.statuesID) ;*/
  }
  Request _request ;
  Api api = new Api() ;
  Methods methods = new Methods() ;

  save(){
    setState(() {

    });

  }
  Future<void> onDone(String message ) async {
    // loading = false ;
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(""),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
  }
  Future<void> onError(String message ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(''),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  bool change = false ;
  String  currentDate ;
  String currentTime  ;
  String  getDataTime  () {
    var now = new DateTime.now();
    var formatter = new DateFormat('dd/MM/yyyy');
    var timeFormat =  new DateFormat( 'hh:mm')  ;
    currentDate = formatter.format(now);
    currentTime = timeFormat.format(now);
    selectDate  = currentDate +  " " +currentTime ;
    return selectDate;
    // print(formatted);
    //print(time);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return  Scaffold(
        appBar:  true ? AppBar(
          title: Text(""),
          backgroundColor:  MyColors.redColor,
        ): null,
        backgroundColor: MyColors.white,
        body:
        SingleChildScrollView(child:
        new Center(child:Container(

            color: Colors.white,
            padding: EdgeInsets.all(8.0),
            child: new Column(

                crossAxisAlignment: CrossAxisAlignment.start ,
                mainAxisSize: MainAxisSize.min,

                children: <Widget>[
                  dataTable() ,

                ]


            )))),
      bottomNavigationBar: BottomAppBar(
    child:

    _request.approved==2?

    Container(
       color:Colors.green ,
      height: 40,
      child:Center(
      child:RichText(
      text: TextSpan(

        children: [

          WidgetSpan(
            child: Icon(Icons.done_outline, color:Colors.white ,),
          ),
          TextSpan(
            text: "معتمد",
            style: TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),

          ),
        ],
      ),
    ))): Container(

    height: 40,
    child:


    Row(mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,

      children: <Widget>[
      Expanded(child:  ElevatedButton(
      child: Text('اعتماد المستند' ,style:
      TextStyle(color: MyColors.white),),
        onPressed: () {
          //  Navigator.of(context).pop();
          api.setApprove(docType:_request.requestDoc.docType ,
              reqSer: _request.prSer.toString(), onError: (String  msg ){
            print(msg) ;
          } , onApproved: ( var jsonData){
            String  serial  = jsonData['PK_SERIAL']  ;
            methods.Dialog(context: context , message: serial +"بنجاح"+" تم اعتماد المستند " ,
                isCancelBtn:false  , onOkClick: (){
              Navigator.of(context).pop();

            } , title: "" ) ;
          }  ) ;

        },
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(MyColors.redColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                    side: BorderSide(color: Colors.white)
                )
            )
        )
      ),flex: 2,
      ),]
    )
      ,

    )

      )



    );



  }


  Widget dataTable() {
    DateTime tempDate = new DateFormat("yyyy-MM-dd").parse(_request.prDate);
    String date = DateFormat("yyyy-MM-dd").format(tempDate);
    return
    new Column(
      children: [
      Table(
        border: TableBorder(horizontalInside: BorderSide(
            width: 1.0, color: MyColors.redColor),
          verticalInside: BorderSide.none,
          left: BorderSide(width: 1.0, color: MyColors.redColor),
          right: BorderSide(width: 1.0, color: MyColors.redColor),
          bottom: BorderSide(width: 1.0, color: MyColors.redColor),
          top: BorderSide(width: 1.0, color: MyColors.redColor),
        ),

        children: [
          TableRow(
              children: [
                new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("نوع المستند"),
                ),
                new Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(_request.requestDoc.name)),
              ]), TableRow(
              children: [
                new Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("رقم المستند"),
                ),
                new Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(_request.prNO.toString())),
              ]),
          TableRow(
              children: [
                new Padding(padding: EdgeInsets.all(8.0),
                  child: Text("التاريخ"),
                ),
                new Padding(padding: EdgeInsets.all(8.0),
                    child: Text(date)),
              ]),

          TableRow(
              children: [
                new Padding(padding: EdgeInsets.all(8.0),
                  child: Text("رقم المرجع "),
                ),
                new Padding(padding: EdgeInsets.all(8.0),
                    child: Text(_request.refNO.toString())),
              ]),]),
        Table(
            border: TableBorder(horizontalInside: BorderSide(
                width: 1.0, color: MyColors.redColor),
              verticalInside: BorderSide.none,
              left: BorderSide(width: 1.0, color: MyColors.redColor),
              right: BorderSide(width: 1.0, color: MyColors.redColor),
              bottom: BorderSide(width: 1.0, color: MyColors.redColor),
              top: BorderSide(width: 1.0, color: MyColors.redColor),
            ),
        children: check()
        )
      ],);


          /*    TableRow(
               children: [
                 new Padding(padding: EdgeInsets.all(8.0),
                    child:
                    new Text(
                       "Change Statues To "),
                 ),
                 new Padding(padding: EdgeInsets.all(8.0),
                     child: statuesDropDown()),
               ]),*/

  }
  int selectedStatuesID  = 0 ;
  String selectedStatues = "" ;
  bool dateBtn = false ;


  String date ;

  String noteErr =  ""  ;
  Widget createNoteEd(){
    return  new Padding(padding:new EdgeInsets.only(bottom: 8.0 , left: 40.0  , right: 40.0 , top: 8.0) ,
        child:
        new TextField(controller:  noteEd,
          obscureText: false,
          decoration: InputDecoration(
            hintText: "" ,
            hintStyle: new TextStyle(color: MyColors.white),
            fillColor: Colors.white,
            filled: false,
            errorText: noteErr,
            prefixIcon:new Icon(Icons.note , color: MyColors.white,) ,
          ) ,) );
  }
  List<TableRow> restrictTable(){ // قيود
    return
      [TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("رقم الصندوق"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.cashBankId.toString())),
          ]),
        TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("مركز التكلفه"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.costCentral)),
          ]),  TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("المبلغ"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.cashAmount.toString())),
          ]),
        TableRow(
            children: [
              new Padding(padding: EdgeInsets.all(8.0),
                child: Text("العمله"),
              ),
              new Padding(padding: EdgeInsets.all(8.0),
                  child: Text(_request.currency == null?"":_request.currency)),
            ]),
        TableRow(
            children: [
              new Padding(padding: EdgeInsets.all(8.0),
                child: Text("رقم الحساب"),
              ),
              new Padding(padding: EdgeInsets.all(8.0),
                  child: Text(_request.accountId)),
            ]),
        TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("اسم الحساب"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.accountName)),
          ]), TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("الدائن"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.credit ==0? "":_request.credit.toString())),
          ]), TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("المدين"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.debit ==0? "":_request.debit.toString())),
          ]),
      ];

  }
  List<TableRow> financialTable(){
    return
      [TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("رقم الصندوق"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.cashBankId.toString())),
          ]),

      TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("الصندوق"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.bankName)),
          ]),  TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("مركز التكلفه"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.costCentral)),
          ]),  TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("المبلغ"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.cashAmount.toString())),
          ]),
        TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("نوع الدفع"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.payType.toString())),
          ]),
        TableRow(
            children: [
              new Padding(padding: EdgeInsets.all(8.0),
                child: Text("العمله"),
              ),
              new Padding(padding: EdgeInsets.all(8.0),
                  child: Text(_request.currency == null?"":_request.currency)),
            ]),
        TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("رقم الحساب"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.accountId)),
          ]),  TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("اسم الحساب"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.accountName)),
          ]),
    ];

  }
  List<TableRow> check(){
     if(isFinancial==0){
        return storageTable() ;

     }
      else if(isFinancial==1){
        return financialTable() ;
      }
      else{
 return restrictTable()  ;
     }
  }
  List<TableRow> storageTable(){
    return
      [TableRow(
          children: [
            new Padding(padding: EdgeInsets.all(8.0),
              child: Text("رقم الصنف"),
            ),
            new Padding(padding: EdgeInsets.all(8.0),
                child: Text(_request.itemID.toString())),
          ]),
        TableRow(
            children: [
              new Padding(padding: EdgeInsets.all(8.0),
                child: Text("اسم الصنف"),
              ),
              new Padding(padding: EdgeInsets.all(8.0),
                  child: Text(_request.itemName)),
            ]),
        TableRow(
            children: [
              new Padding(padding: EdgeInsets.all(8.0),
                child: Text("الوحده"),
              ),
              new Padding(padding: EdgeInsets.all(8.0),
                  child: Text(_request.itemUnit)),
            ]),
        TableRow(
            children: [
              new Padding(padding: EdgeInsets.all(8.0),
                child: Text("الكميه"),
              ),
              new Padding(padding: EdgeInsets.all(8.0),
                  child: Text(_request.itemQty.toString())),
            ]), TableRow(
            children: [
              new Padding(padding: EdgeInsets.all(8.0),
                child: Text("السعر"),
              ),
              new Padding(padding: EdgeInsets.all(8.0),
                  child: Text(_request.itemPrice.toString())),
            ]),TableRow(
            children: [
              new Padding(padding: EdgeInsets.all(8.0),
                child: Text("المخزن"),
              ),
              new Padding(padding: EdgeInsets.all(8.0),
                  child: Text(_request.whName)),
            ]),
      ];

  }
}