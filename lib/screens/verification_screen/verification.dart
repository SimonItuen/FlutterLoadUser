import 'dart:async';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:load/widgets/smart_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:load/screens/Create_profile_screen/Create_profile.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

import 'package:provider/provider.dart';

class Verificationscreen extends StatefulWidget {
  static String routeName = '/verification-screen';

  @override
  _VerificationscreenState createState() => _VerificationscreenState();
}

class _VerificationscreenState extends State<Verificationscreen> {
  TextEditingController controller = TextEditingController();
  TextEditingController one = TextEditingController();
  TextEditingController two = TextEditingController();
  TextEditingController three = TextEditingController();
  TextEditingController four = TextEditingController();
  final focus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 1;
  StreamController<ErrorAnimationType> errorController;
  bool hasError = false;
  String enterCode = "";
  bool active = false;
  bool hasEnded = false;
  String currentText = "";
  String storeId = '-1';

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
    errorController = StreamController<ErrorAnimationType>();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    super.dispose();
    errorController.close();
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
            'Verification',
            style: TextStyle(
                fontSize: 18,
                fontFamily: 'OpenSans-Semibold',
                color: Colors.white),
          ),
          centerTitle: true,
          elevation: 0,
          backgroundColor: Mycolors.red,
        ),
        body: Builder(
          builder: (context) => Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Container(
              child: Stack(
                //fit: StackFit.loose,
                children: [
                  BackdropBg(),
                  // Container(
                  //   width: width,
                  //   height: height/50,
                  //   color: Mycolors.red,
                  // ),
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
                            children: [
                              Container(
                                width: width,
                                padding: EdgeInsets.only(top: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset:
                                          Offset(0, 3), // changes position of shadow
                                    ),
                                  ],
                                  color: Colors.white,
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Please enter verification code.",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'OpenSans-Regular',
                                            color: Mycolors.dark),
                                      ),
                                    ),
                                    Form(
                                      key: _formKey,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        child: PinCodeTextField(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          length: 4,
                                          textCapitalization:
                                              TextCapitalization.characters,
                                          textInputType: TextInputType.number,
                                          obsecureText: false,
                                          animationType: AnimationType.fade,
                                          pinTheme: PinTheme(
                                            shape: PinCodeFieldShape.box,
                                            activeColor: Colors.grey,
                                            selectedColor: Mycolors.red_dark,
                                            inactiveColor: Colors.grey,
                                            selectedFillColor: Colors.white,
                                            activeFillColor: Colors.white,
                                            inactiveFillColor: Colors.white,
                                            borderRadius: BorderRadius.circular(5),
                                            fieldHeight: 53,
                                            fieldWidth: 47,
                                          ),
                                          animationDuration:
                                              Duration(milliseconds: 300),
                                          enableActiveFill: true,
                                          errorAnimationController: errorController,
                                          onCompleted: (v) {
                                            print("Completed");
                                            enterCode = v;
                                            setState(() {});
                                          },
                                          validator: (val) {
                                            if (val.length < 4) {
                                              return "Code incomplete";
                                            } else {
                                              return null;
                                            }
                                          },
                                          onChanged: (value) {
                                            enterCode = value;
                                            setState(() {
                                              currentText = value;
                                              if (currentText.length == 4) {
                                                active = true;
                                              } else {
                                                active = false;
                                              }
                                            });
                                          },
                                          beforeTextPaste: (text) {
                                            print("Allowing to paste $text");
                                            //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                            //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                            return true;
                                          },
                                        ),
                                      ),
                                    ),
                                    CountdownTimer(
                                      endTime: endTime,
                                      onEnd: () {
                                        setState(() {
                                          hasEnded = true;
                                        });
                                      },
                                      textStyle: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'OpenSans-Semibold',
                                          color: Colors.grey),
                                    ),
                                    InkWell(
                                      onTap: hasEnded
                                          ? () {
                                              setState(() {
                                                hasEnded = false;
                                                endTime = DateTime.now()
                                                        .millisecondsSinceEpoch +
                                                    1000 * 60 * 1;
                                              });
                                            }
                                          : () {},
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            bottom: 16.0, top: 8),
                                        child: Text(
                                          "RESEND",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontFamily: 'OpenSans-Semibold',
                                              color: !hasEnded
                                                  ? Colors.grey
                                                  : Mycolors.red),
                                        ),
                                      ),
                                    ),
                                    SmartButton(
                                      text: 'VERIFY',
                                      isLoading: isLoading,
                                      active: active,
                                      onPressed: () {
                                        postOTP(context);
                                      },
                                      inactiveOnpressed: () {
                                        errorController.add(ErrorAnimationType
                                            .shake); // Triggering error shake animation
                                        setState(() {
                                          hasError = true;
                                        });
                                      },
                                    )
                                  ],
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
                  ),

                ],
              ),
            ),
          ),
        ));
  }

  postOTP(BuildContext context) async {
    if (enterCode.length == 4) {
      print(enterCode);
      setState(() {
        isLoading = true;
      });
      String url = BaseUrl.baseUrl + '/verify-otp';
      print(url);
      var map = convert.jsonEncode(<String, String>{'otp': enterCode});
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
          var jsonResponse = convert.jsonDecode(response.body);
          if (jsonResponse['msg'].toString() ==
              'Your Account is Activated.Now You Can login.') {
            Map<String, dynamic> map = jsonResponse['data'];

            /* UserModel model = UserModel.fromJson(map);*/
            /*print(model.name);*/
            /*SessionManagerUtil.putString('token', '${model.accessToken}');
            SessionManagerUtil.putString('language', '${model.language}');
            SessionManagerUtil.putInt('id', model.id);
            SessionManagerUtil.putString('fullName', '${model.fullName}');
            SessionManagerUtil.putString('email', '${model.email}');
            SessionManagerUtil.putString('country', '${model.country}');
            SessionManagerUtil.putString('phone', '${model.phone}');
            SessionManagerUtil.putString('profileImg', '${model.profileImg}');
            SessionManagerUtil.putString('referralCode', '${model.referralCode}');*/

            Navigator.of(context).pushReplacementNamed(Createprofile.routeName);
            setState(() {
              isLoading = false;
            });
          } else {
            if (jsonResponse.toString().isNotEmpty) {
              final snackBar = SnackBar(
                content: Text(jsonResponse['msg']
                    .toString()
                    .replaceAll('{', '')
                    .replaceAll('}', '')
                    .replaceAll('[', '')
                    .replaceAll(']', '').replaceAll('Otp Not Matched.', 'Invalid verification code')),
                duration: Duration(seconds: 4),
              );
              Scaffold.of(context).showSnackBar(snackBar);
              errorController.add(
                  ErrorAnimationType.shake); // Triggering error shake animation
              setState(() {
                hasError = true;
                isLoading = false;
              });
            }
          }
        } else {
          var jsonResponse = convert.jsonDecode(response.body);
          if (jsonResponse.toString().isNotEmpty) {
            final snackBar = SnackBar(
              content: Text(jsonResponse['msg']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '').replaceAll('Otp Not Matched.', 'Invalid verification code')),
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
