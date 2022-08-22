

import 'dart:convert';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:documentary_approval/Model/Documents.dart';
import 'package:documentary_approval/Model/Request.dart';
import 'package:documentary_approval/Model/User.dart';
import 'package:documentary_approval/Tools/Constant.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'  as http ;
import 'package:shared_preferences/shared_preferences.dart';


class Api  {

  Future login({String userId , String password  ,  String orgId, Function  onLogin  , Function onError}  )async{
    User mUser = new User.login(userId , password , orgId) ;
    String mobileMacID  = await _getId();
     print(USERS_LOGIN) ;
    http.post(USERS_LOGIN ,body  : mUser.toMap(mobileMacID) ) .then((http.Response response) {
      print(response)  ;
      print(response.statusCode)  ;
      print(response.body)  ;
      if(response.statusCode == 200) {
        String jsonStr = json.decode(response.body);
        var jsonObj = json.decode(jsonStr);
        print(jsonObj)  ;

       String  msg  = jsonObj['Msg']  ;
        print(msg)  ;
        if(msg  == "Success") {
          print(jsonObj) ;
          User c = User.fromJson(jsonObj,userId , password , orgId ) ;
          onLogin(c)  ;
          return c ;
        }
        else
        {
         onError(msg) ;
          return null  ;
        }
      }
      else {
        onError("Connection Error") ;
        return null ;
      }

    }
    );

  }
  Future setApprove({ Function  onApproved  , Function onError , int docType , String reqSer}  )async{
    SharedPreferences   sharedPrefs = await SharedPreferences.getInstance();
  User  user = User.fromJsonShared(json.decode( sharedPrefs.getString("user") )) ;
    var map = new Map<String, dynamic>();
    map["FuncationType"]  = "SET_REQ_APROVIED" ;
    map["Org_id"] = user.orgId ;
    map["User_id"]  = user.userId;
   map[ "PK_Serial"]=reqSer;
   map["Apv_Comment"] = "تم الاعتماد عبر API" ;
   map[ "DocType"]= docType.toString();

    http.post(DOC_REQ , body  : map ).then((http.Response response) {
      print(response)  ;
      print(response.statusCode)  ;
      print(response.body)  ;
      if(response.statusCode == 200) {
       // var jsonStr = json.decode(response.body);
        var jsonObj = json.decode(response.body);
        print(jsonObj)  ;

        String  msg  = jsonObj['message']  ;
        String  serial  = jsonObj['PK_SERIAL']  ;
        print(msg)  ;
        if(msg  == "success") {
        onApproved(jsonObj);
        }
        else
        {
          onError(msg) ;
          return null  ;
        }
      }
      else {
        onError("Connection Error") ;
        return null ;
      }

    }
    );

  }
  Future  getDocList({String userId ,
    String orgId, String functionName ,
    Function  onSuccess
    , Function onError}  )async{
    Documents doc = new Documents() ;
    List<Request>requests  = new List() ;
    print(functionName) ;
    String url = DOC_REQ  ;
    if( (functionName == "Get_REQ_PUR_REQ") ||( functionName == "Get_REQ_CLNT_PRICE_ORDER" )){
        url  = DOC_REQ_NEW  ;
        print(true);

     }
    else{
      print(false);
    }
    print(url) ;

    http.post(url ,body  :jsonEncode(doc.docReq(orgId, userId , functionName))  ,
        headers: {
         "Accept": "application/json",
         "content-type":"application/json"
        })
        .then((http.Response response) {
      print(response)  ;
      print(response.statusCode)  ;
      print(response.body)  ;
      if(response.statusCode == 200) {
        String jsonStr = json.decode(response.body);
        var jsonObj = json.decode(jsonStr);
        print(jsonObj)  ;
        var result ;
        var resultDtl ;
        if (functionName == "Get_REQ_PUR_REQ"){
         result  =  jsonObj["JS_PUR_REQ_MST"] ;
         resultDtl  =  jsonObj["JS_PUR_REQ_DTL"] ;
         for (int i  =  0  ; i <result.length  ; i++) {
           Request  request =  Request.fromJson(result[i])  ;
           Request  requestDtl  =  request.fromJsPurORDRDtl(resultDtl[i]) ;
           requests.add( requestDtl) ;
               
           
         }
        }
        else if (functionName == "Get_REQ_PUR_ORDER"){
          result  =  jsonObj["JS_PUR_ORDR_MST"] ;
          resultDtl  =  jsonObj["JS_PUR_ORDR_DTL"] ;
          for (int i  =  0  ; i <result.length  ; i++) {
            Request  request =  Request.fromJsPurORDR(result[i])  ;
            Request  requestDtl  =  request.fromJsPurORDRDtl(resultDtl[i]) ;
            requests.add( requestDtl) ;
          }
        }
        else if (functionName == "Get_REQ_CLNT_ORDER"){ //done
          result  =  jsonObj["JS_AR_ORDR_MST"] ;
          resultDtl  =  jsonObj["JS_AR_ORDR_DTL"] ;
          for (int i  =  0  ; i <result.length  ; i++) {
            Request  request =  Request.fromJsonClient(result[i])  ;
            Request  requestDtl  =  request.fromJsPurORDRDtl(resultDtl[i]) ;
            requests.add( requestDtl) ;          }

        } else if (functionName == "Get_REQ_CLNT_PRICE_ORDER"){
          result  =  jsonObj["JS_AR_ORD_PRICE_MST"] ;
          resultDtl  =  jsonObj["JS_AR_ORD_PRICE_DTL"] ;
          for (int i  =  0  ; i <result.length  ; i++) {
            Request  request =  Request.fromJsPriceORDR(result[i])  ;
            Request  requestDtl  =  request.fromJsPurORDRDtl(resultDtl[i]) ;
            requests.add( requestDtl) ;
          }

        }

        else if (functionName == "Get_REQ_VCHR_ORDER_PAY"){
          result  =  jsonObj["JS_ORDVCHR_MST_PAY"] ;
          resultDtl  =  jsonObj["JS_ORDVCHR_DTL_PAY"] ;
          for (int i  =  0  ; i <result.length  ; i++) {
            Request  request =  Request.fromJsonPay(result[i])  ;
            Request  requestDtl  =  request.fromJsFinancialDtl(resultDtl[i]) ;
            requests.add( requestDtl) ;
          }
        }
        else if (functionName == "Get_REQ_VCHR_ORDER_CATCH"){
          result  =  jsonObj["JS_ORDVCHR_MST_CATCH"] ;
          resultDtl  =  jsonObj["JS_ORDVCHR_DTL_CATCH"] ;
          for (int i  =  0  ; i <result.length  ; i++) {
            Request  request =  Request.fromJsonPay(result[i])  ;
            Request  requestDtl  =  request.fromJsFinancialDtl(resultDtl[i]) ;
            requests.add( requestDtl) ;
          }
        }else if (functionName == "Get_REQ_JRNL_ORDER"){
          result  =  jsonObj["JS_ORDJRNL_MST"] ;
          resultDtl  =  jsonObj["JS_ORDJRNL_DTL"] ;
          for (int i  =  0  ; i <result.length  ; i++) {
            Request  request =  Request.fromJsonJ(result[i])  ;
            Request  requestDtl  =  request.fromJsJDtl(resultDtl[i]) ;
            requests.add( requestDtl);
          }
        }
        onSuccess(requests)  ;
      }
      else {
        onError("Connection Error") ;
        return null ;
      }

    }
    );

  }
  Future<String> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) { // import 'dart:io'
      var iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    } else {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.androidId; // unique ID on Android
    }
  }
}