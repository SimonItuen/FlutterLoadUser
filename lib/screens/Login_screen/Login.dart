import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Create_profile_screen/Create_profile.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Reset_password_screen/reset_password.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var visability=false;
  @override
  Widget build(BuildContext context) {
        var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      resizeToAvoidBottomInset: false,
       appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text('Login' ,style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Mycolors.red,
      ),
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              width: width,
              height: height/5.6,
              child: Image.asset('assets/curve.png',fit: BoxFit.fill,)),
               Container(
                  width: width,
                  height: height/50,
                  color: Mycolors.red,
                ),
              Container(
                width: width,
                height: height/1.5,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                   
                    SizedBox(height: height/26,),

                    Container(
                      width: width,
                      padding: EdgeInsets.only(top: 25),
                      height: height/3,
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
                        
                  Theme(
                    data: ThemeData(
                      primaryColor: Mycolors.red,
            
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        
                          decoration: new InputDecoration(
                            labelText: "Email Address",
                            labelStyle: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.red) ,
                            hintText: 'user@email.com',
                            hintStyle:  TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
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
                          validator: (val) {
                            if(val.length==0) {
                              return "Email cannot be empty";
                            }else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new  TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
                        ),
                    ),
                  ),

                  SizedBox(height: height/40,),

                  Theme(
                    data: ThemeData(
                      primaryColor: Mycolors.red,
            
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        obscureText:visability?false: true,
                          decoration: new InputDecoration(
                            labelText: "Password",
                            labelStyle: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.red) ,
                            hintText: '************',
                            hintStyle:  TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
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
                            suffixIcon: InkWell(
                              onTap: (){
                                setState(() {
                                  visability=!visability;
                                });
                              },
                              child:visability?Icon(Icons.visibility_off): Icon(Icons.visibility)),
                            border: new OutlineInputBorder(
                              
                              borderRadius: new BorderRadius.circular(14.0),
                              borderSide: new BorderSide(
                                color: Colors.red
                              ),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (val) {
                            if(val.length<6) {
                              return "Password must be 6 characters";
                            }else{
                              return null;
                            }
                          },
                          keyboardType: TextInputType.emailAddress,
                          style: new  TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
                        ),
                    ),
                  ),

                  SizedBox(height: height/35,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Can't login? ",
                                            style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),),
                             InkWell(
                               onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Resetscreen()));

                               },
                               child: Text("Forgot Password!",
                                              style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.red),),
                             ),
                          ],
                        ),

                    Expanded(child: SizedBox()),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));

                      },
                      child: Container(
                        width: width,
                        height: height/15,
                        decoration: BoxDecoration(
                          color: Mycolors.red_dark,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))

                        ),
                        child: Center(
                          child:  Text("LOGIN",
                                          style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
                        ),
                      ),
                    )
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                        width: width,
                        height: height/14,
                        decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12)),
                   boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                color: Colors.white,
                        ),
                        child: Center(
                          child:  Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account? ",
                                            style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),),
                             InkWell(
                               onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Createprofile()));

                               },
                               child: Text("Register",
                                              style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.red),),
                             ),
                          ],
                        ),
                        ),
                      ),
                    )

                   

                  ],
                ),
              )
          ],
        ),
      ),
      
    );
  }
}