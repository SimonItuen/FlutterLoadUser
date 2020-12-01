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
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/screens/Reset_password_screen/reset_password.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:provider/provider.dart';
import 'package:load/widgets/smart_button.dart';
import 'package:load/screens/sign_screen/sign.dart';

class ChangePassword extends StatefulWidget {
  static String routeName = '/change-password-screen';

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  var visability = false;
  var confirmVisability = false;
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool confirmPasswordValid = false;
  bool passwordValid = false;
  bool active = false;
  bool isLoading = false;
  bool isError = false;
  bool isButtonPressed = false;
  final _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }  @override
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
              Navigator.pop(context);
            }),
        title: Text(
          'Reset Password',
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
                                                isButtonPressed=false;
                                                if(isError){
                                                  _formKey.currentState.validate();
                                                }
                                                if (value.length > 5) {
                                                  passwordValid = true;
                                                } else {
                                                  passwordValid = false;
                                                }
                                                setState(() {
                                                  active =
                                                      confirmPasswordValid && passwordValid;
                                                });
                                              },
                                              controller: passwordController,
                                              obscureText: !visability ? true :false ,
                                              decoration: new InputDecoration(
                                                labelText: "New Password",
                                                labelStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'OpenSans-Regular',
                                                    color: Mycolors.red),
                                                fillColor: Colors.white,

                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(14),
                                                    borderSide: BorderSide(
                                                        color: Mycolors.red)),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(14.0),
                                                  borderSide: new BorderSide(
                                                      color: Colors.red),
                                                ),
                                                suffixIcon: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        visability = !visability;
                                                      });
                                                    },
                                                    child: !visability
                                                        ? Icon(Icons.visibility_off)
                                                        : Icon(Icons.visibility)),
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(14.0),
                                                  borderSide: new BorderSide(
                                                      color: Colors.red),
                                                ),
                                                //fillColor: Colors.green
                                              ),
                                              validator: (val) {
                                                if(!isButtonPressed){
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
                                                  TextInputType.text,
                                              style: new TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'OpenSans-Regular',
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
                                                isButtonPressed=false;
                                                if(isError){
                                                  _formKey.currentState.validate();
                                                }
                                                if (value.length > 5) {
                                                  confirmPasswordValid = true&&(value == passwordController.text.trim());
                                                } else {
                                                  confirmPasswordValid = false;
                                                }
                                                setState(() {
                                                  active =
                                                      confirmPasswordValid && passwordValid;
                                                });
                                              },
                                              controller: confirmPasswordController,
                                              obscureText: !confirmVisability ?  true: false,
                                              decoration: new InputDecoration(
                                                labelText: "Confirm Password",
                                                labelStyle: TextStyle(
                                                    fontSize: 14,
                                                    fontFamily: 'OpenSans-Regular',
                                                    color: Mycolors.red),
                                                fillColor: Colors.white,

                                                enabledBorder: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(14),
                                                    borderSide: BorderSide(
                                                        color: Mycolors.red)),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(14.0),
                                                  borderSide: new BorderSide(
                                                      color: Colors.red),
                                                ),
                                                suffixIcon: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        confirmVisability = !confirmVisability;
                                                      });
                                                    },
                                                    child: !confirmVisability
                                                        ? Icon(Icons.visibility_off)
                                                        : Icon(Icons.visibility)),
                                                border: new OutlineInputBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(14.0),
                                                  borderSide: new BorderSide(
                                                      color: Colors.red),
                                                ),
                                                //fillColor: Colors.green
                                              ),
                                              validator: (val) {
                                                if(!isButtonPressed){
                                                  return null;
                                                }
                                                isError = true;
                                                if (val.length < 6) {
                                                  return "Confirm Password must contain at least 6 characters";
                                                }else if(val.trim()!=passwordController.text.trim()){
                                                  return "Confirm Password does not Match";
                                                }else {
                                                  return null;
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.text,
                                              style: new TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: 'OpenSans-Regular',
                                                  color: Mycolors.dark2),
                                            ),
                                          ),
                                        ),
                                        SmartButton(
                                          active: active,
                                          isLoading: isLoading,
                                          text: 'Reset Password',
                                          onPressed: () {
                                            isButtonPressed =true;
                                            FocusScope.of(context)
                                                .requestFocus(FocusNode());
                                            postChangePassword(context);
                                          },
                                          inactiveOnpressed: () {
                                            isButtonPressed =true;
                                            _formKey.currentState.validate();
                                          },
                                        )
                                      ],
                                    ),
                                  ),
                                ),
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
                              )
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
    );
  }

  postChangePassword(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
      setState(() {
        isLoading = true;
      });
      String url = BaseUrl.baseUrl + '/reset-password';

      var map = convert.jsonEncode(<String, String>{
        'new_password': passwordController.text,
        'confirm_password': confirmPasswordController.text,
        'api_token': _accountProvider.getTempToken,
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
            setState(() {
              isLoading = false;
            });
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(seconds: 1),
            );
            await Scaffold.of(context).showSnackBar(snackBar).closed;
            Navigator.of(context).pop();

          } else {
            if (jsonResponse.toString().isNotEmpty) {
              final snackBar = SnackBar(
                content: Text(jsonResponse['message']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', '')),
                duration: Duration(seconds: 2),
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
}
