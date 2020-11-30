import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:load/helper/colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadRewardTile extends StatelessWidget {
  final Function() onPressed;
  final String name;
  final String points;
  final bool isLocked;

  LoadRewardTile(
      {this.onPressed,
      this.name,
      this.points,
      this.isLocked});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.91111;
    double height = width * 0.20121;
    return Center(
      child: InkWell(
        onTap: isLocked?(){}:onPressed,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(width * 0.03671))),
          child: Container(
            width: width,
            height: height,
            padding: EdgeInsets.only(left: 9,right: 9),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isLocked?Color(0x99F5F5F5):Color(0xFFF5F5F5)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$name',
                  style: TextStyle(fontSize: 16,fontFamily:'OpenSans-Semibold',color: isLocked?Color(0xFF707070):Color(0xFF212121)),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$points',
                      style: TextStyle(fontSize: 18,fontFamily:'BAHNSCHRIFT-regular',color: isLocked?Color(0xFFF48C86):Mycolors.red),),
                    SizedBox(height: height/80,),
                    Text(points.toString()!='1'?'Points':'Point',
                      style: TextStyle(fontSize: 12,fontFamily:'OpenSans-Semibold',color: isLocked?Color(0xFF707070):Color(0xFF212121)),),

                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
