import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Verification2_screen/Verification2.dart';
import 'package:load/screens/check_password_otp_screen/check_password_otp.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:load/widgets/smart_button.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class Resetscreen extends StatefulWidget {
  static String routeName = '/reset-password-screen';
  @override
  _ResetscreenState createState() => _ResetscreenState();
}

class _ResetscreenState extends State<Resetscreen> {
  var visability = false;
  bool isLoading = false;
  bool active = false;
  bool isError = false;
  bool isButtonPressed = false;
  TextEditingController emailController = TextEditingController();
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
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
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
          'Forgot Password',
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
    builder: (BuildContext context, BoxConstraints viewportConstraints) {
    return Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Stack(
          children: [
            BackdropBg(),
            Container(
              width: width,
              height: height / 50,
              color: Mycolors.red,
            ),
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: <Widget>[
                AbsorbPointer(
                  absorbing: isLoading,
                  child: Container(
                    width: width,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 40),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          Container(
                            width: width,
                            padding: EdgeInsets.only(top: 25),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              color: Colors.white,
                            ),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 16),
                                  child: Text(
                                    "Please enter your email address and we will send a verification code",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans-Regular',
                                        color: Mycolors.dark,
                                        height: 2),
                                  ),
                                ),
                                Theme(
                                  data: ThemeData(
                                    primaryColor: Mycolors.red,
                                  ),
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.symmetric(horizontal: 16),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 10),
                                      child: TextFormField(
                                        onChanged: (value) {
                                          isButtonPressed=false;
                                          if(isError){
                                            _formKey.currentState.validate();
                                          }
                                          setState(() {
                                            active =
                                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                        .hasMatch(value) &&
                                                    value.trim().isNotEmpty;
                                          });
                                        },
                                        autofocus: true,
                                        controller: emailController,
                                        decoration: new InputDecoration(
                                          labelText: "Email",
                                          labelStyle: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'OpenSans-Regular',
                                              color: Mycolors.red),
                                          fillColor: Colors.white,

                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(14),
                                              borderSide:
                                                  BorderSide(color: Mycolors.red)),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(14.0),
                                            borderSide:
                                                new BorderSide(color: Colors.red),
                                          ),

                                          border: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(14.0),
                                            borderSide:
                                                new BorderSide(color: Colors.red),
                                          ),
                                          //fillColor: Colors.green
                                        ),
                                        validator: (val) {
                                          if(!isButtonPressed){
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
                                        keyboardType: TextInputType.emailAddress,
                                        style: new TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'OpenSans-Regular',
                                            color: Mycolors.dark2),
                                      ),
                                    ),
                                  ),
                                ),
                                SmartButton(
                                  active: active,
                                  isLoading: isLoading,
                                  text: 'NEXT',
                                  onPressed: () {
                                    isButtonPressed =true;
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    postForgotPassword(context);
                                  },
                                  inactiveOnpressed: () {
                                    isButtonPressed =true;
                                    _formKey.currentState.validate();
                                  },
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
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
      );},)
    );
  }

  postForgotPassword(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
      setState(() {
        isLoading = true;
      });
      String url = BaseUrl.baseUrl + '/forgot-password';
      print(url);
      var map = convert.jsonEncode(<String, String>{
        'email': emailController.text,
      });
      print(map);
      try {
        http.Response response = await http.post(url,
            headers: {
              "Content-Type": "application/json",
              "X-Requested-With": "XMLHttpRequest"
            },
            body: map);

        print(response.body);
        if (response.statusCode == 200) {
          print('eien');
          var jsonResponse = convert.jsonDecode(response.body);
          if (jsonResponse['success'].toString() == 'true') {
            _accountProvider.setTempEmail(emailController.text);
            Map<String, dynamic> map = jsonResponse['data'];
            print(map['token'].toString());
            _accountProvider.setTempToken(map['token'].toString());
            setState(() {
              isLoading = false;
            });
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '').replaceAll('Check Otp', 'Otp sent to ${emailController.text.toString()}')),
              duration: Duration(seconds: 1),
            );
            await Scaffold.of(context).showSnackBar(snackBar).closed;
            Navigator.of(context).pushReplacementNamed(CheckOtpPasswordscreen.routeName);
          } else {
            if (jsonResponse.toString().isNotEmpty) {
              final snackBar = SnackBar(
                content: Text(jsonResponse['message']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', '')),
                duration: Duration(seconds: 1),
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
              duration: Duration(seconds: 1),
            );
            Scaffold.of(context).showSnackBar(snackBar);
            setState(() {
              isLoading = false;
            });
          } else {
            final snackBar = SnackBar(
              content: Text('Couldn\'t Connect, please try again'),
              duration: Duration(seconds: 1),
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
          duration: Duration(seconds: 1),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      } on SocketException catch (e) {
        final snackBar = SnackBar(
          content: Text('Socket Error: ${e.message}'),
          duration: Duration(seconds: 1),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      } on Error catch (e) {
        final snackBar = SnackBar(
          content: Text('General Error: ${e}'),
          duration: Duration(seconds: 1),
        );
        Scaffold.of(context).showSnackBar(snackBar);
        setState(() {
          isLoading = false;
        });
      }
    }
  }
}
