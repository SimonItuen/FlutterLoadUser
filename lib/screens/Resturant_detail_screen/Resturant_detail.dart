import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Resturant_detail_screen/Special_deal.dart';

class Resturantdetails extends StatefulWidget {
  @override
  _ResturantdetailsState createState() => _ResturantdetailsState();
}

class _ResturantdetailsState extends State<Resturantdetails> {
  @override
  Widget build(BuildContext context) {
      var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
        color: Mycolors.white,
        
      ),
      child: Stack(
        children: [
          Container(
            width: width,
            child: Image.asset('assets/food11.png',fit: BoxFit.fill,)),

            Container(
              width: width,
              height: height/10,
              //color: Colors.red,
              child: Column(
                children: [
                  SizedBox(height: height/25,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: null),
                      IconButton(icon: Icon(Icons.share,color: Colors.white,), onPressed: null)
                    ],

                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 80),
              child: Container(
                width: width,
                height: height,
              //  margin: EdgeInsets.symmetric(horizontal: 16),
                //color: Colors.red,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: height/10,),
                        Container(
               margin: EdgeInsets.symmetric(horizontal: 16),
                          width: width,
                          height: height/5,
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
                            color: Colors.white
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 19,top: 10,right: 19),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset('assets/pizza.png'),
                                    SizedBox(width: width/30,),
                                    Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Pizza Hut",
                                   style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                                   Text("Pizza",
                                  style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Regular',color: Mycolors.dark4),),
                                        ],
                                      ),
                                    ),Expanded(child: SizedBox()),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8),
                                      child: Image.asset('assets/info.png'),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(height: height/50,),
                              Container(
                                width: width,
                                height: 1,
                                color: Mycolors.white,
                              ),
                              SizedBox(height: height/70,),

                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 24),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Text("MY POINTS",
                                     style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark4),),
                                     Text("100",
                                    style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.dark),),
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      height: height/18,
                                      color: Mycolors.white,
                                    ),
                                    Column(
                                      children: [
                                        Text("TOTAL ORDERS",
                                     style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark4),),
                                     Text("20",
                                    style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.dark),),
                                      ],
                                    ),
                                    Container(
                                      width: 1,
                                      height: height/18,
                                      color: Mycolors.white,
                                    ),
                                    Column(
                                      children: [
                                        Text("JOINED ON",
                                     style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark4),),
                                     Text("JUN,20",
                                    style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.dark),),
                                      ],
                                    ),
                                   
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                         SizedBox(height: height/50,),
                        InkWell(
                          onTap: (){
                            Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false, // set to false
                                  pageBuilder: (_, __, ___) => Speacialdeal(),
                                ),
                              );
                          },
                          child: Container(
               margin: EdgeInsets.symmetric(horizontal: 16),
                            width: width,
                            height: height/3.5,
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
                              color: Colors.white
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: width,
                                      height: height/4.5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                                        child: Image.asset('assets/food11.png',fit: BoxFit.fill,)),
                                    ),
                                    SizedBox(height: height/60,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                           Text("Special Deal 100% OFF",
                                  style: TextStyle(fontSize: 14,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                                  Text("Expires in 3 days",
                                  style: TextStyle(fontSize: 10,fontFamily:'OpenSans-Regular',color: Mycolors.dark),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                  right: 0,
                                  top: height/7,
                                  child: Container(
                                      width: width/4,
                                      height: height/18,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),),
                                        color: Colors.black.withOpacity(0.5)
                                      ),
                                      child: Center(
                                        child: Text("10 Points",
                                                      style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Semibold',color: Mycolors.white),),
                                      ),
                                    ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        SizedBox(height: height/50,),
                         InkWell(
                           onTap: (){
                             Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false, // set to false
                                  pageBuilder: (_, __, ___) => Speacialdeal(),
                                ),
                              );
                           },
                           child: Container(
               margin: EdgeInsets.symmetric(horizontal: 16),
                            width: width,
                            height: height/3.5,
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
                              color: Colors.white
                            ),
                            child: Stack(
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: width,
                                      height: height/4.5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                                        child: Image.asset('assets/food12.png',fit: BoxFit.fill,)),
                                    ),
                                    SizedBox(height: height/60,),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                           Text("Special Deal 100% OFF",
                                  style: TextStyle(fontSize: 14,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                                  Text("Expires in 3 days",
                                  style: TextStyle(fontSize: 10,fontFamily:'OpenSans-Regular',color: Mycolors.dark),),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                Positioned(
                                  right: 0,
                                  top: height/7,
                                  child: Container(
                                      width: width/4,
                                      height: height/18,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),),
                                        color: Colors.black.withOpacity(0.5)
                                      ),
                                      child: Center(
                                        child: Text("10 Points",
                                                      style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Semibold',color: Mycolors.white),),
                                      ),
                                    ),
                                ),
                              ],
                            ),
                        ),
                         ),

                        SizedBox(height: height/50,),
                        Container(
               margin: EdgeInsets.symmetric(horizontal: 16),
                          width: width,
                          height: height/3.5,
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
                            color: Colors.white
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    width: width,
                                    height: height/4.5,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                                      child: Image.asset('assets/food12.png',fit: BoxFit.fill,)),
                                  ),
                                  SizedBox(height: height/60,),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                      children: [
                                         Text("Special Deal 100% OFF",
                                style: TextStyle(fontSize: 14,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                                Text("Expires in 3 days",
                                style: TextStyle(fontSize: 10,fontFamily:'OpenSans-Regular',color: Mycolors.dark),),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              
                            
                            Container(
                              width: width,
                              height: height/4.5,
                              decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(topRight: Radius.circular(12),topLeft: Radius.circular(12)),
                              color: Colors.black.withOpacity(0.5)
                              ),
                              child: Center(
                                child: Image.asset('assets/lock.png'),
                              ),
                            ),

                            Positioned(
                                right: 0,
                                top: height/7,
                                child: Container(
                                    width: width/4,
                                    height: height/18,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),),
                                      color: Colors.black.withOpacity(0.5)
                                    ),
                                    child: Center(
                                      child: Text("10 Points",
                                                    style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Semibold',color: Mycolors.white),),
                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),


                        
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
      ),
      
    );
  }
}