import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/screens/Reset2_password_screen/reset2_password.dart';

class Verification3screen extends StatefulWidget {
  @override
  _Verification3screenState createState() => _Verification3screenState();
}

class _Verification3screenState extends State<Verification3screen> {
  @override
  Widget build(BuildContext context) {
        var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text('Verification' ,style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
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
                height: height/1.8,
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    SizedBox(height: height/26,),
                   

                    Container(
                      width: width,
                      padding: EdgeInsets.only(top: 20),
                      height: height/2.5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
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
                      child: Column(
                        children: [
                          Text("Please enter the verification code sent on \nyour mobile number",textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark),),
                           SizedBox(height: height/20,),
                    Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width/8,
                              height: width/8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  
                                  color: Mycolors.red
                                )
                              ),
                              child: Center(
                                child: TextFormField(
                                  
                                   onChanged: (value){
                                    if(value.length>0){
                FocusScope.of(context).nextFocus();
                                    
                                    }
                                    if(value.length==0){
                FocusScope.of(context).previousFocus();
                                    
                                    }
                                  },
                                  autofocus: true,
                                  textInputAction: TextInputAction.next,
                                  
            
                                   inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,

                                  style: TextStyle(fontSize: 24,fontFamily: 'OpenSans-Semibold',color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 23,fontFamily: 'OpenSans-Regular',color: Mycolors.border),
                                    hintText: '-'
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width/40,),

                            Container(
                              width: width/8,
                              height: width/8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  
                                  color: Mycolors.red
                                )
                              ),
                              child: Center(
                                child: TextFormField(
                                  
                                  textInputAction: TextInputAction.done,
                                  onChanged: (value){
                                    if(value.length>0){
                FocusScope.of(context).nextFocus();
                                    
                                    }
                                    if(value.length==0){
                FocusScope.of(context).previousFocus();
                                    
                                    }
                                  },
                                   
                                   inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,
                                  style: TextStyle(fontSize: 24,fontFamily: 'OpenSans-Semibold',color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 23,fontFamily: 'OpenSans-Regular',color: Mycolors.border),
                                    hintText: '-'
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width/40,),


                            Container(
                              width: width/8,
                              height: width/8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  
                                  color: Mycolors.red
                                )
                              ),
                              child: Center(
                                child: TextFormField(
                                   onChanged: (value){
                                    if(value.length>0){
                FocusScope.of(context).nextFocus();
                                    
                                    }
                                    if(value.length==0){
                FocusScope.of(context).previousFocus();
                                    
                                    }
                                  },
                                   inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,

                                  style: TextStyle(fontSize: 24,fontFamily: 'OpenSans-Semibold',color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 23,fontFamily: 'OpenSans-Regular',color: Mycolors.border),
                                    hintText: '-'
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: width/40,),


                            Container(
                              width: width/8,
                              height: width/8,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  
                                  color: Mycolors.red
                                )
                              ),
                              child: Center(
                                child: TextFormField(
                                   onChanged: (value){
                                    if(value.length>0){
                FocusScope.of(context).nextFocus();
                                    
                                    }
                                    if(value.length==0){
                FocusScope.of(context).previousFocus();
                                    
                                    }
                                  },
                                   inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                  ],
                                  textAlign: TextAlign.center,
                                  keyboardType: TextInputType.number,

                                  style: TextStyle(fontSize: 24,fontFamily: 'OpenSans-Semibold',color: Colors.black),
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    enabledBorder: InputBorder.none,
                                    hintStyle: TextStyle(fontSize: 23,fontFamily: 'OpenSans-Regular',color: Mycolors.border),
                                    hintText: '-'
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                           SizedBox(height: height/20,),
                    Text("{countdown}",
                                        style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Colors.black),),
                    SizedBox(height: height/60,),
                    Text("RESEND",
                                        style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.red),),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      
                      onTap: (){
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>Homescreen()));
                        
                      },
                      child: Container(
                        width: width,
                        height: height/15,
                        decoration: BoxDecoration(
                          color: Mycolors.red_dark,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))

                        ),
                        child: Center(
                          child:  Text("Verify",
                                          style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
                        ),
                      ),
                    )
                        ],
                      ),
                    ),

                   

                  ],
                ),
              )
          ],
        ),
      ),
      
    );
  }
}