import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Home_screen/item_list/list.dart';

class Homecontent extends StatefulWidget {
  @override
  _HomecontentState createState() => _HomecontentState();
}

class _HomecontentState extends State<Homecontent> {
  ScrollController controller=ScrollController();
  ScrollController categorycontroller=ScrollController();
  bool closetopcontainer=false;
  var visability=false;
  double topcontainer=0;
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      double value=controller.offset/126;
      
     setState(() {
       topcontainer=value;
       print(value);
        closetopcontainer=controller.offset>10;
     });
    });
  }
  @override
  Widget build(BuildContext context) {
     var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    
    return Column(
      children: [
                      SizedBox(height: height/15,),
         Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                         // color: Colors.black,
                          width: width,
                          height: height/4.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(image: AssetImage('assets/card1.png'),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),]
                          ),
                          child: Container(
                            padding: EdgeInsets.only(left: 20,top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/logo1.png',height: 35,),
                                    SizedBox(height: height/70,),
                                    Image.asset('assets/profile2.png'),
                                    SizedBox(height: height/100,),
                                    Text("Abdullah Salah",
                                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Bold',color: Mycolors.dark),),
                                    Text("+965 55111111",
                                                  style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),

                                    Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left: 40),
                                     child: Text("1500",
                                                    style: TextStyle(fontSize: 28,fontFamily: 'OpenSans-Bold',color: Mycolors.dark2),),
                                   ),
                                //SizedBox(height: height/300,),
                               
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Text("Points",
                                                style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),),
                                ),
                                SizedBox(height: height/20,),
                                
                                Container(
                                  width: width/2.4,
                                  height: height/18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),),
                                    color: Colors.black.withOpacity(0.5)
                                  ),
                                  child: Center(
                                    child: Text("Check Rewards",
                                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Bold',color: Mycolors.white),),
                                  ),
                                ),
                                  ],
                                )
                                  ],
                                )
                              ],
                            ),
                          ),
                          )
                      ),
                      SizedBox(height:closetopcontainer?0: height/50,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 400),
                        opacity: closetopcontainer?0:1,
                          child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Trending",
                                                  style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Bold',color: Mycolors.dark),),
                                  Expanded(child: SizedBox()),
                                   Text("View All",
                                                  style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Semibold',color: Mycolors.red),),
                                ],
                              ),
                        ),
                      ),
                      SizedBox(height:closetopcontainer?0: height/150,),

                    AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity: closetopcontainer?0:1,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        width: width,
                        alignment: Alignment.topCenter,
                        height: closetopcontainer?0:height/4.2,
                        child: ListView.separated(
                          padding: EdgeInsets.only(left: 16,right: 16),
                          
                          separatorBuilder: (context, index) {return SizedBox(width: 10,);},
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context,int i){
                            return Center(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                child: Container(
                          width: width/1.3,
                          height: height/4.5,
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
                          child: Stack(
                                children: [
                                  Container(
                                    width: width,
                                    height: height/6.2,
                                    child: Image.asset('assets/food1.png',fit: BoxFit.fill,),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Image.asset('assets/pizza.png')),

                                    Positioned(
                                      bottom: 9,
                                      left: 80,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Pizza Hut",
                                                        style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                                           Text("Pizza",
                                                        style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Regular',color: Mycolors.dark4),),
                                        ],
                                      ),
                                    )
                                ],
                          ),
                        ),
                              ),
                            )
 ;
                          }),
                      ),
                    ),
                    Container(
                      width: width,
                      height: height/1.7,
                     // padding: EdgeInsets.symmetric(horizontal: 16),
                     // color: Colors.red,
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 20,top: 20),
                        controller: controller,
                        itemCount: Category.popularCategoryList.length,
                        itemBuilder:(BuildContext context,int i){
                          double scale=1.0;
                        
                          if (topcontainer>1){
                            scale=i+1-topcontainer;
                            //print(scale);
                            if(scale<0){
                            scale=0;
                          }else if(scale>1){
                            scale=1;
                          }
                          }
                          
                          return Opacity(
                            opacity: scale,
                            child: Transform(
                              alignment: Alignment.bottomCenter,
                              transform: Matrix4.identity()..scale(scale,scale),
                              child: Align(
                                heightFactor: 0.7,
                                alignment: Alignment.topCenter,

                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 16),
                                    width: width,
                                    height: 180,
                                     decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                        ],
                  color: Colors.white,),
                  child: ClipRRect(
                    borderRadius:  BorderRadius.circular(24),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(child: Image.asset(Category.popularCategoryList[i].imagePath,fit: BoxFit.fill,)),
                            Positioned(
                              left: 30,
                              top: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(Category.popularCategoryList[i].secondry_title,
                                          style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Category.popularCategoryList[i].color),),
                                Text(Category.popularCategoryList[i].title,
                                          style: TextStyle(fontSize: 34,fontFamily: 'OpenSans-Semibold',color: Category.popularCategoryList[i].color),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                                  ),

                              ),
                            ),
                          );
                        } ),
                    )
      ],
      
    );
  }
}