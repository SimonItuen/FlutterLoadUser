import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/screens/Reset2_password_screen/reset2_password.dart';
import 'package:load/screens/Resturant_detail_screen/Resturant_detail.dart';

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  @override
  Widget build(BuildContext context) {
        var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          Navigator.pop(context);
        }),
        title:  Container(
          
          height: height/18,
          decoration: BoxDecoration(
            
            borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          ),
          child: Theme(
            data: ThemeData(
              primaryColor: Mycolors.red
              
            ),
            child: TextFormField(
              
              
                decoration: new InputDecoration(
                  contentPadding: EdgeInsets.only(top: 3,left: 10),
                  suffixIcon: Icon(Icons.search),
                 // labelText: "Email Address",
                  labelStyle: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.red) ,
                  hintText: 'Search stores',
                  hintStyle:  TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
                  fillColor: Colors.white,
                  
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(
                  
                      color: Colors.white
                    )
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: new BorderRadius.circular(14.0),
                    borderSide: new BorderSide(
                      color: Colors.white
                    ),
                  ),
                  
                  border: new OutlineInputBorder(
                    
                    borderRadius: new BorderRadius.circular(14.0),
                    borderSide: new BorderSide(
                      color: Colors.white
                    ),
                  ),
                  //fillColor: Colors.green
                ),
                validator: (val) {
                  
                },
                keyboardType: TextInputType.emailAddress,
                style: new  TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
              ),
          ),
        ),

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
              //padding: EdgeInsets.symmetric(horizontal: 8),
              width: width,
              height: height,
              child: ListView.separated(
                separatorBuilder: (context, index) {return SizedBox(height: height/30,);},
                padding: EdgeInsets.only(top: 20,left: 8,right: 8,bottom: 20),
                itemCount: 5,
                itemBuilder: (context,int i){
                  return InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Resturantdetails()));
                    },
                    child: Container(
                      width: width,
                      height: height/3.5,
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
                            color: Colors.white
                      ),
                      child: Stack(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: width,
                                height: height/4.7,
                                child: Image.asset('assets/food7.png',fit: BoxFit.fill,),
                              ),
                              SizedBox(height: height/200,),
                              Padding(
                                padding: const EdgeInsets.only(left:80),
                                child: Text("Pizza Hut",
                                 style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                              ),
                              SizedBox(height: height/200,),
                              Padding(
                                padding: const EdgeInsets.only(left: 80),
                                child: Text("Pizza",
                                style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Regular',color: Mycolors.dark4),),
                              ),
                            ],
                          ),
                           Positioned(
                                      bottom: 5,
                                      left: 10,
                                      child: Image.asset('assets/pizza.png')),
                           Positioned(
                                      bottom: 32,
                                      right: 15,
                                      child: Container(
                                        width: width/10,
                                        height: width/10,
                                        decoration: BoxDecoration(
                                           boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: Offset(0, 3), // changes position of shadow
                                  ),
                                          ],
                                          shape: BoxShape.circle,
                                          color: Mycolors.white
                                        ),
                                        child: Center(
                                    child:Text("100",
                                style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.dark),)
                                        ),
                                      )
                                      ),
                        ],
                      ),
                    ),
                  );
                }),
            )
              
          ],
        ),
      ),
      
    );
  }
}