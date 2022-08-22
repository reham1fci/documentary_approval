import 'package:documentary_approval/Screens/Main.dart';
import 'package:documentary_approval/Screens/Settings.dart';
import 'package:documentary_approval/Screens/Splash.dart';
import 'package:documentary_approval/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(new MaterialApp(
  debugShowCheckedModeBanner: false,
  localizationsDelegates: [
    AppLocalizations.delegate,
    // Built-in localization of basic text for Material widgets
    GlobalMaterialLocalizations.delegate,
    // Built-in localization for text direction LTR/RTL
    GlobalWidgetsLocalizations.delegate,
  ],
  supportedLocales: [
    Locale('en'),
    Locale('ar'),
  ],
  home: new Splash(),
));
