import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/helper/session_manager_util.dart';
import 'package:load/model/user_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Verification2_screen/Verification2.dart';
import 'package:load/screens/verification3_screen/verification3.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:load/widgets/smart_button.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class ChangeNumber extends StatefulWidget {
  static String routeName = '/change-number';
  @override
  _ChangeNumberState createState() => _ChangeNumberState();
}

class _ChangeNumberState extends State<ChangeNumber> {
  var visability=false;
  TextEditingController controller=TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  bool isError = false;
  bool isButtonPressed = false;
  bool active = false;

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
        var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text('Change Number' ,style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Mycolors.red,
      ),
      body:LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints)=> Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Stack(
          children: [
           BackdropBg(),
               Container(
                  width: width,
                  height: height/50,
                  color: Mycolors.red,
                ),
              Stack(
                alignment: AlignmentDirectional.topCenter,
                children: <Widget>[
                  AbsorbPointer(
                    absorbing: isLoading,
                    child: Container(
                      width: width,
                      height: height/1.5,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [

                            SizedBox(height: height/26,),

                            Container(
                              width: width,
                              padding: EdgeInsets.only(top: 25),
                              height: height/2.6,
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
                            child: Text("Please enter your mobile number and we will send you a verification code",textAlign: TextAlign.center,
                                                  style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark,height: 2),),
                          ),
                            Expanded(child: SizedBox()),

                          Theme(
                            data: ThemeData(
                              primaryColor: Mycolors.red,

                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16),
                              child: TextFormField(
                                controller: controller,
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(8),
                                ],
                                onChanged: (value) {
                                  isButtonPressed=false;
                                  if(isError){
                                    _formKey.currentState.validate();
                                  }

                                  setState(() {
                                    active = controller.text.toString().trim().isNotEmpty&&controller.text.toString().trim().length==8;
                                  });
                                },
                                validator: (val) {
                                  if (!isButtonPressed) {
                                    return null;
                                  }
                                  isError = true;
                                  if (val.length == 0) {
                                    return "Phone Number cannot be empty";
                                  } else {
                                    if (val.length != 8) {
                                      return "Phone Number should be 8 digit";
                                    } else {
                                      return null;
                                    }
                                  }
                                },
                                  decoration: new InputDecoration(
                                    labelText: "Mobile Number",
                                    labelStyle: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.red) ,
                                    fillColor: Colors.white,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(14),
                                      borderSide: BorderSide(

                                        color: Mycolors.red
                                      )
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(14.0),
                                      borderSide: new BorderSide(
                                        color: Colors.red
                                      ),
                                    ),

                                    border: new OutlineInputBorder(

                                      borderRadius: new BorderRadius.circular(14.0),
                                      borderSide: new BorderSide(
                                        color: Colors.red
                                      ),
                                    ),
                                    //fillColor: Colors.green
                                  ),

                                  keyboardType: TextInputType.phone,
                                  style: new TextStyle(
                                  fontSize: 14,
                                  fontFamily:
                                  'BAHNSCHRIFT-regular',
                                  color: Mycolors.dark2),
                                ),
                            ),
                          ),





                            Expanded(child: SizedBox()),
                            Container(
                              width: width,
                              height: height/15,
                              decoration: BoxDecoration(
                                color: Mycolors.red_dark,
                        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))

                              ),
                              child: Center(
                                child: SmartButton(
                                  active: active,
                                  text: 'Save',
                                  inactiveOnpressed: (){
                                    isButtonPressed = true;
                                    _formKey.currentState.validate();
                                  },
                                  onPressed: (){
                                    isButtonPressed = true;
                                    changeNumber(context);
                                  },
                                )  /*InkWell(
                                  onTap: (){
                              *//* Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification3screen()));
*//*
                                  },
                                  child: Text("NEXT",
                                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
                                ),*/
                              ),
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
                        )),
                  )
                ],
              )
          ],
        ),
      )),
      
    );
  }
  changeNumber(BuildContext context) async {
    if (_formKey.currentState.validate()) {
      UserAccountProvider _accountProvider =
      Provider.of<UserAccountProvider>(context, listen: false);
      setState(() {
        isLoading = true;
      });
      String url = BaseUrl.baseUrl + '/change-mobile-number';
      print(url);
      var map = convert.jsonEncode(<String, String>{
        'api_token': _accountProvider.getAccessToken,
        'mobile_number': controller.text,
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
            Map<String, dynamic> map = jsonResponse['data'];
            UserModel model = UserModel.fromJson(map);
            model.points= _accountProvider.getPoints;
            _accountProvider.setUserDetails(model);
            print(model.name);
            SessionManagerUtil.putString('apiToken', '${model.apiToken}');
            SessionManagerUtil.putString('status', '${model.status}');
            SessionManagerUtil.putInt('id', model.id);
            SessionManagerUtil.putString('name', '${model.name}');
            SessionManagerUtil.putString('email', '${model.email}');
            SessionManagerUtil.putString('role', '${model.role}');
            SessionManagerUtil.putString('phone', '${model.phone}');
            SessionManagerUtil.putString('profilePhoto', '${model.profileImg}');
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(milliseconds: 400),
            );
           await Scaffold.of(context).showSnackBar(snackBar).closed;
            Navigator.of(context).pop(controller.text);
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
}