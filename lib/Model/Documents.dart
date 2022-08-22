import 'dart:convert';

import 'package:documentary_approval/Screens/Settings.dart';

class Documents  {

  String name  ;
  String icon ;
  bool isCheck  ;
  String functionApiName  ;
   int docType  ;

  Documents({this.name, this.isCheck , this.icon , this.functionApiName , this.docType});

  factory Documents.fromJsonShared (Map<String  ,dynamic> json ){
    return Documents(
        name:json['d_name'] ,
        isCheck:json['d_isCheck'] ,
        icon:json['d_icon'] ,
        functionApiName:json['f_name'] ,
      docType:json['docType'] ,

    );
  }
  Map<String, dynamic> toSharedJson( ) {
    return {
      "d_name": this.name,
      "d_isCheck": this.isCheck ,
      "d_icon": this.icon ,
      "f_name": this.functionApiName ,
      "docType": this.docType ,
    };
  }
  Map docReq(String orgId , String userId , String functionName) {
    var map = new Map<String, dynamic>();
    map["FuncationType"]  = functionName ;
    map["Org_id"] = orgId ;
    map["User_id"]  = userId;
    return map;
  }
   static List<String> createDocumentsList(){
  List <String>list  = new List()  ;
    Documents d  = new Documents(functionApiName:"Get_REQ_PUR_REQ",name  :"طلبات الشراء",isCheck: true , icon: 'images/purchase_req_icon.jpg' , docType: 1) ;
    list.add(json.encode(d.toSharedJson()));
  Documents d2  = new Documents(functionApiName:"Get_REQ_PUR_ORDER",name  :"أوامر الشراء",isCheck: true , icon:'images/purchase_order.jpg', docType: 2 ) ;
  list.add(json.encode(d2.toSharedJson()));
 // Documents d3  = new Documents(functionApiName:"",name  :"طلب تحويل كميات",isCheck: true , icon:'images/convert_data.png' ) ;
 // list.add(json.encode(d3.toSharedJson()));
  Documents d4  = new Documents(functionApiName:"Get_REQ_CLNT_ORDER",name  :"طلبات العملاء",isCheck: true , icon:'images/clients.png' , docType:  3) ;
  list.add(json.encode(d4.toSharedJson()));
  Documents d5  = new Documents(functionApiName:"Get_REQ_CLNT_PRICE_ORDER",name  :"عروض الأسعار",isCheck: true ,icon:'images/prices.png', docType: 4 ) ;
  list.add(json.encode(d5.toSharedJson()));
  Documents d6  = new Documents(functionApiName:"Get_REQ_VCHR_ORDER_PAY",name  :"طلب صرف مالي",isCheck: true ,icon: 'images/exchange.png', docType: 6) ;
  list.add(json.encode(d6.toSharedJson()));
  Documents d7  = new Documents(functionApiName:"Get_REQ_VCHR_ORDER_CATCH",name  :"طلب قبض مالي",isCheck: true , icon: 'images/take.png' ,docType: 5) ;
  list.add(json.encode(d7.toSharedJson()));
  Documents d8  = new Documents(functionApiName:"Get_REQ_JRNL_ORDER",name  :"طلب قيود مالية",isCheck: true , icon: 'images/restrictions.png', docType: 7) ;
  list.add(json.encode(d8.toSharedJson()));
  return list  ;

  }
}