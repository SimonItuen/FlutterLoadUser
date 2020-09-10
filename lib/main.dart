import 'package:flutter/material.dart';
import 'package:load/screens/splash_screen/splash.dart';

import 'helper/colors.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          headline1: TextStyle(fontSize: 22,fontFamily: 'OpenSans-Regular',color: Mycolors.dark),
          headline2: TextStyle(fontSize: 32,fontFamily: 'OpenSans-Regular',color: Mycolors.dark),
          headline3: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Colors.white),
        ),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splashscreen(),
    );
  }
}
