import 'dart:async';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/model/user_model.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:dio/dio.dart';
import 'package:load/helper/session_manager_util.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:load/screens/Verification2_screen/Verification2.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:provider/provider.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/widgets/smart_button.dart';
import 'package:image_cropper/image_cropper.dart';

class Createprofile extends StatefulWidget {
  static String routeName = '/create-profile-screen';

  @override
  _CreateprofileState createState() => _CreateprofileState();
}

class _CreateprofileState extends State<Createprofile> {
  var visability = false;
  var visability1 = false;
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = false;
  String phoneNumber = '';
  final _formKey = GlobalKey<FormState>();
  bool emailValid = false;
  bool passwordValid = false;
  bool nameValid = false;
  bool active = false;
  bool isError = false;
  bool isButtonPressed = false;
  File _image;
  final picker = ImagePicker();
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

  Future getImage() async {
    final pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 90,
        maxHeight: 500,
        maxWidth: 500);
    _cropImage(pickedFile.path);
  }

  _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        maxWidth: 500,
        maxHeight: 500,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0)
    );
    if (croppedImage != null) {
      setState(() {
        _image = croppedImage;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDynamicLinks();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);
    phoneNumber = _accountProvider.getTempPhone;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
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
          'Create Profile',
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
                    Stack(
                      alignment: AlignmentDirectional.topCenter,
                      children: <Widget>[
                        AbsorbPointer(
                          absorbing: isLoading,
                          child: Container(
                            margin: EdgeInsets.only(top: 40),
                            child: Stack(
                              overflow: Overflow.visible,
                              alignment: AlignmentDirectional.topCenter,
                              children: <Widget>[
                                Container(
                                  width: width,
                                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
                                              Padding(
                                                padding: EdgeInsets.only(top: (width / 5)*(1- 0.30681)),
                                                child: Text(
                                                  phoneNumber,
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontFamily: 'BAHNSCHRIFT-regular',
                                                      color: Mycolors.dark),
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
                                                      nameValid =
                                                          value.trim().isNotEmpty;
                                                      setState(() {
                                                        active = nameValid && emailValid &&
                                                            passwordValid;
                                                      });
                                                    },
                                                    controller: nameController,
                                                    decoration: new InputDecoration(
                                                      labelText: "Full Name",
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
                                                    keyboardType: TextInputType.text,
                                                    validator: (val) {
                                                      if(!isButtonPressed){
                                                        return null;
                                                      }
                                                      isError = true;
                                                      if (val.length == 0) {
                                                        return "Name cannot be empty";
                                                      } else {
                                                        return null;
                                                      }
                                                    },
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
                                                      isButtonPressed=false;
                                                      if(isError){
                                                        _formKey.currentState.validate();
                                                      }
                                                      emailValid =RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                          .hasMatch(value) &&
                                                          value.trim().isNotEmpty;
                                                      setState(() {
                                                        active = nameValid && emailValid &&
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
                                                      if(!isButtonPressed){
                                                        return null;
                                                      }
                                                      isError = true;
                                                      if (val.length == 0) {
                                                        return "Email cannot be empty";
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
                                                        active = nameValid && emailValid &&
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
                                                    style: new TextStyle(
                                                        fontSize: 14,
                                                        fontFamily:
                                                            'OpenSans-Regular',
                                                        color: Mycolors.dark2),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(5),
                                              ),
                                              SmartButton(
                                                text: 'Register',
                                                isLoading: isLoading,
                                                active: active,
                                                onPressed: () {
                                                  isButtonPressed =true;
                                                  FocusScope.of(context).requestFocus(FocusNode());
                                                  postRegister(context);
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
                                Positioned(
                                  top: -(width / 5 * 0.30681),
                                  child: InkWell(
                                    onTap: (){
                                      getImage();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                        child: Stack(
                                          alignment: AlignmentDirectional.bottomEnd,
                                          children: <Widget>[
                                            Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.grey,
                                                radius: width / 5 * 0.5,
                                                backgroundImage: _image != null
                                                    ? FileImage(_image)
                                                    : null,
                                              ),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFF535353)
                                              ),
                                              child: Icon(Icons.add, color: Colors.white,),
                                            )
                                          ],
                                        ),
                                      ),
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
                    ),
                  ],
                ),
              )),
    );
  }

  postRegister(BuildContext context) async {
    if (_formKey.currentState.validate() && _image != null) {
      setState(() {
        isLoading = true;
      });
      UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
      String url = BaseUrl.baseUrl + '/register';

      var dio = Dio(BaseOptions(headers: {
        "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest"
      }));
      List<int> imageBytes = _image.readAsBytesSync();
      String base64Image = convert.base64.encode(imageBytes);
      var params = {
        "name": nameController.text,
        "email": emailController.text,
        "mobile_number": phoneNumber,
        "password": passwordController.text,
        "profile_photo": 'data:image/jpeg;base64,$base64Image'
      };
      try {
        Response response = await dio.post(url, data: params);
        if (response.data['success'].toString() == true.toString()) {
          print('success');
          UserModel model = UserModel.fromJson(response.data['data']);
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
          Navigator.of(context)
              .pushNamedAndRemoveUntil(Homescreen.routeName, (Route<dynamic> route) => false);
        } else {
          var jsonResponse = response.data;

          if (jsonResponse.toString().isNotEmpty) {
            Flushbar(
              flushbarPosition: FlushbarPosition.TOP,
              message: jsonResponse['data']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', ''),
              duration: Duration(seconds: 3),
            ).show(context);
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
        }
        setState(() {
          isLoading = false;
        });
      } on DioError catch (e) {
        print(e.message.toString());
        setState(() {
          isLoading = false;
        });
        setState(() {
          isLoading = false;
        });
      }
    } else {
      if (_image == null) {
        Flushbar(
          flushbarPosition: FlushbarPosition.TOP,
          message: 'Please add profile photo',
          duration: Duration(seconds: 3),
        ).show(context);
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
          String getHelp = jsonResponse['data']['phone_number']
              .toString();
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



/*_updateProfile() async {
    setState(() {
      isLoading = true;
    });
    var dio = Dio(BaseOptions(
        headers: {HttpHeaders.authorizationHeader: 'Bearer $accessToken'}));
    print('[$countryCodeDropDownValue]${_phoneController.text.trim()}');
    FormData formData = FormData.fromMap({
      "country": _dropDownValue,
      "phone": '[$countryCodeDropDownValue]${_phoneController.text}',
      "email": _emailController.text,
      "profile_image": _image != null
          ? await MultipartFile.fromFile(_image.path,
          filename: _image.path
              .split('/')
              .last)
          : null,
    });
    try {
      Response response =
      await dio.post(BaseUrl.baseUrl + '/profile', data: formData);
      final UserAccountProvider _accountProvider =
      Provider.of<UserAccountProvider>(context, listen: false);
      Map<String, dynamic> map = response.data;
      _accountProvider.editProfile(
        phone: map['data']['phone'],
        email: map['data']['email'],
        country: map['data']['country'],
        referralCode: map['data']['referral_code'].toString(),
        profileImg: map['data']['profile_image'],
      );
      SessionManagerUtil.putString('email', map['data']['email']);
      SessionManagerUtil.putString('country', map['data']['country']);
      SessionManagerUtil.putString('phone', map['data']['phone']);
      SessionManagerUtil.putString('profileImg', map['data']['profile_image']);
      SessionManagerUtil.putString('referralCode', map['data']['referral_code'].toString());
      setState(() {
        isLoading = false;
      });
    } on DioError catch (e) {
      print(e.response.toString());
      print(e.message.toString());
      setState(() {
        isLoading = false;
      });
    }
  }*/
}
