import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Rewardsdetails extends StatefulWidget {
  @override
  _RewardsdetailsState createState() => _RewardsdetailsState();
}

class _RewardsdetailsState extends State<Rewardsdetails> {
  PageController controller=PageController(initialPage: 1,viewportFraction: 0.88);
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
          Navigator.pop(context);
        }),
        title: Text('Get 20% Discount' ,style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
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
              Column(
                children: [
                  Container(
                    width: width,
                    height: height/1.4,
                   // color: Colors.yellow,
                    child: PageView(
                      controller: controller,
                      children: [
                        Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: width/1.2,
                            height: height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                               boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],

                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset('assets/food8.png',fit: BoxFit.cover,)),
                          ),
                        ),

                         Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: width/1.2,
                            height: height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                               boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],

                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset('assets/food9.png',fit: BoxFit.cover,)),
                          ),
                        ),


                         Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            width: width/1.2,
                            height: height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white,
                               boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],

                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.asset('assets/food10.png',fit: BoxFit.cover,)),
                          ),
                        )


                      ],
                    ),
                  ),
                  SizedBox(height: height/40,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                controller: controller,
                count:  3,
                axisDirection: Axis.horizontal,
                effect:  SlideEffect(
                  spacing:  8.0,
                  radius:  81.0,
                  dotWidth:  16.0,
                  dotHeight:  4.0,
                  paintStyle:  PaintingStyle.fill,
                  strokeWidth:  1.5,
                  dotColor:  Mycolors.red.withOpacity(0.3),
                  activeDotColor:  Mycolors.red
                ),
              )

                    ],
                  ),

                   Expanded(child: SizedBox(),),              
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: width,
                          height: height/14,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          color: Mycolors.red_dark,
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            onPressed: (){
                              //Navigator.pop(context);
                              showDialog(context: context,
                              builder: (BuildContext context){
                                return AlertDialog(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)
                                  ),
                                backgroundColor: Colors.white,
                                title:  Text("Are you sure you want to select this reward?",
                            style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                            actions: [
                              FlatButton(
                                onPressed: (){

                                },
                                child: Text("NO",
                            style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: Mycolors.red),),
                              ),
                              FlatButton(
                                onPressed: (){
                                  
                                },
                                child: Text("YES",
                            style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: Mycolors.red),),
                              ),
                            
                            ],
                              );
                              });
                          }, child: Center(
                            child:Text("SELECT REWARDS",
                                          style: Theme.of(context).primaryTextTheme.headline3,) ,
                          )),
                        ),
                      )
                        
                ],
              )
          ],
        ),
      ),
     
      
    );
  }
}