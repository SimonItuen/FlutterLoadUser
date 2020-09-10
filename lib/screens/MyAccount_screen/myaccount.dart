import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Verification2_screen/Verification2.dart';
import 'package:load/screens/change_number_screen/change_number.dart';

class Myaccountscreen extends StatefulWidget {
  @override
  _MyaccountscreenState createState() => _MyaccountscreenState();
}

class _MyaccountscreenState extends State<Myaccountscreen> {
  var visability=false;
  var visability1=false;
  @override
  Widget build(BuildContext context) {
        var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text('My Account' ,style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
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
                   
                    SizedBox(height: height/21,),

                    Container(
                      width: width,
                      padding: EdgeInsets.only(top: 25),
                      height: height/2.2,
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

                          SizedBox(height: height/40,),
                          
                          SizedBox(height: height/50,),
                          
                          Theme(
                    data: ThemeData(
                      primaryColor: Mycolors.red,
            
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextFormField(
                        
                          decoration: new InputDecoration(
                            labelText: "Full Name",
                            labelStyle: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.red) ,
                            hintText: 'Jhon Doe',
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
                      child: Stack(
                        children: [
                          TextFormField(

                            
                              decoration: new InputDecoration(
                                // suffixText: 'Change',
                                // suffixStyle:TextStyle(fontSize: 14,fontFamily: 'OpenSans-Semibold',color: Mycolors.red)  ,
                               // suffixIcon: Icon(Icons.phone),
                                labelText: "Mobile",
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
                              validator: (val) {
                                
                              },
                              keyboardType: TextInputType.phone,
                              style: new  TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
                            ),

                            Positioned(
                              right: width/20,
                              top: height/50,
                              child: InkWell(
                                onTap: (){
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>Chnagenumber()));

                                },
                                child: Text('change',style:TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.red) ,)))
                        ],
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
                        //obscureText:visability?false: true,
                          decoration: new InputDecoration(
                            labelText: "Email",
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


                 
                    Expanded(child: SizedBox()),
                    Container(
                      width: width,
                      height: height/15,
                      decoration: BoxDecoration(
                        color: Mycolors.red_dark,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))

                      ),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(12),bottomRight: Radius.circular(12))

                        ),
                        onPressed: (){
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=>Homescreen()));

                        },
                        child: Text("SAVE",
                                        style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
                      ),
                    )
                        ],
                      ),
                    ),

                  

                   

                  ],
                ),
              ),
              Positioned(
                left: width/2.5,
                top: height/1000,
                child: Container(
                width: width/5,
                height:width/5,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle
                ),
                child: Image.asset('assets/profile1.png'),
            ),
            
              ),
              Positioned(
                left: width/1.88,
                top: height/16,
                child: Container(
                  child: Image.asset('assets/add.png'),
                ),
              )
          ],
        ),
      ),
      
    );
  }
}