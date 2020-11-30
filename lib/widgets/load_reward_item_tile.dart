import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:load/helper/colors.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:transparent_image/transparent_image.dart';

class LoadRewardItemTile extends StatelessWidget {
  final String coverUrl;

  LoadRewardItemTile({
    this.coverUrl,
  });

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height * 0.65625;
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        width: width,
        height: height,
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Container(
              child: coverUrl.startsWith('http')
                  ? Stack(
                      alignment: AlignmentDirectional.center,
                      children: <Widget>[
                        CachedNetworkImage(
                          placeholder: (context, url) => SpinKitFadingCircle(
                            color: Mycolors.textfield,
                          ),
                          imageUrl: coverUrl,
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ],
                    )
                  : coverUrl.startsWith('assets')
                      ? Image.asset(
                          coverUrl,
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          'assets/placeholder.png',
                          width: width,
                          height: height,
                          fit: BoxFit.cover,
                        ),
            ),
          ),
        ),
      ),
    );
  }
}
