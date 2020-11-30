import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:load/helper/colors.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';

class StoreOfferTile extends StatelessWidget {
  final Function() onPressed;
  final String name;
  final String points;
  final String coverUrl;
  final String expiry;
  final bool isLocked;

  StoreOfferTile(
      {this.onPressed,
      this.name,
      this.points,
      this.coverUrl,
      this.expiry,
      this.isLocked});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width * 0.90777;
    double height = width * 0.63953;
    var inputFormat = DateFormat("yyyy-MM-dd");
    var dueDate = inputFormat.parse(expiry);
    final date = DateTime.now();
    final difference = dueDate.difference(date).inDays;
    return Center(
      child: InkWell(
        onTap: isLocked ? () {} : onPressed,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(width * 0.03671))),
          child: Container(
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  overflow: Overflow.clip,
                  children: <Widget>[
                    Container(
                      height: width * 0.49948,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                        topLeft: (Radius.circular(width * 0.03671)),
                        topRight: (Radius.circular(width * 0.03671)),
                      )),
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: (Radius.circular(width * 0.03671)),
                          topRight: (Radius.circular(width * 0.03671)),
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
                            : Image.asset(
                                'assets/placeholder.png',
                                fit: BoxFit.fill,
                              ),
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
                      child: Container(
                          margin: EdgeInsets.only(bottom: 12),
                          padding: EdgeInsets.only(left: 1, top: 1, bottom: 1),
                          decoration: BoxDecoration(
                              color: Color(0xFF9E9E9E),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              )),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Color(0x80000000),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              child: Text(
                                  points.toString() != '1'
                                      ? '$points points'
                                      : '$points point',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'BAHNSCHRIFT-regular',
                                      color: Mycolors.textfield)),
                            ),
                          )),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            name,
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'OpenSans-Semibold',
                                color: Mycolors.dark),
                          ),
                          Text(
                            difference > 1
                                ? 'Expires in ${difference.toString()} days'
                                : difference < 1
                                    ? 'Expires Today'
                                    : 'Expires in ${difference.toString()} day',
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: 'OpenSans-regular',
                                color: Mycolors.dark),
                          )
                        ],
                      ),
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
