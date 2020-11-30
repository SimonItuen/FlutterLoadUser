import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:load/helper/colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class TrendingTile extends StatelessWidget {
  final Function() onPressed;
  final String name;
  final String logoUrl;
  final String coverUrl;
  final String categoryName;

  TrendingTile({
    this.onPressed,
    this.name,
    this.logoUrl,
    this.coverUrl,
    this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width*0.82222;
    double height = width * 0.672298;
    return InkWell(
      onTap: onPressed,
      child: FittedBox(
        fit: BoxFit.fill,
        alignment: Alignment.topCenter,
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
                  alignment: AlignmentDirectional.bottomStart,
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
                            Positioned.fill(
                              child: FadeInImage.memoryNetwork(
                                placeholder: kTransparentImage,
                                image: coverUrl,
                                width: width,
                                height: width * 0.67230,
                                fit: BoxFit.fitWidth,
                                alignment: Alignment.topCenter,
                              ),
                            )
                          ],
                        )
                            : Image.asset('assets/placeholder.png', fit: BoxFit.fill,),
                      ),
                    ),
                    Positioned(
                      bottom:-(height * 0.21105) ,
                      left: width* 0.04054,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(width * 0.03333))),
                        child: Container(
                          width: height * 0.29648,
                          height: height* 0.29648,
                          child: ClipRRect(
                            borderRadius: BorderRadius.all((Radius.circular(width * 0.03333)),
                            ),
                            child: logoUrl.startsWith('http')
                                ? Stack(
                              alignment: AlignmentDirectional.center,
                              children: <Widget>[
                                SpinKitFadingCircle(
                                  color: Mycolors.textfield,
                                ),
                                FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: logoUrl,
                                  width: width * 0.19932,
                                  height: width * 0.19932,
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

                  ],
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.only(left: width* 0.26689),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                              fontSize: 13,
                              fontFamily: 'OpenSans-Semibold',
                              color: Mycolors.dark),
                        ),
                        Text(
                          categoryName.toString(),
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'OpenSans-Regular',
                              color: Mycolors.dark4),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
