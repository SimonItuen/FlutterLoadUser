import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Verification2_screen/Verification2.dart';

class Resetscreen extends StatefulWidget {
  @override
  _ResetscreenState createState() => _ResetscreenState();
}

class _ResetscreenState extends State<Resetscreen> {
  var visability=false;
  @override
  Widget build(BuildContext context) {
        var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text('Reset Pasword' ,style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
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
                    child: Text("Please enter your mobile number and we will \nsend you the verification code.",textAlign: TextAlign.center,
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
                        
                          decoration: new InputDecoration(
                            labelText: "Mobile Number",
                            labelStyle: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.red) ,
                            hintText: '94445411',
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
                         
                          keyboardType: TextInputType.phone,
                          style: new  TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
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
                        child:  InkWell(
                          onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification2screen()));

                          },
                          child: Text("NEXT",
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