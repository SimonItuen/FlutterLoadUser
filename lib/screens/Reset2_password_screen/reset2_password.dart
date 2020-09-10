import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Verification2_screen/Verification2.dart';

class Resetscreen2 extends StatefulWidget {
  @override
  _Resetscreen2State createState() => _Resetscreen2State();
}

class _Resetscreen2State extends State<Resetscreen2> {
  var visability=false;
  var visability1=false;
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
                      height: height/2.8,
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

                          SizedBox(height: height/90,),

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


                  SizedBox(height: height/30,),

                          Theme(
                    data: ThemeData(
                      primaryColor: Mycolors.red,
            
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        obscureText:visability1?false: true,
                          decoration: new InputDecoration(
                            labelText: "Confirm Password",
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
                                  visability1=!visability1;
                                });
                              },
                              child:visability1?Icon(Icons.visibility_off): Icon(Icons.visibility)),
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
                       // Navigator.push(context, MaterialPageRoute(builder: (context)=>Verification2screen()));

                          },
                          child: Text("VERIFY",
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