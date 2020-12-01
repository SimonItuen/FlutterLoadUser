import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert' as convert;

class RewardQrscan extends StatefulWidget {
  @override
  _RewardQrscanState createState() => _RewardQrscanState();
}

class _RewardQrscanState extends State<RewardQrscan> {
  Color color=Colors.transparent;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration(milliseconds: 300), (){
      setState(() {
        color =Colors.black.withOpacity(0.5);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: true);

    var params = {
      "type": "singleReward",
      "rewards_id": _accountProvider.getTempRewardModel.id,
      "stores_id": _accountProvider.getTempRewardModel.storeId,
      "store_logo": _accountProvider.getTempRewardModel.storeLogoUrl,
      "title": _accountProvider.getTempRewardModel.title,
      "expiry": _accountProvider.getTempRewardModel.expiry,
      "store_name": _accountProvider.getTempRewardModel.storeName,
      "image": _accountProvider.getTempRewardModel.storeCoverUrl,
      "logo_image": _accountProvider.getTempRewardModel.storeLogoUrl,
      "required_load_point": _accountProvider.getTempRewardModel.points,
      "id": _accountProvider.getId,
      "name": _accountProvider.getFullName,
      "profile_photo": _accountProvider.getProfileUrl,
      "email": _accountProvider.getEmail,
      "mobile_number": _accountProvider.getPhone,
      "points": _accountProvider.getPoints,

    };
    String json = convert.jsonEncode(params);

    final key = encrypt.Key.fromUtf8('my 32 length key................');
    final iv = encrypt.IV.fromUtf8('my 16 length iv8');
    final encrypter = encrypt.Encrypter(encrypt.AES(key));

    final encrypted = encrypter.encrypt(json, iv: iv);
    /*final decrypted = encrypter.decrypt(encrypted, iv: iv);*/


    /*"data": {
    "id": 48,
    "name": "raju",
    "profile_photo": "https://laravel.gowebbidemo.com/122066/public/uploads/profile/DXs99Q_1603085415.jpeg",
    "email": "ashok@gmail.com",
    "mobile_number": "7501222640",
    "email_verified_at": null,
    "role": "customer",
    "user_of": null,
    "api_token": "f17965cc27d5c1bf1d3830f11183f25484c09630",
    "status": "Active",
    "created_at": "2020-10-19T05:30:15.000000Z",
    "updated_at": "2020-10-19T05:30:15.000000Z"
    }*/
    return Container(
      width: width,
      height: height,
      color: color,
      child: Stack(
        alignment: AlignmentDirectional.topCenter,
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
                      SizedBox(
                        height: height / 2.6,
                      ),
                      Text(
                        (_accountProvider.getTempRewardModel.title).toString(),
                        style: Theme.of(context).primaryTextTheme.headline1,
                      ),
                      SizedBox(
                        height: height / 20,
                      ),
                      Text(
                        (_accountProvider.getTempRewardModel.storeName)
                            .toString(),
                        style: Theme.of(context).primaryTextTheme.headline2,
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
                                setState(() {
                                  color =Colors.transparent;
                                });
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
                setState(() {
                  color =Colors.transparent;
                });
                Navigator.pop(context);
              },
            ),
          ),
          Positioned(
            top: height/6,
            child: Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                  //color: Colors.black,
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14)),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(12),
                            topRight: Radius.circular(12))),
                    elevation: 0,
                    child: QrImage(
                      data: encrypted.base64.toString(),
                      version: QrVersions.auto,
                      size: MediaQuery.of(context).size.width * 0.7,
                      gapless: false,
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
