import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Load_rewards/history.dart';
import 'package:load/screens/Load_rewards/rewards.dart';
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/screens/verification3_screen/verification3.dart';

class Loadreward extends StatefulWidget {
  @override
  _LoadrewardState createState() => _LoadrewardState();
}

class _LoadrewardState extends State<Loadreward> {
  PageController controller=PageController();
  var reward=false;
  var history=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      history=false;
      reward=true;
    });
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      color: Mycolors.red,
      child: Column(
        children: [
          SizedBox(height: height/50,),
          Expanded(
            child: Container(
             // padding: EdgeInsets.only(left: 16,right: 16,top: 20),
              width: width,
              //height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
                color: Colors.white
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Current Points",
                                                    style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark4),),
                        Text("14",
                                                    style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Mycolors.red),),
                      ],
                    ),
                    
                  ),
                  Container(
                    width: width,
                    height: 2,
                    color: Mycolors.white,
                  ),
                  SizedBox(height: height/50,),
                  Padding(
                    padding: const EdgeInsets.only(left: 65,right: 65),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            controller.jumpToPage(0);
                            setState(() {
                              reward=true;
                              history=false;
                            });
                          },
                          child: Text("Rewards",
                                                        style: TextStyle(fontSize: 16,fontFamily:reward?'OpenSans-Semibold': 'OpenSans-Regular',color: Mycolors.dark),),
                        ),
                          InkWell(
                            onTap: (){
                            controller.jumpToPage(1);
                              setState(() {
                                history=true;
                                reward=false;
                              });
                            },
                            child: Text("History",
                                                        style: TextStyle(fontSize: 16,fontFamily:history?'OpenSans-Semibold': 'OpenSans-Regular',color: Mycolors.dark),),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: height/50,),
                  Row(
                    children: [
                      Container(
                    width: width/2,
                    height: 2,
                    color:reward? Mycolors.dark: Mycolors.white,
                  ),
                  Container(
                    width: width/2,
                    height: 2,
                    color:history? Mycolors.dark: Mycolors.white,
                  ),
                    ],
                  ),

                  Expanded(
                    child: Container(
                      width: width,
                      //height: height/2,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: PageView(
                        physics: NeverScrollableScrollPhysics(),
                        controller: controller,
                        children: [
                            Rewards(),
                            History()
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}