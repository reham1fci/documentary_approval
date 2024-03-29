import 'package:documentary_approval/app_localizations.dart';
import 'package:documentary_approval/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'Login.dart';

class Splash extends StatefulWidget {
  @override
  _MySplashState createState() => new _MySplashState();
}

class _MySplashState extends State<Splash> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return

      new SplashScreen(
          backgroundColor: MyColors.grey,
          seconds: 5,
          navigateAfterSeconds:  Login(),
          title: new Text( AppLocalizations.of(context).translate("app_name"),
            style: new TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0 ,
                color: MyColors.redColor
            ),),
          //  image: new Image.network('https://i.imgur.com/TyCSG9A.png'),
          image: Image.asset('images/logo2.png' ),
          photoSize: 100.0,
          styleTextUnderTheLoader: new TextStyle(),
          // onClick: ()=>print("Flu tter Egypt"),
          loaderColor: MyColors.redColor
      );
  }
}
