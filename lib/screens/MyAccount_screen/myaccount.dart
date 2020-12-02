import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker_modern/image_picker_modern.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/helper/session_manager_util.dart';
import 'package:load/model/user_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Verification2_screen/Verification2.dart';
import 'package:load/screens/change_number_screen/change_number.dart';
import 'package:load/screens/change_password_screen_from_settings/change_password_from_settings.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:load/widgets/smart_button.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:flushbar/flushbar.dart';
import 'package:image_cropper/image_cropper.dart';

class Myaccountscreen extends StatefulWidget {
  @override
  _MyaccountscreenState createState() => _MyaccountscreenState();
}

class _MyaccountscreenState extends State<Myaccountscreen> {
  var visability = false;
  var visability1 = false;
  String fullName = '';
  String mobile = '';
  String email = '';
  String profilePhoto = '';
  bool isLoading = false;
  bool nameValid = false;
  bool mobileValid = false;
  bool emailValid = false;
  bool isError = false;
  bool isButtonPressed = false;
  bool active = false;
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  UserAccountProvider _accountProvider;
  File _image;
  final picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();

  Future getImage() async {
    final pickedFile = await ImagePicker.pickImage(
        source: ImageSource.gallery,
        maxHeight: 1000,
        maxWidth: 1000);
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
        active = nameValid &&
            emailValid &&
            mobileValid &&_image!=null;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () {
      fillUp();
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  fillUp() {
    nameController.text = _accountProvider.getFullName;
    nameController.selection = TextSelection.fromPosition(
        TextPosition(offset: nameController.text.length));
    if (nameController.text.trim().isNotEmpty) {
      nameValid = true;
    }
    phoneController.text = _accountProvider.getPhone;
    phoneController.selection = TextSelection.fromPosition(
        TextPosition(offset: phoneController.text.length));
    if (phoneController.text.trim().isNotEmpty) {
      mobileValid = true;
    }
    emailController.text = _accountProvider.getEmail;
    emailController.selection = TextSelection.fromPosition(
        TextPosition(offset: emailController.text.length));
    if (emailController.text.trim().isNotEmpty) {
      emailValid = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    _accountProvider = Provider.of<UserAccountProvider>(context, listen: true);
    profilePhoto = _accountProvider.getProfileUrl;
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
          'My Account',
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
                                        padding:
                                            EdgeInsets.only(top: width / 5 * (1- 0.30681)),
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
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                                      nameValid =
                                                          value.trim().isNotEmpty;
                                                      setState(() {
                                                        active = nameValid &&
                                                            emailValid &&
                                                            mobileValid;
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
                                                      horizontal: 16),
                                                  child: Stack(
                                                    alignment: AlignmentDirectional.centerEnd,
                                                    children: [
                                                      TextFormField(
                                                        onTap: () {
                                                          FocusScope.of(context)
                                                              .requestFocus(new FocusNode());
                                                          /*_selectDate();*/
                                                        },
                                                        enableInteractiveSelection: false,
                                                        showCursor: false,
                                                        controller: phoneController,
                                                        decoration:
                                                            new InputDecoration(
                                                          // suffixText: 'Change',
                                                          // suffixStyle:TextStyle(fontSize: 14,fontFamily: 'OpenSans-Semibold',color: Mycolors.red)  ,
                                                          // suffixIcon: Icon(Icons.phone),
                                                          labelText: "Mobile number",
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
                                                                          .circular(
                                                                              14),
                                                                  borderSide: BorderSide(
                                                                      color: Mycolors
                                                                          .red)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(14.0),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color:
                                                                        Colors.red),
                                                          ),

                                                          border:
                                                              new OutlineInputBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                    .circular(14.0),
                                                            borderSide:
                                                                new BorderSide(
                                                                    color:
                                                                        Colors.red),
                                                          ),
                                                          //fillColor: Colors.green
                                                        ),
                                                        keyboardType:
                                                            TextInputType.phone,
                                                        style: new TextStyle(
                                                            fontSize: 14,
                                                            fontFamily:
                                                            'BAHNSCHRIFT-regular',
                                                            color: Mycolors.dark2),
                                                      ),
                                                      Positioned(
                                                          right: width / 20,
                                                          child: InkWell(
                                                              onTap: () async{
                                                                String number= await Navigator.push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          ChangeNumber(),
                                                                    ));

                                                                if(number.trim().isNotEmpty) {
                                                                  phoneController
                                                                      .text =
                                                                      number;

                                                                  mobileValid =true;
                                                                  setState(() {
                                                                    active = nameValid &&
                                                                        emailValid &&
                                                                        mobileValid;
                                                                  });
                                                                }
                                                              },
                                                              child: Text(
                                                                'CHANGE',
                                                                style: TextStyle(
                                                                    fontSize: 16,
                                                                    fontFamily:
                                                                        'OpenSans-Semibold',
                                                                    color:
                                                                        Mycolors.red),
                                                              )))
                                                    ],
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
                                                      emailValid =
                                                          RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                                                  .hasMatch(value) &&
                                                              value.trim().isNotEmpty;
                                                      setState(() {
                                                        active = nameValid &&
                                                            emailValid &&
                                                            mobileValid;
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
                                              InkWell(
                                                onTap: (){
                                                  Navigator.of(context).pushNamed(ChangePasswordFromSetting.routeName);
                                                },
                                                child: Padding(
                                                  padding: const EdgeInsets.symmetric(vertical:8.0, horizontal: 16),
                                                  child: Text(
                                                    'Change Password',
                                                    textAlign: TextAlign.end,
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                        'OpenSans-Semibold',
                                                        color:
                                                        Mycolors.red),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: EdgeInsets.all(5),
                                              ),
                                              SmartButton(
                                                text: 'Save',
                                                isLoading: isLoading,
                                                active: active,
                                                onPressed: () {
                                                  isButtonPressed =true;
                                                  FocusScope.of(context)
                                                      .requestFocus(FocusNode());
                                                  postUpdate(context);
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
                                  top: -(width / 5 *  0.30681),
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
                                              width: width / 5,
                                              height: width / 5,
                                              decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: CircleAvatar(
                                                backgroundColor: Colors.grey,
                                                radius: width / 5 * 0.5,
                                                backgroundImage: _image != null
                                                    ? FileImage(_image)
                                                    : profilePhoto
                                                            .toLowerCase()
                                                            .isNotEmpty
                                                        ? NetworkImage(profilePhoto)
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
                        ),
                      ],
                    ),
                  ],
                ),
              )),
    );
  }

  postUpdate(BuildContext context) async {
    if (_image != null || profilePhoto.trim().toString().isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
      String url = BaseUrl.baseUrl + '/update-profile';

      var dio = Dio(BaseOptions(headers: {
        "Content-Type": "application/json",
        "X-Requested-With": "XMLHttpRequest"
      }));
      String base64Image = _accountProvider.getProfileUrl;
      var params = {
        "name": nameController.text,
        "email": emailController.text,
        "mobile_number": phoneController.text,
        "api_token": _accountProvider.getAccessToken,
      };
      if (_image != null) {
        List<int> imageBytes = _image.readAsBytesSync();
        base64Image =
            'data:image/jpeg;base64,${convert.base64.encode(imageBytes)}';
        params = {
          "name": nameController.text,
          "email": emailController.text,
          "mobile_number": phoneController.text,
          "api_token": _accountProvider.getAccessToken,
          "profile_photo": '$base64Image'
        };
      }

      try {
        Response response = await dio.post(url, data: params);
        if (response.data['success'].toString() == true.toString()) {
          UserModel model = UserModel.fromJson(response.data['data']);
          if (_image == null) {
            model.profileImg = _accountProvider.getProfileUrl;
          }
          model.points= _accountProvider.getPoints;
          _accountProvider.setUserDetails(model);
          SessionManagerUtil.putString('apiToken', '${model.apiToken}');
          SessionManagerUtil.putString('status', '${model.status}');
          SessionManagerUtil.putInt('id', model.id);
          SessionManagerUtil.putString('name', '${model.name}');
          SessionManagerUtil.putString('email', '${model.email}');
          SessionManagerUtil.putString('role', '${model.role}');
          SessionManagerUtil.putString('phone', '${model.phone}');
          SessionManagerUtil.putString('profilePhoto', '${model.profileImg}');
          setState(() {
            active=false;
          });
          final snackBar = SnackBar(
            content: Text(response.data['message']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', '')),
            duration: Duration(seconds: 2),
          );
          Scaffold.of(context).showSnackBar(snackBar);
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
        final snackBar = SnackBar(
          content: Text('Please add profile photo'),
          duration: Duration(seconds: 2),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      }
    }
  }
}
