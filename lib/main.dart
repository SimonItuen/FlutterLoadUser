import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:load/screens/Create_profile_screen/Create_profile.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/screens/Reset_password_screen/reset_password.dart';
import 'package:load/screens/Resturant_detail_screen/Resturant_detail.dart';
import 'package:load/screens/change_number_screen/change_number.dart';
import 'package:load/screens/change_password_screen/change_password.dart';
import 'package:load/screens/change_password_screen_from_settings/change_password_from_settings.dart';
import 'package:load/screens/check_password_otp_screen/check_password_otp.dart';
import 'package:load/screens/sign_screen/sign.dart';
import 'package:load/screens/splash_screen/splash.dart';
import 'package:load/screens/verification_screen/verification.dart';
import 'package:provider/provider.dart';
import 'package:load/providers/user_account_provider.dart';

import 'helper/colors.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserAccountProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryTextTheme: TextTheme(
          headline1: TextStyle(
              fontSize: 22,
              fontFamily: 'OpenSans-Regular',
              color: Mycolors.dark),
          headline2: TextStyle(
              fontSize: 32,
              fontFamily: 'BAHNSCHRIFT-regular',
              color: Mycolors.dark),
          headline6: TextStyle(
              fontSize: 117,
              fontFamily: 'BAHNSCHRIFT-regular',
              color: Mycolors.dark),
          headline4: TextStyle(
              fontSize: 23,
              fontFamily: 'OpenSans-Semibold',
              color: Mycolors.dark),
          headline5: TextStyle(
              fontSize: 32,
              fontFamily: 'BAHNSCHRIFT-regular',
              color: Mycolors.dark),
          headline3: TextStyle(
              fontSize: 16,
              fontFamily: 'OpenSans-Semibold',
              color: Colors.white),
        ),
        primarySwatch: appThemeRed,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (_) => Splashscreen(),
        Signscreen.routeName: (_) => Signscreen(),
        Homescreen.routeName: (_) => Homescreen(),
        Login.routeName: (_) => Login(),
        Verificationscreen.routeName: (_) => Verificationscreen(),
        Createprofile.routeName: (_) => Createprofile(),
        Resetscreen.routeName: (_) => Resetscreen(),
        Resturantdetails.routeName: (_) => Resturantdetails(),
        CheckOtpPasswordscreen.routeName: (_) => CheckOtpPasswordscreen(),
        ChangePassword.routeName: (_) => ChangePassword(),
        ChangePasswordFromSetting.routeName: (_) => ChangePasswordFromSetting(),
        ChangeNumber.routeName: (_) => ChangeNumber(),
      },

    );
  }

  MaterialColor appThemeRed = const MaterialColor(
    0XFFEE4036,
    const <int, Color>{
      50: const Color(0XFFEE4036),
      100: const Color(0XFFEE4036),
      200: const Color(0XFFEE4036),
      300: const Color(0XFFEE4036),
      400: const Color(0XFFEE4036),
      500: const Color(0XFFEE4036),
      600: const Color(0XFFEE4036),
      700: const Color(0XFFEE4036),
      800: const Color(0XFFEE4036),
      900: const Color(0XFFEE4036),
    },
  );

  @override
  void initState() {
    super.initState();
  }
}
