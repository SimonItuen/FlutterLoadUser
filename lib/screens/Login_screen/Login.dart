import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/rendering.dart';
import 'package:load/helper/session_manager_util.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:load/model/user_model.dart';
import 'package:load/helper/base_url.dart';

import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Create_profile_screen/Create_profile.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Reset_password_screen/reset_password.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:provider/provider.dart';
import 'package:load/widgets/smart_button.dart';
import 'package:load/screens/sign_screen/sign.dart';

class Login extends StatefulWidget {
  static String routeName = '/login-screen';
  final bool fromStart;

  Login({this.fromStart = true});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var visability = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool emailValid = false;
  bool passwordValid = false;
  bool active = false;
  bool isLoading = false;
  bool isError = false;
  bool isButtonPressed = false;
  final _formKey = GlobalKey<FormState>();

  String storeId = '-1';

  Future<void> initDynamicLinks() async {
    await Future.delayed(Duration(seconds: 3));
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;

          if (deepLink != null) {
            storeId = deepLink.path.replaceAll('/', '');
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
      Provider.of<UserAccountProvider>(context, listen: false)
          .setStoreId(storeId);
      Provider.of<UserAccountProvider>(context, listen: false)
          .setOpenRestaurant(true);
    }
  }

  /*Future<void> initDynamicLinks() async {
    await Future.delayed(Duration(seconds: 3));
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
          final Uri deepLink = dynamicLink?.link;
          if (deepLink != null) {
            storeId = deepLink.path.replaceAll('/', '');
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
      Provider.of<UserAccountProvider>(context, listen: false)
          .setStoreId(storeId);
      Provider.of<UserAccountProvider>(context, listen: false)
          .setOpenRestaurant(true);
    }
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
    Future.delayed(Duration.zero, () {
    });

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then

    Navigator.of(context).pushReplacementNamed(Signscreen.routeName);
    return false; // n true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(Signscreen.routeName);
            }),
        title: Text(
          'Login',
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'OpenSans-Semibold',
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Mycolors.red,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) =>
              Container(
                width: viewportConstraints.maxWidth,
                color: Colors.white,
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  children: [
                    BackdropBg(),
                    /*Container(
                      width: width,
                      color: Mycolors.red,
                    ),*/
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        AbsorbPointer(
                          absorbing: isLoading,
                          child: Container(
                            width: width,
                            margin: EdgeInsets.only(top: 40),
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(top: 25),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        Theme(
                                          data: ThemeData(
                                            primaryColor: Mycolors.red,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            child: TextFormField(
                                              onChanged: (value) {
                                                isButtonPressed = false;
                                                if (isError) {
                                                  _formKey.currentState
                                                      .validate();
                                                }
                                                emailValid =
                                                    RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                            .hasMatch(value) &&
                                                        value.trim().isNotEmpty;
                                                setState(() {
                                                  active = emailValid &&
                                                      passwordValid;
                                                });
                                              },
                                              controller: emailController,
                                              decoration: new InputDecoration(
                                                labelText: "Email",
                                                labelStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'OpenSans-Regular',
                                                    color: Mycolors.red),
                                                fillColor: Colors.white,

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Mycolors.red)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          14.0),
                                                  borderSide: new BorderSide(
                                                      color: Colors.red),
                                                ),

                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          14.0),
                                                  borderSide: new BorderSide(
                                                      color: Colors.red),
                                                ),
                                                //fillColor: Colors.green
                                              ),
                                              validator: (val) {
                                                if (!isButtonPressed) {
                                                  return null;
                                                }
                                                isError = true;
                                                if (val.length == 0) {
                                                  return "Email cannot be empty";
                                                } else {
                                                  if (!RegExp(
                                                          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                      .hasMatch(val)) {
                                                    return "Not a valid email";
                                                  } else {
                                                    return null;
                                                  }
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              style: new TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'OpenSans-Regular',
                                                  color: Mycolors.dark2),
                                            ),
                                          ),
                                        ),
                                        Theme(
                                          data: ThemeData(
                                            primaryColor: Mycolors.red,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 16, vertical: 10),
                                            child: TextFormField(
                                              onChanged: (value) {
                                                isButtonPressed = false;
                                                if (isError) {
                                                  _formKey.currentState
                                                      .validate();
                                                }
                                                if (value.length > 5) {
                                                  passwordValid = true;
                                                } else {
                                                  passwordValid = false;
                                                }
                                                setState(() {
                                                  active = emailValid &&
                                                      passwordValid;
                                                });
                                              },
                                              controller: passwordController,
                                              obscureText:
                                                  !visability ? true : false,
                                              decoration: new InputDecoration(
                                                labelText: "Password",
                                                labelStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily:
                                                        'OpenSans-Regular',
                                                    color: Mycolors.red),

                                                fillColor: Colors.white,

                                                enabledBorder:
                                                    OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(14),
                                                        borderSide: BorderSide(
                                                            color:
                                                                Mycolors.red)),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          14.0),
                                                  borderSide: new BorderSide(
                                                      color: Colors.red),
                                                ),
                                                suffixIcon: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        visability =
                                                            !visability;
                                                      });
                                                    },
                                                    child: !visability
                                                        ? Icon(Icons
                                                            .visibility_off)
                                                        : Icon(
                                                            Icons.visibility)),
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          14.0),
                                                  borderSide: new BorderSide(
                                                      color: Colors.red),
                                                ),
                                                //fillColor: Colors.green
                                              ),
                                              validator: (val) {
                                                if (!isButtonPressed) {
                                                  return null;
                                                }
                                                isError = true;
                                                if (val.length < 6) {
                                                  return "Password must contain at least 6 characters";
                                                } else {
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.emailAddress,
                                              style: new TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'OpenSans-Regular',
                                                  color: Mycolors.dark2),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 16),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              InkWell(
                                                onTap: () {
                                                  Navigator.of(context)
                                                      .pushNamed(Resetscreen
                                                          .routeName);
                                                },
                                                child: Text(
                                                  "Forgot Password?",
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontFamily:
                                                          'OpenSans-Regular',
                                                      color: Mycolors.red),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SmartButton(
                                          active: active,
                                          isLoading: isLoading,
                                          text: 'Login',
                                          onPressed: () {
                                            isButtonPressed = true;
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            postLogin(context);
                                          },
                                          inactiveOnpressed: () {
                                            isButtonPressed = true;
                                            _formKey.currentState.validate();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Container(
                                    width: width,
                                    padding: const EdgeInsets.all(4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(12),
                                          bottomRight: Radius.circular(12)),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.1),
                                          spreadRadius: 2,
                                          blurRadius: 5,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                      color: Colors.white,
                                    ),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Don't have an account? ",
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: 'OpenSans-Regular',
                                                color: Mycolors.dark2),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              if (!widget.fromStart) {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        Signscreen.routeName);
                                              } else {
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        Signscreen.routeName);
                                              }
                                            },
                                            child: Text(
                                              "Register",
                                              style: TextStyle(
                                                  fontSize: 14,
                                                  fontFamily:
                                                      'OpenSans-Regular',
                                                  color: Mycolors.red),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Visibility(
                          visible: isLoading,
                          child: Container(
                              color: Color(0x99000000),
                              child: Center(
                                child: CircularProgressIndicator(),
                              )),
                        )
                      ],
                    )
                  ],
                ),
              )),
    );
  }

  postLogin(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
      setState(() {
        isLoading = true;
      });
      String url = BaseUrl.baseUrl + '/login';

      var map = convert.jsonEncode(<String, String>{
        'email': emailController.text,
        'password': passwordController.text,
      });

      try {
        http.Response response = await http.post(url,
            headers: {
              "Content-Type": "application/json",
              "X-Requested-With": "XMLHttpRequest"
            },
            body: map);


        if (response.statusCode == 200) {

          var jsonResponse = convert.jsonDecode(response.body);
          if (jsonResponse['success'].toString() == 'true') {
            Map<String, dynamic> map = jsonResponse['data'];
            UserModel model = UserModel.fromJson(map);
            _accountProvider.setUserDetails(model);
            loadGetHelp();
            SessionManagerUtil.putString('apiToken', '${model.apiToken}');
            SessionManagerUtil.putString('status', '${model.status}');
            SessionManagerUtil.putInt('id', model.id);
            SessionManagerUtil.putString('name', '${model.name}');
            SessionManagerUtil.putString('email', '${model.email}');
            SessionManagerUtil.putString('role', '${model.role}');
            SessionManagerUtil.putString('phone', '${model.phone}');
            SessionManagerUtil.putString('profilePhoto', '${model.profileImg}');

            Navigator.of(context).pushReplacementNamed(Homescreen.routeName);
            setState(() {
              isLoading = false;
            });
          } else {
            if (jsonResponse.toString().isNotEmpty) {
              final snackBar = SnackBar(
                content: Text(jsonResponse['message']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', '')),
                duration: Duration(seconds: 4),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              setState(() {
                isLoading = false;
              });
            }
          }
        } else {
          var jsonResponse = convert.jsonDecode(response.body);
          if (jsonResponse.toString().isNotEmpty) {
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(seconds: 4),
            );
            Scaffold.of(context).showSnackBar(snackBar);
            setState(() {
              isLoading = false;
            });
          } else {
            final snackBar = SnackBar(
              content: Text('Couldn\'t Connect, please try again'),
              duration: Duration(seconds: 4),
            );
            Scaffold.of(context).showSnackBar(snackBar);
          }
          setState(() {
            isLoading = false;
          });
        }
      } on TimeoutException catch (e) {
        final snackBar = SnackBar(
          content: Text('Timeout Error: ${e.message}'),
          duration: Duration(seconds: 4),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      } on SocketException catch (e) {
        final snackBar = SnackBar(
          content: Text('Socket Error: ${e.message}'),
          duration: Duration(seconds: 4),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      } on Error catch (e) {
        final snackBar = SnackBar(
          content: Text('General Error: ${e}'),
          duration: Duration(seconds: 4),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  loadGetHelp() async {
    String url = BaseUrl.baseUrl + '/get-help';

    try {
      http.Response response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        },
      );


      if (response.statusCode == 200) {

        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {
          String getHelp = jsonResponse['data']['phone_number'].toString();
          UserAccountProvider _accountProvider =
              Provider.of<UserAccountProvider>(context, listen: false);
          _accountProvider.setHelpLine(getHelp);
          SessionManagerUtil.putString('getHelp', getHelp);


        } else {
          if (jsonResponse.toString().isNotEmpty) {
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(seconds: 4),
            );
          }
        }
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          final snackBar = SnackBar(
            content: Text(jsonResponse['message']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', '')),
            duration: Duration(seconds: 4),
          );
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
        }
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
    }
  }
}
