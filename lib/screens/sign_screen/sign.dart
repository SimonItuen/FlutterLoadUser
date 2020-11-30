import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/screens/verification_screen/verification.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:load/helper/session_manager_util.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:provider/provider.dart';

class Signscreen extends StatefulWidget {
  static String routeName = '/sign-screen';

  @override
  _SignscreenState createState() => _SignscreenState();
}

class _SignscreenState extends State<Signscreen> {
  PageController controller = PageController(initialPage: 0);
  TextEditingController phoneController = TextEditingController();
  bool active = false;
  final _formKey = GlobalKey<FormState>();
  bool isError = false;
  bool isButtonPressed = false;
  double bottomPadding = 0;
  String storeId = '-1';
  var timer;
  int _currentPage = 0;

  Future<void> initDynamicLinks() async {
    await Future.delayed(Duration(seconds: 3));
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        print('deepLink');
        storeId = deepLink.path.replaceAll('/', '');
        print(storeId);
        Provider.of<UserAccountProvider>(context, listen: false)
            .setStoreId(storeId);
        Provider.of<UserAccountProvider>(context, listen: false)
            .setOpenRestaurant(true);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      storeId = deepLink.path.replaceAll('/', '');
      print(storeId);
      Provider.of<UserAccountProvider>(context, listen: false)
          .setStoreId(storeId);
      Provider.of<UserAccountProvider>(context, listen: false)
          .setOpenRestaurant(true);
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      controller.animateToPage(_currentPage,
          duration: Duration(milliseconds: 300), curve: Curves.easeIn);
    });
  }

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: Container(
              width: width,
              height: height,
              color: Mycolors.red,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: width,
                height: height,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Mycolors.red, Mycolors.red_lower]),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: PageView(
                        onPageChanged: _onPageChanged,
                        controller: controller,
                        physics: BouncingScrollPhysics(),
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            //color: Colors.black,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: width,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/Rectangle 203.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Text(
                                            "Title One",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily:
                                                    'BAHNSCHRIFT-regular',
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "Lorem ipsum dolour sadipscing elitr, sed diam \nnonumy eirmod tempor invidunt ut labore et dolore",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily:
                                                    'BAHNSCHRIFT-regular',
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            //color: Colors.black,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: width,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/Rectangle 203.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Text(
                                            "Title Two",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily:
                                                    'BAHNSCHRIFT-regular',
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "Lorem ipsum dolour sadipscing elitr, sed diam \nnonumy eirmod tempor invidunt ut labore et dolore",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily:
                                                    'BAHNSCHRIFT-regular',
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            //color: Colors.black,
                            child: Column(
                              children: <Widget>[
                                Column(
                                  children: <Widget>[
                                    Container(
                                      width: width,
                                      child: Column(
                                        children: [
                                          Center(
                                            child: Image.asset(
                                              'assets/Rectangle 203.png',
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                          Text(
                                            "Title Three",
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontFamily:
                                                    'BAHNSCHRIFT-regular',
                                                color: Colors.white),
                                          ),
                                          Text(
                                            "Lorem ipsum dolour sadipscing elitr, sed diam \nnonumy eirmod tempor invidunt ut labore et dolore",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily:
                                                    'BAHNSCHRIFT-regular',
                                                color: Colors.white),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SmoothPageIndicator(
                            controller: controller,
                            count: 3,
                            axisDirection: Axis.horizontal,
                            effect: SlideEffect(
                                spacing: 8.0,
                                radius: 81.0,
                                dotWidth: 16.0,
                                dotHeight: 4.0,
                                paintStyle: PaintingStyle.fill,
                                strokeWidth: 1.5,
                                dotColor: Mycolors.white.withOpacity(0.3),
                                activeDotColor: Mycolors.white),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.36406,
                      padding: EdgeInsets.only(left: 14, right: 11, top: 20),
                      width: width,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset:
                                  Offset(0, 3), // changes position of shadow
                            ),
                          ],
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12))),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Container(
                              width: 40,
                              height: 2,
                              color: Mycolors.red,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: Text(
                              "Get Started with Load",
                              style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: 'BAHNSCHRIFT-regular',
                                  color: Colors.black),
                            ),
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Enter your mobile number",
                                style: TextStyle(
                                    fontSize: 13,
                                    fontFamily: 'BAHNSCHRIFT-regular',
                                    color: Colors.black),
                              ),
                              Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Container(
                                      width: width,
                                      margin: EdgeInsets.only(right: 10),
                                      child: Center(
                                        child: Theme(
                                          data: ThemeData(
                                              primaryColor: active
                                                  ? Mycolors.red
                                                  : Mycolors.red_light),
                                          child: Form(
                                            key: _formKey,
                                            child: Stack(
                                              alignment: AlignmentDirectional
                                                  .centerEnd,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 50),
                                                  child: TextFormField(
                                                    onChanged: (value) {
                                                      isButtonPressed = false;
                                                      if (isError) {
                                                        _formKey.currentState
                                                            .validate();
                                                      }
                                                      setState(() {
                                                        active = value
                                                                .trim()
                                                                .isNotEmpty &&
                                                            phoneController.text
                                                                    .trim()
                                                                    .length ==
                                                                8;
                                                      });
                                                    },
                                                    validator: (val) {
                                                      if (!isButtonPressed) {
                                                        setState(() {
                                                          bottomPadding = 0;
                                                        });
                                                        return null;
                                                      }
                                                      isError = true;
                                                      if (val.length == 0) {
                                                        setState(() {
                                                          bottomPadding = 16;
                                                        });
                                                        return "Phone Number cannot be empty";
                                                      }
                                                      if (val.length > 0 &&
                                                          val.trim().length !=
                                                              8) {
                                                        setState(() {
                                                          bottomPadding = 16;
                                                        });
                                                        return "Phone Number should be 8 digit";
                                                      } else {
                                                        setState(() {
                                                          bottomPadding = 0;
                                                        });
                                                        return null;
                                                      }
                                                      isError = false;
                                                    },
                                                    inputFormatters: [
                                                      LengthLimitingTextInputFormatter(
                                                          8),
                                                    ],
                                                    controller: phoneController,
                                                    keyboardType:
                                                        TextInputType.phone,
                                                    style: TextStyle(
                                                        fontSize: 23,
                                                        fontFamily:
                                                            'BAHNSCHRIFT-regular',
                                                        color: Colors.black),
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.only(
                                                              top: 10,
                                                              right: 20),
                                                      prefixIcon: Icon(
                                                          Icons.phone_android),
                                                      hintStyle: TextStyle(
                                                          fontSize: 23,
                                                          fontFamily:
                                                              'BAHNSCHRIFT-regular',
                                                          color: Colors.black),
                                                      hintText: 'Mobile number',
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(12),
                                                          borderSide: BorderSide(
                                                              color: active
                                                                  ? Mycolors.red
                                                                  : Mycolors
                                                                      .red_light,
                                                              width: 2)),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(12.0),
                                                        borderSide: new BorderSide(
                                                            color: active
                                                                ? Mycolors.red
                                                                : Mycolors
                                                                    .red_light,
                                                            width: 2),
                                                      ),
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(12.0),
                                                        borderSide: new BorderSide(
                                                            color: active
                                                                ? Mycolors.red
                                                                : Mycolors
                                                                    .red_light,
                                                            width: 2),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 80,
                                                  height: 80,
                                                  margin: EdgeInsets.only(
                                                      bottom: bottomPadding),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.black
                                                            .withOpacity(0.1),
                                                        spreadRadius: 2,
                                                        blurRadius: 5,
                                                        offset: Offset(0,
                                                            3), // changes position of shadow
                                                      ),
                                                    ],
                                                  ),
                                                  child: Center(
                                                    child: InkWell(
                                                      onTap: active
                                                          ? () async {
                                                              isButtonPressed =
                                                                  true;
                                                              UserAccountProvider
                                                                  _accountProvider =
                                                                  Provider.of<
                                                                          UserAccountProvider>(
                                                                      context,
                                                                      listen:
                                                                          false);
                                                              _accountProvider
                                                                  .setTempPhone(
                                                                      phoneController
                                                                          .text
                                                                          .toString());
                                                              Navigator.of(
                                                                      context)
                                                                  .pushNamed(
                                                                      Verificationscreen
                                                                          .routeName);
                                                            }
                                                          : () {
                                                              isButtonPressed =
                                                                  true;
                                                              _formKey
                                                                  .currentState
                                                                  .validate();
                                                            },
                                                      child: Container(
                                                        width: 70,
                                                        height: 70,
                                                        decoration: BoxDecoration(
                                                            shape:
                                                                BoxShape.circle,
                                                            color: active
                                                                ? Mycolors
                                                                    .red_dark
                                                                : Mycolors
                                                                    .red_light),
                                                        child: Center(
                                                          child: Icon(
                                                            Icons.arrow_forward,
                                                            size: 40,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Container(),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have an account? ",
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'BAHNSCHRIFT-regular',
                                      color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed(Login.routeName);
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'BAHNSCHRIFT-regular',
                                        color: Mycolors.red),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
