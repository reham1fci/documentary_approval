import 'package:documentary_approval/my_colors.dart';
import 'package:flutter/material.dart';

class MyNotification extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return NotificationState();
  }
}
class NotificationState extends State<MyNotification>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
        appBar:
        new AppBar(backgroundColor: MyColors.redColor,),
      body: new Container(),
    );
  }


}