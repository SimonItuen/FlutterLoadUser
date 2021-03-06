import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';

class RewardRedeemed extends StatefulWidget {
  final String message;
  final String pointDetail;
  final String type;

 RewardRedeemed({Key key, this.message, this.pointDetail, this.type,}) : super(key: key);

  @override
  _RewardRedeemedState createState() => _RewardRedeemedState();
}

class _RewardRedeemedState extends State<RewardRedeemed> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      color: Colors.black.withOpacity(0.5),
      child: Stack(
        children: [
          // IconButton(icon: Icon(Icons.cancel,color: Colors.white,size: 25,), onPressed: (){}),
          Column(
            children: [
              SizedBox(
                height: height / 5,
              ),
              Expanded(
                  child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Center(
                  child: Column(
                    children: [
                      // SizedBox(height: height/2.9,),
                      SizedBox(
                        height: height / 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:14.0),
                        child: Text(
                          widget.message.toString(),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).primaryTextTheme.headline4,
                        ),
                      ),
                      SizedBox(
                        height: height / 10,
                      ),
                      Text(
                        widget.pointDetail.toString(),
                        style: Theme.of(context).primaryTextTheme.headline1,
                      ),
                      Text(
                        widget.type.toString(),
                        style: Theme.of(context).primaryTextTheme.headline4,
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: width,
                          height: height / 14,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: Mycolors.red_dark,
                          ),
                          child: FlatButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Center(
                                child: Text(
                                  "GO BACK",
                                  style: Theme.of(context)
                                      .primaryTextTheme
                                      .headline3,
                                ),
                              )),
                        ),
                      )
                    ],
                  ),
                ),
              ))
            ],
          ),
          Positioned(
            //padding: const EdgeInsets.all(28.0),
            right: width / 40,
            top: height / 20,
            child: FlatButton(
              child: Icon(
                Icons.cancel,
                size: 50,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            left: width / 18,
            top: height / 8,
            child: Container(
              width: width / 1.1,
              height: width / 1.4,
              decoration: BoxDecoration(
                  //color: Colors.black,
                  // borderRadius: BorderRadius.circular(14)
                  ),
              child: ClipRRect(
                  // borderRadius: BorderRadius.circular(14),
                  child: Image.asset(
                'assets/congrats.png',
                fit: BoxFit.fill,
              )),
            ),
          )
        ],
      ),
    );
  }
}
