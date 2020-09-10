import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/screens/verification_screen/verification.dart';

class Signscreen extends StatefulWidget {
  @override
  _SignscreenState createState() => _SignscreenState();
}

class _SignscreenState extends State<Signscreen> {
  @override
  Widget build(BuildContext context) {
        var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
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
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height/20,),
              Image.asset('assets/Rectangle 203.png',height: height/2.5,),
              Text("Title Two",
                                      style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Regular',color: Colors.white),),
              SizedBox(height: height/150,),
              Text("Lorem ipsum dolour sadipscing elitr, sed diam \nnonumy eirmod tempor invidunt ut labore et dolore",textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Colors.white),),
              SizedBox(height: height/20,),
              Expanded(child: Container(
                padding: EdgeInsets.only(left: 14,right: 11,top: 20),
                width: width,
                decoration: BoxDecoration(
                   boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: 40,
                        height: 2,
                        color: Mycolors.red,
                      ),
              SizedBox(height: height/30,),
                        Text("Get Started with Load",
                                        style: TextStyle(fontSize: 24,fontFamily: 'OpenSans-Regular',color: Colors.black),),
              SizedBox(height: height/20,),
                        Text("Enter your mobile number",
                                        style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Regular',color: Colors.black),),
              SizedBox(height: height/100,),

              Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Container(
                        width: width,
                        height: height/14,
                        padding: EdgeInsets.only(right: 50),
                        margin: EdgeInsets.only(right: 40),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Mycolors.textfield,
                          border: Border.all(
                            color: Mycolors.red,
                            width: 2
                          ),
                        ),
                        child: Center(
                          child: Theme(
                            data: ThemeData(
                              primaryColor: Mycolors.red
                            ),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              style: TextStyle(fontSize: 23,fontFamily: 'OpenSans-Regular',color: Colors.black),
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.phone_android),
                                hintStyle: TextStyle(fontSize: 23,fontFamily: 'OpenSans-Regular',color: Colors.black),
                                hintText: '94445411',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none
                              ),
                            ),
                          ),
                        ),

                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: (){
                               Navigator.push(context, MaterialPageRoute(builder: (context)=>Verificationscreen()));
                            },
                            child: Container(
                              width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Mycolors.red
                            ),
                            child: Center(
                              child: Icon(Icons.arrow_forward,size: 40,color: Colors.white,),
                            ),
                            ),
                          ),
                        ),

                      ),
                    )
                  ],
              ),
              SizedBox(height: height/30,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account? ",
                                            style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Colors.black),),
                             InkWell(
                               onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Login()));

                               },
                               child: Text("Login",
                                              style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.red),),
                             ),
                          ],
                        ),
                  
                    ],
                  ),
                ),
                
              )
              ),

              
              
              
            ],
          ),
        ),
        
      ),
    );
  }
}