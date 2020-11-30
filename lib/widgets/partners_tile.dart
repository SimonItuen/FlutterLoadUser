import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:load/helper/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

class OurPartnersTile extends StatelessWidget {
  final Function() onPressed;
  final String name;
  /*final String logoUrl;*/
  final String coverUrl;

  OurPartnersTile({
    this.onPressed,
    this.name,
    this.coverUrl,
  });

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.21667;
    double height = width;
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(width * 0.15385))),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(width * 0.15385))),
            child: ClipRRect(
              borderRadius: BorderRadius.all(
                (Radius.circular(width * 0.15385)),
              ),
              child: Stack(
                    fit: StackFit.expand,
                    alignment: AlignmentDirectional.bottomCenter,
                    children: <Widget>[
                      SpinKitFadingCircle(
                        color: Mycolors.textfield,
                      ),
                      coverUrl.startsWith('https')
                          ?  FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: coverUrl,
                        width: width,
                        height: height,
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                      ): Image.asset('assets/placeholder.png', fit: BoxFit.fill),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          height: height*0.7*0.5,
                          color: Color(0xBF000000),
                          child: Align(
                            alignment: Alignment.center,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal:width * 0.15385),
                              child: Text('${name.toString()}',
                                overflow: TextOverflow.ellipsis,
                                maxLines: 3,
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Bold',color: Mycolors.textfield),),
                            ),
                          ),
                        ),
                      )
                    ],
                  )
            ),
          ),
        ),
      ),
    );
  }
}
