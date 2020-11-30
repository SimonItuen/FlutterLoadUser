import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:load/helper/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

class RewardTile extends StatelessWidget {

  final Function() onPressed;
  final String name;
  final String category;
  final String logoUrl;
  final String coverUrl;
  final String points;
  final bool isLocked;

  RewardTile({
    this.isLocked=false,
    this.onPressed,
    this.category,
    this.name,
    this.logoUrl,
    this.coverUrl,
    this.points
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width*0.95556;
    double height = width * 0.67151;
    return InkWell(
      onTap: isLocked ? () {} : onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(width * 0.03333))),
        child: Container(
          width: width,
          height: height,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                overflow: Overflow.visible,
                children: <Widget>[
                  Container(
                    height: width * 0.5,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: (Radius.circular(width * 0.03333)),
                          topRight: (Radius.circular(width * 0.03333)),
                        )),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: (Radius.circular(width * 0.03333)),
                        topRight: (Radius.circular(width * 0.03333)),
                      ),
                      child: coverUrl.startsWith('http')
                          ? Stack(
                        alignment: AlignmentDirectional.center,
                        children: <Widget>[
                          SpinKitFadingCircle(
                            color: Mycolors.textfield,
                          ),
                          FadeInImage.memoryNetwork(
                            placeholder: kTransparentImage,
                            image: coverUrl,
                            width: width,
                            height: width * 0.67230,
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.topCenter,
                          )
                        ],
                      )
                          : Image.asset('assets/placeholder.png', fit: BoxFit.fill,),
                    ),
                  ),
                  Visibility(
                    visible: isLocked,
                    child: Container(
                      height: width * 0.49948,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: (Radius.circular(width * 0.03671)),
                            topRight: (Radius.circular(width * 0.03671)),
                          ),
                          color: Color(0x80707070)),
                      child: Center(
                          child: SvgPicture.asset(
                            'assets/lock.svg',
                            fit: BoxFit.contain,
                          )),
                    ),
                  ),
                  Positioned(
                    bottom:-(height * 0.21105) ,
                    left: width* 0.04054,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(width * 0.03333))),
                      child: Container(
                        width: height * 0.29437,
                        height: height* 0.29437,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all((Radius.circular(width * 0.03333)),
                          ),
                          child: coverUrl.startsWith('http')
                              ? Stack(
                            alignment: AlignmentDirectional.center,
                            children: <Widget>[
                              SpinKitFadingCircle(
                                color: Mycolors.textfield,
                              ),
                              FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: logoUrl,
                                width: height * 0.29437,
                                height: height * 0.29437,
                                fit: BoxFit.fill,
                                alignment: Alignment.center,
                              )
                            ],
                          )
                              : Image.asset('assets/placeholder.png', fit: BoxFit.fill),
                        ),
                      ),
                    ),
                  ),
                  points!=null?Positioned(
                    bottom:-(height * 0.22093 * 0.6052) ,
                    right:  width* 0.04054,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(height * 0.22093 * 0.5))),
                      child: Container(
                        width: height * 0.22093,
                        height: height* 0.22093,
                        child: ClipRRect(
                          borderRadius: BorderRadius.all((Radius.circular(height * 0.22093 * 0.5)),
                          ),
                          child: Center(
                          child:Text('$points',
                          style: TextStyle(fontSize: points.length>5? 12:16,fontFamily: 'BAHNSCHRIFT-regular',color: Mycolors.dark),)
                      )
                        ),
                      ),
                    ),
                  ):Container(),

                ],
              ),
              Container(
                margin: EdgeInsets.only(left: width* 0.26689),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'OpenSans-Semibold',
                          color: Mycolors.dark),
                    ),
                    Text(
                      category.toString(),
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'OpenSans-Regular',
                          color: Mycolors.dark4),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
