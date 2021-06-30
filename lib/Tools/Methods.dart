import 'dart:io';
import 'package:flutter/material.dart' hide Image;
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';


class Methods {
  Future<void> Dialog({BuildContext context , String title  , String message   , bool isCancelBtn ,Function onOkClick , Function onCancelClick}) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
                onOkClick();
              },
            ),
           isCancelBtn? FlatButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
                 onCancelClick();
              },
            ):SizedBox(),
          ],
        );
      },
    );
  }
  Future<void> checkInternet( Function onConnect , Function notConnected) async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        onConnect() ;
      }
    } on SocketException catch (_) {
      print('not connected');
      notConnected() ;
    }

  }
   static List<String>  getDateTime( int lateHour) {
    List<String> dates = new List() ;
    var now = new DateTime.now();
    String  timeFormat = new DateFormat('hh:mm:ss a').format(now);
    var duration = new Duration(hours : lateHour);
    var date  =  now.add(duration)  ;
    String dateFormat  = new DateFormat('dd/MM/yyyy').format(date)  ;
    dates.add(dateFormat +" " +timeFormat)  ;
    dates.add(dateFormat)  ;
    return dates;



  }


}