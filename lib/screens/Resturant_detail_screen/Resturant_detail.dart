import 'dart:async';
import 'dart:io';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/model/reward_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Qrscan_screen/reward_qrscan.dart';
import 'package:load/screens/Resturant_detail_screen/Special_deal.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:share/share.dart';
import 'package:http/http.dart' as http;
import 'package:load/model/store_model.dart';
import 'package:load/model/offer_model.dart';
import 'package:transparent_image/transparent_image.dart';
import 'package:load/widgets/store_offer_tile.dart';

class Resturantdetails extends StatefulWidget {
  static String routeName = '/restaurant-details-screen';
  @override
  _ResturantdetailsState createState() => _ResturantdetailsState();
}

class _ResturantdetailsState extends State<Resturantdetails> {
  bool isLoading = true;
  BuildContext _context;
  List<OfferModel> list = new List<OfferModel>();
  StoreModel model = StoreModel();
  String shareLink;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () async {
      await getStoreId();
      createDynamicLink(
          model.name, model.categoryName, model.coverImageUrl, Provider.of<UserAccountProvider>(context, listen: false).getStoreId);
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
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        _context = context;
        return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: Mycolors.white,
          ),
          child: Column(
            children: <Widget>[
              Stack(
                children: [
                  Visibility(
                    visible: !isLoading,
                    child: Container(
                      width: width,
                      height: height * 0.28125,
                      decoration: BoxDecoration(
                        color: Colors.red,
                      ),
                      child: Stack(
                        children: <Widget>[
                          Container(
                            height: height * 0.28125,
                            child: _accountProvider.getStoreModel.coverImageUrl
                                    .toString()
                                    .startsWith('http')
                                ? Stack(
                                    alignment: AlignmentDirectional.center,
                                    children: <Widget>[
                                      FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: _accountProvider
                                            .getStoreModel.coverImageUrl,
                                        width: width,
                                        height: height * 0.28125,
                                        fit: BoxFit.cover,
                                        alignment: Alignment.topCenter,
                                      )
                                    ],
                                  )
                                : Container(),
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height: height / 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      icon: Icon(
                                        Icons.arrow_back,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      }),
                                  IconButton(
                                      icon: Icon(
                                        Icons.share,
                                        color: Colors.white,
                                      ),
                                      onPressed: () {
                                        shareCode(
                                            _accountProvider.getStoreModel.name,
                                            shareLink,
                                            context);
                                      })
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  overflow: Overflow.visible,
                  children: <Widget>[
                    list.isNotEmpty
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: false,
                            itemCount: list.length,
                            scrollDirection: Axis.vertical,
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.width *
                                    0.911111 *
                                    0.41159),
                            itemBuilder: (BuildContext context, int i) {
                              return StoreOfferTile(
                                name: list[i].title,
                                points: list[i].requiredLoadPoints,
                                coverUrl: list[i].storeImage,
                                expiry: list[i].expiry,
                                isLocked: int.parse(model.myPoints) <
                                    int.parse(list[i].requiredLoadPoints),
                                onPressed: () {
                                  Provider.of<UserAccountProvider>(context,
                                          listen: false)
                                      .setTempSingleReward(RewardModel(
                                          storeName: model.name,
                                          storeLogoUrl: model.logoUrl,
                                          storeCoverUrl: list[i].storeImage,
                                          storeId: list[i].storeId,
                                          id: list[i].id,
                                          points: list[i].requiredLoadPoints,
                                          expiry: list[i].expiry,
                                          title: list[i].title));
                                  Navigator.of(context).push(TransparentRoute(
                                      builder: (BuildContext context) =>
                                          RewardQrscan()));
                                },
                              );
                            })
                        : Visibility(
                            visible: !isLoading,
                            child: Center(
                              child: Text(
                                'No Offers available',
                                style: TextStyle(
                                    fontFamily: 'OpenSans-Regular',
                                    color: Mycolors.dark4),
                              ),
                            ),
                          ),
                    isLoading
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Positioned(
                            top: -(MediaQuery.of(context).size.width *
                                0.911111 *
                                0.41159 *
                                0.11111),
                            right: 0,
                            left: 0,
                            child: Column(
                              children: <Widget>[
                                FittedBox(
                                  alignment: Alignment.center,
                                  fit: BoxFit.fill,
                                  child: Container(
                                    width: MediaQuery.of(context).size.width *
                                        0.911111,
                                    height: MediaQuery.of(context).size.width *
                                        0.911111 *
                                        0.41159,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            spreadRadius: 2,
                                            blurRadius: 5,
                                            offset: Offset(0,
                                                3), // changes position of shadow
                                          ),
                                        ],
                                        color: Colors.white),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 19,
                                              top: 12,
                                              right: 19,
                                              bottom: 4),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Card(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .all(Radius.circular(
                                                            width * 0.03333))),
                                                child: Container(
                                                  width: width * 0.13333,
                                                  height: width * 0.13333,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                      (Radius.circular(
                                                          width * 0.03333)),
                                                    ),
                                                    child: _accountProvider
                                                            .getStoreModel
                                                            .logoUrl
                                                            .toString()
                                                            .startsWith('http')
                                                        ? Stack(
                                                            alignment:
                                                                AlignmentDirectional
                                                                    .center,
                                                            children: <Widget>[
                                                              SpinKitFadingCircle(
                                                                color: Mycolors
                                                                    .textfield,
                                                              ),
                                                              FadeInImage
                                                                  .memoryNetwork(
                                                                placeholder:
                                                                    kTransparentImage,
                                                                image: _accountProvider
                                                                    .getStoreModel
                                                                    .logoUrl
                                                                    .toString(),
                                                                width: width *
                                                                    0.13333,
                                                                height: width *
                                                                    0.13333,
                                                                fit:
                                                                    BoxFit.fill,
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                              )
                                                            ],
                                                          )
                                                        : Image.asset(
                                                            'assets/placeholder.png',
                                                            fit: BoxFit.fill),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: width / 30,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 8.0),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _accountProvider
                                                          .getStoreModel.name
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'OpenSans-Semibold',
                                                          color: Mycolors.dark),
                                                    ),
                                                    Text(
                                                      _accountProvider
                                                          .getStoreModel
                                                          .categoryName
                                                          .toString(),
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontFamily:
                                                              'OpenSans-Regular',
                                                          color:
                                                              Mycolors.dark4),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Expanded(child: SizedBox()),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: width,
                                          height: 1,
                                          color: Mycolors.white,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 24,
                                              right: 24,
                                              top: 4,
                                              bottom: 4),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Text(
                                                    "MY POINTS",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'OpenSans-Semibold',
                                                        color: Mycolors.dark4),
                                                  ),
                                                  SizedBox(
                                                    height: height / 150,
                                                  ),
                                                  Text(
                                                    _accountProvider
                                                                .getStoreModel
                                                                .myPoints
                                                                .toString() !=
                                                            '0'
                                                        ? _accountProvider
                                                            .getStoreModel
                                                            .myPoints
                                                            .toString()
                                                        : "-",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'BAHNSCHRIFT-regular',
                                                        color: Mycolors.dark),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 1,
                                                height: height / 18,
                                                color: Mycolors.white,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "TOTAL ORDERS",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'OpenSans-Semibold',
                                                        color: Mycolors.dark4),
                                                  ),
                                                  SizedBox(
                                                    height: height / 150,
                                                  ),
                                                  Text(
                                                    _accountProvider
                                                                .getStoreModel
                                                                .totalOrders
                                                                .toString() !=
                                                            '0'
                                                        ? _accountProvider
                                                            .getStoreModel
                                                            .totalOrders
                                                            .toString()
                                                        : "-",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'BAHNSCHRIFT-regular',
                                                        color: Mycolors.dark),
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: 1,
                                                height: height / 18,
                                                color: Mycolors.white,
                                              ),
                                              Column(
                                                children: [
                                                  Text(
                                                    "JOINED ON",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontFamily:
                                                            'OpenSans-Semibold',
                                                        color: Mycolors.dark4),
                                                  ),
                                                  SizedBox(
                                                    height: height / 150,
                                                  ),
                                                  Text(
                                                    _accountProvider
                                                                .getStoreModel
                                                                .joinedOn
                                                                .toString() !=
                                                            ' '
                                                        ? _accountProvider
                                                            .getStoreModel
                                                            .joinedOn
                                                            .toString()
                                                        : "-",
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        fontFamily:
                                                            'BAHNSCHRIFT-regular',
                                                        color: Mycolors.dark),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  getStoreId() async {
    setState(() {
      isLoading = true;
    });
    BuildContext context = _context;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/store-details';

    var map = convert.jsonEncode(<String, String>{
      'api_token': _accountProvider.getAccessToken,
      'store_id': _accountProvider.getStoreId
    });


    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          },
          body: map);


      if (response.statusCode == 200) {

        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {
          Map<String, dynamic> map = jsonResponse['data'];
          model = StoreModel.fromJson(map);
          list = model.list;
          if(model.name==null.toString()){
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius:
                        BorderRadius.circular(
                            12)),
                    backgroundColor: Colors.white,
                    title: Text(
                      "This store is not found",
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily:
                          'OpenSans-Semibold',
                          color: Mycolors.dark),
                    ),
                    actions: [
                      FlatButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pop();
                          Navigator.of(context)
                              .pop();
                        },
                        child: Text(
                          "Go Back",
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily:
                              'OpenSans-Semibold',
                              color: Mycolors.red),
                        ),
                      ),
                    ],
                  );
                });
          }
          _accountProvider.setStoreDetails(model);

          setState(() {
            isLoading = false;
          });
        } else {
          if (jsonResponse.toString().isNotEmpty) {
            final snackBar = SnackBar(
              content: Text(jsonResponse['message']
                  .toString()
                  .replaceAll('{', '')
                  .replaceAll('}', '')
                  .replaceAll('[', '')
                  .replaceAll(']', '')),
              duration: Duration(seconds: 4),
            );
            /*Scaffold.of(context).showSnackBar(snackBar);*/
            setState(() {
              isLoading = false;
            });
          }
        }
      } else {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse.toString().isNotEmpty) {
          final snackBar = SnackBar(
            content: Text(jsonResponse['message']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', '')),
            duration: Duration(seconds: 4),
          );
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          12)),
                  backgroundColor: Colors.white,
                  title: Text(
                    "This store is not found",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily:
                        'OpenSans-Semibold',
                        color: Mycolors.dark),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop();
                        Navigator.of(context)
                            .pop();
                      },
                      child: Text(
                        "Go Back",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily:
                            'OpenSans-Semibold',
                            color: Mycolors.red),
                      ),
                    ),
                  ],
                );
              });
          /*Scaffold.of(context).showSnackBar(snackBar);*/
          setState(() {
            isLoading = false;
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          /*Scaffold.of(context).showSnackBar(snackBar);*/
          setState(() {
            isLoading = false;
          });
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(
                          12)),
                  backgroundColor: Colors.white,
                  title: Text(
                    "This store is not found",
                    style: TextStyle(
                        fontSize: 16,
                        fontFamily:
                        'OpenSans-Semibold',
                        color: Mycolors.dark),
                  ),
                  actions: [
                    FlatButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pop();
                        Navigator.of(context)
                            .pop();
                      },
                      child: Text(
                        "Go Back",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily:
                            'OpenSans-Semibold',
                            color: Mycolors.red),
                      ),
                    ),
                  ],
                );
              });
        }
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      /*Scaffold.of(context).showSnackBar(snackBar);*/

    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      /*Scaffold.of(context).showSnackBar(snackBar);*/

    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      print('General Error: ${e}');
      /*Scaffold.of(context).showSnackBar(snackBar);*/

    }
  }

  Future<void> createDynamicLink(
      String title, String description, String imgUrl, String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
        uriPrefix: 'https://loadstore.page.link',
        link: Uri.parse('https://www.example.com/$id'),
        androidParameters: AndroidParameters(
          packageName: 'com.load.load',
        ),
        iosParameters: IosParameters(
          bundleId: 'com.load.load',
        ),
        dynamicLinkParametersOptions: DynamicLinkParametersOptions(
          shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
        ),
        socialMetaTagParameters: SocialMetaTagParameters(
          title: title,
          description: description,
          imageUrl: Uri.parse(imgUrl),
        ));
    final ShortDynamicLink shortDynamicLink = await parameters.buildShortLink();
    final Uri shortUrl = shortDynamicLink.shortUrl;
    setState(() {
      shareLink = shortUrl.toString();
    });
  }

  shareCode(String store, String link, BuildContext context) async {
    final RenderBox box = context.findRenderObject();
    await Share.share('Visit $store\'s \n$shareLink ',
        subject: 'Share Link with Friends',
        sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
  }
}
