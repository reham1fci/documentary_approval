import 'dart:convert';

import 'package:documentary_approval/Model/Documents.dart';
import 'package:documentary_approval/Tools/Constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../my_colors.dart';

class Setting extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return  new SettingState();
  }


}
class SettingState extends State<Setting>{
  bool _isChecked = true;
  String _currText = '';


  List<Documents> documentsList  = new List() ;
  List <String> listStr  ;
  SharedPreferences sharedPrefs ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDocuments() ;
  }

  getDocuments() async {
     sharedPrefs = await SharedPreferences.getInstance();
   listStr = sharedPrefs.getStringList(DOCUMENTS) ;
    for(int i =  0  ;  i  <listStr.length; i++){
      String docObj  = listStr[i];
      Documents doc =    Documents.fromJsonShared(json.decode(docObj)) ;
      setState(() {
        documentsList.add(doc) ;

      });
    }
  }
  editDoc( int  index , bool  newVal){
    Documents doc =    Documents.fromJsonShared(json.decode(listStr[index])) ;
    doc.isCheck =newVal ;
    String docSt  =json.encode(doc.toSharedJson()) ;
    setState(() {
      listStr.replaceRange(index, index + 1, [docSt]);
      sharedPrefs.setStringList(DOCUMENTS , listStr );
      sharedPrefs.commit() ;

    });


  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return

      new Scaffold(
        appBar:
        new AppBar(backgroundColor: MyColors.redColor,),
        body:
        ListView.builder(
        itemCount:documentsList.length ,
        itemBuilder: (BuildContext context,int index) {
          return listCard(index);
        }

    )
       );
  }




  Widget listCard( int index ){
    Documents doc = documentsList[index] ;

   return  CheckboxListTile(
     activeColor: MyColors.redColor,
           title:  Text(doc.name),
           value: doc.isCheck,
           onChanged: (bool value) {
           setState(() {
             doc.isCheck = value ;
             editDoc(index, value) ;
          });
        }
    ) ;
  }
}