import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:load/helper/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

class CardTile extends StatelessWidget {
  final Function() onPressed;
  final String name;
  final String logoUrl;
  final String coverUrl;
  final String points;
  final String bgColor;
  final String fontColor;
  final double scale;
  final bool isLastCard;

  CardTile(
      {this.onPressed,
      this.name,
      this.bgColor='0XFFFFFFFF',
      this.fontColor='0XFF000000',
      this.logoUrl,
      this.coverUrl,
      this.points,
      this.scale,
      this.isLastCard});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.width * 0.96667 * 0.49840;
    print(bgColor);
    return InkWell(
        onTap: onPressed,
        child: Opacity(
          opacity: scale,
          child: Transform(
            alignment: Alignment.bottomCenter,
            transform: Matrix4.identity()..scale(scale, scale),
            child: Align(
              heightFactor: isLastCard ? 1 : 0.7,
              alignment: Alignment.topCenter,
              child: Container(
                margin: EdgeInsets.only(
                    left: 16, right: 16, bottom: isLastCard ? 40 : 0),
                width: width * 0.96667,
                height: height,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Color(int.parse(bgColor)),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          right: -4,
                          child: Container(
                            child: coverUrl.startsWith('http')
                                ? FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: coverUrl,
                              height: height * 0.78048,
                              width: height,
                              fit: BoxFit.cover,
                              alignment: Alignment.topRight,
                            )
                                : coverUrl.startsWith('assets')
                                ? Image.asset(
                              coverUrl,
                              width: width * 0.96667,
                              height: height,
                              fit: BoxFit.cover,
                            )
                                : Image.asset(
                              'assets/placeholder.png',
                              width: width * 0.96667,
                              height: height,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:14.0, vertical: 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(
                                    child: logoUrl.startsWith('http')
                                        ? CircleAvatar(
                                      backgroundColor:
                                      Colors.transparent,
                                      radius: width * 0.10556 * 0.5,
                                      backgroundImage: NetworkImage(
                                        logoUrl,
                                      ),
                                    )
                                        : logoUrl.startsWith('assets')
                                        ? Image.asset(
                                      logoUrl,
                                      width: width * 0.10556,
                                      height: width * 0.10556,
                                      fit: BoxFit.fill,
                                    )
                                        : CircleAvatar(
                                      radius:
                                      width * 0.10556 * 0.5,
                                      backgroundImage: AssetImage(
                                        'assets/placeholder.png',
                                      ),
                                    ),
                                  ),
                                  Text(
                                    name,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontFamily: 'OpenSans-Semibold',
                                        color: Color(int.parse(fontColor))),
                                  ),
                                ],
                              ),
                              Text(
                                points,
                                style: TextStyle(
                                    fontSize: 34,
                                    fontFamily: 'BAHNSCHRIFT-regular',
                                    color: Color(int.parse(fontColor))),
                              ),
                              /*Stack(
                                children: [
                                  Container(
                                    child: coverUrl.startsWith('http')
                                        ? FadeInImage.memoryNetwork(
                                          placeholder: kTransparentImage,
                                          image: coverUrl,
                                          height: height * 0.78048,
                                          width: height,
                                          fit: BoxFit.fitWidth,
                                          alignment: Alignment.topCenter,
                                        )
                                        : coverUrl.startsWith('assets')
                                            ? Image.asset(
                                                coverUrl,
                                                width: width * 0.96667,
                                                height: height,
                                                fit: BoxFit.fill,
                                              )
                                            : Image.asset(
                                                'assets/placeholder.png',
                                                width: width * 0.96667,
                                                height: height,
                                                fit: BoxFit.fill,
                                              ),
                                  ),
                                  Positioned(
                                    left: 30,
                                    top: 10,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              child: logoUrl.startsWith('http')
                                                  ? CircleAvatar(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      radius: width * 0.10556 * 0.5,
                                                      backgroundImage: NetworkImage(
                                                        logoUrl,
                                                      ),
                                                    )
                                                  : logoUrl.startsWith('assets')
                                                      ? Image.asset(
                                                          logoUrl,
                                                          width: width * 0.10556,
                                                          height: width * 0.10556,
                                                          fit: BoxFit.fill,
                                                        )
                                                      : CircleAvatar(
                                                          radius:
                                                              width * 0.10556 * 0.5,
                                                          backgroundImage: AssetImage(
                                                            'assets/placeholder.png',
                                                          ),
                                                        ),
                                            ),
                                            Text(
                                              name,
                                              style: TextStyle(
                                                  fontSize: 34,
                                                  fontFamily: 'OpenSans-Semibold',
                                                  color: Color(int.parse(fontColor))),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          points,
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'BAHNSCHRIFT-regular',
                                              color: Color(int.parse(fontColor))),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),*/
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
            ),
          ),
        ));
  }
}
