import 'dart:convert';
import 'package:documentary_approval/Model/Documents.dart';
import 'package:documentary_approval/Screens/Login.dart';
import 'package:documentary_approval/Screens/Notification.dart';
import 'package:documentary_approval/Screens/Requests.dart';
import 'package:documentary_approval/Screens/Settings.dart';
import 'package:documentary_approval/Tools/Constant.dart';
import 'package:documentary_approval/my_colors.dart';
import 'package:flutter/material.dart' ;
import 'package:shared_preferences/shared_preferences.dart';

class Main  extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MainState()  ;
  }
}



class MainState extends State<Main>{
  List <Documents> list = new List();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocuments() ;
  }
  getDocuments() async {
    SharedPreferences sharedPrefs = await SharedPreferences.getInstance();
    List <String> listStr = sharedPrefs.getStringList(DOCUMENTS) ;
for(int i =  0  ;  i  <listStr.length; i++){
  String docObj  = listStr[i];
   Documents doc =    Documents.fromJsonShared(json.decode(docObj)) ;
   setState(() {
     if(doc.isCheck){
     list.add(doc) ;
     }

   });
}
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(

      appBar:  new AppBar(backgroundColor: MyColors.redColor,
      actions: [
        IconButton(
          icon: Icon(Icons.settings),
          tooltip: 'الاعدادات',
          onPressed: () {
            Navigator.push( context, MaterialPageRoute(builder: (context) => Setting())) ;

          },
        ),
        IconButton(
          icon: Icon(Icons.logout),
          tooltip: 'خروج',
          onPressed: () {
            Navigator.push( context, MaterialPageRoute(builder: (context) => Login())) ;

          },
        ),
        IconButton(
          icon: Icon(Icons.notifications),
          tooltip: 'تنبيهات',
          onPressed: () {
            Navigator.push( context, MaterialPageRoute(builder: (context) =>
                MyNotification())) ;

          },
        ),

      ],),
        body: new Container(
          child:  GridView.count(
              // crossAxisCount is the number of columns
              crossAxisCount: 2,
              // This creates two columns with two items in each column
              children: List.generate(list.length, (index) {
                return Center(
                  child:documentaryCard(list, index)
                );
              }),
            )

        )

    );

  }

  Widget  documentaryCard  (List <Documents> list  , int index) {
    Documents doc  = list[index] ;
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: InkWell(
            onTap: () {
              Navigator.push( context, MaterialPageRoute(
                  builder: (context) => Requests(doc))) ;

            },
            child: Center(
              child:Card(
                  elevation: 30,

              child: Column(
                children: [
                  Center(
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.0)),
                      elevation: 5,
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:
                        Image.asset(doc.icon , height: 60, width: 60,),
                        ),
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                       doc.name,
                        textAlign: TextAlign.center,
                        style: TextStyle(),
                      ),
                    ),
                  )
                ],
              )),
            )));


}}