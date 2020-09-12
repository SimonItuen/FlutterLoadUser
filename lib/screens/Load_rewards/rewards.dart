import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Load_rewards/Rewards_details_page.dart';

class Rewards extends StatefulWidget {
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
      child: ListView(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.only(top: 0),
        children: [
          SizedBox(height: height/50,),
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Rewardsdetails()));
            },
            child: Container(
              width: width,
              height: height/9,
              padding: EdgeInsets.only(left: 9,right: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Mycolors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Get 20% Discount",
                            style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("5",
                            style: TextStyle(fontSize: 18,fontFamily:'OpenSans-Semibold',color: Mycolors.red),),
                            SizedBox(height: height/80,),
                      Text("Points",
                            style: TextStyle(fontSize: 12,fontFamily:'OpenSans-Semibold',color: Mycolors.dark4),),

                    ],
                  )
                ],
              ),
            ),
          ),

           SizedBox(height: height/70,),
          Container(
            width: width,
            height: height/9,
            padding: EdgeInsets.only(left: 9,right: 9),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Mycolors.white
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Get 20% Discount",
                          style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("10",
                          style: TextStyle(fontSize: 18,fontFamily:'OpenSans-Semibold',color: Mycolors.red),),
                          SizedBox(height: height/80,),
                    Text("Points",
                          style: TextStyle(fontSize: 12,fontFamily:'OpenSans-Semibold',color: Mycolors.dark4),),

                  ],
                )
              ],
            ),
          ),

          SizedBox(height: height/70,),
          Opacity(
            opacity: 0.5,
            child: Container(
              width: width,
              height: height/9,
              padding: EdgeInsets.only(left: 9,right: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Mycolors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Get 50% Discount",
                            style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("15",
                            style: TextStyle(fontSize: 18,fontFamily:'OpenSans-Semibold',color: Mycolors.red),),
                            SizedBox(height: height/80,),
                      Text("Points",
                            style: TextStyle(fontSize: 12,fontFamily:'OpenSans-Semibold',color: Mycolors.dark4),),

                    ],
                  )
                ],
              ),
            ),
          ),

           SizedBox(height: height/70,),
          Opacity(
            opacity: 0.5,
            child: Container(
              width: width,
              height: height/9,
              padding: EdgeInsets.only(left: 9,right: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Mycolors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Get 50% Discount",
                            style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("15",
                            style: TextStyle(fontSize: 18,fontFamily:'OpenSans-Semibold',color: Mycolors.red),),
                            SizedBox(height: height/80,),
                      Text("Points",
                            style: TextStyle(fontSize: 12,fontFamily:'OpenSans-Semibold',color: Mycolors.dark4),),

                    ],
                  )
                ],
              ),
            ),
          ),

           SizedBox(height: height/70,),
          Opacity(
            opacity: 0.5,
            child: Container(
              width: width,
              height: height/9,
              padding: EdgeInsets.only(left: 9,right: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Mycolors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Get 50% Discount",
                            style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("15",
                            style: TextStyle(fontSize: 18,fontFamily:'OpenSans-Semibold',color: Mycolors.red),),
                            SizedBox(height: height/80,),
                      Text("Points",
                            style: TextStyle(fontSize: 12,fontFamily:'OpenSans-Semibold',color: Mycolors.dark4),),

                    ],
                  )
                ],
              ),
            ),
          ),

           SizedBox(height: height/70,),
          Opacity(
            opacity: 0.5,
            child: Container(
              width: width,
              height: height/9,
              padding: EdgeInsets.only(left: 9,right: 9),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Mycolors.white
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Get 50% Discount",
                            style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: Mycolors.dark),),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("15",
                            style: TextStyle(fontSize: 18,fontFamily:'OpenSans-Semibold',color: Mycolors.red),),
                            SizedBox(height: height/80,),
                      Text("Points",
                            style: TextStyle(fontSize: 12,fontFamily:'OpenSans-Semibold',color: Mycolors.dark4),),

                    ],
                  )
                ],
              ),
            ),
          ),
          SizedBox(height: height/4,),

        ],
      ),
      
    );
  }
}