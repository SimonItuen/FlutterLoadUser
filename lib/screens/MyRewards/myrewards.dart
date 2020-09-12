import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/MyRewards/points.dart';

class Myreward extends StatefulWidget {
  @override
  _MyrewardState createState() => _MyrewardState();
}

class _MyrewardState extends State<Myreward> {
  @override
  Widget build(BuildContext context) {
     var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
              //padding: EdgeInsets.symmetric(horizontal: 8),
              width: width,
              height: height,
              child: ListView.separated(
                separatorBuilder: (context, index) {return SizedBox(height: height/30,);},
                padding: EdgeInsets.only(top: 20,left: 8,right: 8,bottom: 100),
                itemCount: 5,
                itemBuilder: (context,int i){
                  return InkWell(
                    onTap: (){
                       Navigator.of(context).push(
                                PageRouteBuilder(
                                  opaque: false, // set to false
                                  pageBuilder: (_, __, ___) => Points(),
                                ),
                              );
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
            );
  }
}