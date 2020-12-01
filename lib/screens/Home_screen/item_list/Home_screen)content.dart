import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/helper/session_manager_util.dart';
import 'package:load/model/card_model.dart';
import 'package:load/model/trending_model.dart';
import 'package:load/model/user_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Home_screen/item_list/list.dart';
import 'package:load/screens/MyRewards/check_rewards.dart';
import 'package:load/screens/MyRewards/myrewards.dart';
import 'package:load/screens/Resturant_detail_screen/Resturant_detail.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:load/widgets/card_tile.dart';
import 'package:load/widgets/trending_tile.dart';
import 'package:provider/provider.dart';
import 'package:load/screens/Trending_List_screen/trending_list.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Homecontent extends StatefulWidget {
  @override
  _HomecontentState createState() => _HomecontentState();
}

class _HomecontentState extends State<Homecontent> {
  ScrollController controller = ScrollController();
  ScrollController categorycontroller = ScrollController();
  bool closetopcontainer = false;
  var visability = false;
  double change;
  double topcontainer = 0;
  BuildContext _context;
  List<TrendingModel> trendList = List<TrendingModel>();
  bool isTrendLoading = true;
  List<CardModel> cardList = List<CardModel>();
  bool isCardLoading = false;
  bool reachEnd = false;
  double containerHeight;
  double ratio = 1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      loadGetHelp();
      getPoints();
      getProfile();
      fetchTrending();
      fetchCards();
    });
    controller.addListener(() {
      double value = controller.offset /
          ((MediaQuery.of(context).size.width * 0.96667 * 0.49840 * 0.7));
      /*  print('This is the ${controller.offset}');
      print('This is the max ${controller.position.minScrollExtent}');*/
      setState(() {
        topcontainer = value;
        /*print(controller.position.viewportDimension);*/
        if (!controller.position.outOfRange) {
          if (controller.position.pixels / controller.position.maxScrollExtent >
                  0 &&
              controller.position.pixels / controller.position.maxScrollExtent <
                  1) {
            containerHeight = (controller.position.pixels /
                    controller.position.maxScrollExtent) *
                MediaQuery.of(context).size.width *
                0.82222 *
                0.672298;
            ratio = controller.position.pixels /
                controller.position.maxScrollExtent;



            /*closetopcontainer = controller.offset > 10;*/
          }
        } else {

          if (controller.position.pixels < 0) {
            containerHeight =
                MediaQuery.of(context).size.width * 0.82222 * 0.672298;
            ratio = 1;
          }
        }
        closetopcontainer = containerHeight <
            MediaQuery.of(context).size.width * 0.82222 * 0.672298;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: true);
    isTrendLoading =_accountProvider.getTrendingList.isEmpty;
    trendList=_accountProvider.getTrendingList;
    isCardLoading =_accountProvider.getCardList.isEmpty;
    cardList=_accountProvider.getCardList;

    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        _context = context;
        containerHeight ??= width * 0.82222 * 0.672298;
        if (ratio < 0) {
          ratio = 0;
        } else if (ratio > 1) {
          ratio = 1;
        }
        return Container(
          child: Stack(
            alignment: AlignmentDirectional.topEnd,
            children: <Widget>[
              BackdropBg(),
              RefreshIndicator(
                onRefresh: refresh,
                child: Stack(
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: [
                          Container(
                            color: Colors.transparent,
                            child: Padding(
                                padding: EdgeInsets.only(top: 20, bottom: 20),
                                child: Card(
                                  elevation: 8,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Container(
                                    // color: Colors.black,
                                    width: width * 0.91111,
                                    height: width * 0.91111 * 0.53963,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image: AssetImage('assets/card1.png'),
                                          fit: BoxFit.cover),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding:
                                          EdgeInsets.only(left: 20, top: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Image.asset(
                                                      'assets/logo1.png',
                                                      height: 35,
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: Mycolors.red,
                                                        ),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(1.0),
                                                          child: CircleAvatar(
                                                            backgroundColor:
                                                                Colors.grey,
                                                            radius: width *
                                                                0.91111 *
                                                                0.53963 *
                                                                0.31638 *
                                                                0.5,
                                                            backgroundImage:
                                                                NetworkImage(
                                                                    _accountProvider
                                                                        .getProfileUrl),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Text(
                                                      _accountProvider
                                                          .getFullName
                                                          .toString()
                                                          .toUpperCase(),
                                                      softWrap: false,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'OpenSans-Bold',
                                                          color: Mycolors.dark),
                                                    ),
                                                    Text(
                                                      _accountProvider.getPhone,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontFamily:
                                                              'BAHNSCHRIFT-regular',
                                                          color: Mycolors.dark),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40),
                                                    child: Text(
                                                      _accountProvider
                                                          .getPoints,
                                                      style: TextStyle(
                                                          fontSize: 28,
                                                          fontFamily:
                                                              'BAHNSCHRIFT-regular',
                                                          color:
                                                              Mycolors.dark2),
                                                    ),
                                                  ),
                                                  //SizedBox(height: height/300,),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 40,
                                                        bottom: width *
                                                            0.91111 *
                                                            0.53963 *
                                                            0.2523),
                                                    child: Text(
                                                      _accountProvider
                                                                  .getPoints ==
                                                              '1'
                                                          ? 'Point'
                                                          : 'Points',
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'OpenSans-Regular',
                                                          color:
                                                              Mycolors.dark2),
                                                    ),
                                                  ),

                                                  InkWell(
                                                    onTap: () {
                                                      Provider.of<UserAccountProvider>(
                                                              context,
                                                              listen: false)
                                                          .setLoadClick(true);
                                                      Provider.of<UserAccountProvider>(
                                                              context,
                                                              listen: false)
                                                          .setMyRewardClicked(
                                                              false);
                                                      // Myreward();
                                                    },
                                                    child: Container(
                                                      padding:
                                                          EdgeInsets.all(6),
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius.only(
                                                            topLeft:
                                                                Radius.circular(
                                                                    20),
                                                            bottomLeft:
                                                                Radius.circular(
                                                                    20),
                                                          ),
                                                          color: Colors.black
                                                              .withOpacity(
                                                                  0.5)),
                                                      child: Center(
                                                        child: Text(
                                                          "Check Rewards",
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              fontFamily:
                                                                  'OpenSans-Bold',
                                                              color: Mycolors
                                                                  .white),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            child: AnimatedOpacity(
                              duration: Duration(milliseconds: 00),
                              opacity: closetopcontainer ? 0 : 1,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Trending",
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: 'OpenSans-Bold',
                                        color: Mycolors.dark),
                                  ),
                                  Expanded(child: SizedBox()),
                                  InkWell(
                                    onTap: () async {
                                      await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TrendingListscreen()));
                                      refresh();
                                    },
                                    child: Text(
                                      "View All",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: 'OpenSans-Semibold',
                                          color: Mycolors.red),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          /*SizedBox(
                            height: closetopcontainer ? 0 : height / 150,
                          ),*/
                          AnimatedOpacity(
                            duration: Duration(milliseconds: 200),
                            opacity: closetopcontainer ? 0 : 1,
                            child: AnimatedContainer(
                              duration: Duration(milliseconds: 200),
                              width: width,
                              alignment: Alignment.topCenter,
                              height: closetopcontainer
                                  ? 0
                                  : width * 0.82222 * 0.672298,
                              child: isTrendLoading
                                  ? Center(
                                      child: CircularProgressIndicator(
                                        valueColor: _accountProvider.openRestaurant? new AlwaysStoppedAnimation<Color>(Colors.transparent) : new AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
                                      ),
                                    )
                                  : trendList.isEmpty
                                      ? Center(
                                          child: Text(
                                          "No Trends yet",
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontFamily: 'OpenSans-Regular',
                                              color: Mycolors.dark),
                                        ))
                                      : ListView.separated(
                                          padding: EdgeInsets.only(
                                              left: 16, right: 16),
                                          separatorBuilder: (context, index) {
                                            return SizedBox(
                                              width: 10,
                                            );
                                          },
                                          itemCount: trendList.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder:
                                              (BuildContext context, int i) {
                                            return TrendingTile(
                                              onPressed: () async {
                                                Provider.of<UserAccountProvider>(
                                                        context,
                                                        listen: false)
                                                    .setStoreId(
                                                        trendList[i].id);
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            Resturantdetails()));
                                                refresh();
                                              },
                                              name: trendList[i].storeName,
                                              coverUrl:
                                                  trendList[i].storeCoverUrl,
                                              categoryName:
                                                  trendList[i].categoryName,
                                              logoUrl:
                                                  trendList[i].storeLogoUrl,
                                            );
                                          }),
                            ),
                          ),
                          Expanded(
                            child: cardList.isEmpty
                                    ? Center(
                                        child: Text(
                                        "No Rewards yet",
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'OpenSans-Regular',
                                            color: isTrendLoading? Colors.transparent:Mycolors.dark),
                                      ))
                                    : NotificationListener<ScrollNotification>(
                                        onNotification: (scrollNotification) {
                                          if (scrollNotification
                                              is ScrollStartNotification) {
                                            /*setState(() {
                                              closetopcontainer=true;
                                            });*/
                                            /* print('starting');*/
                                          } else if (scrollNotification
                                              is ScrollUpdateNotification) {
                                            setState(() {
                                              /*if(reachEnd){
                                                  closetopcontainer = false;
                                                }else{
                                                  closetopcontainer = true;
                                                }*/
                                            });
                                          } else if (scrollNotification
                                              is ScrollEndNotification) {
                                            /* print('ending');
                                           setState(() {
                                             closetopcontainer=false;
                                             reachEnd=true;
                                           });*/

                                          }
                                          return true;
                                        },
                                        child: ListView.builder(
                                            padding: EdgeInsets.only(
                                                bottom: 20, top: 20),
                                            controller: controller,
                                            physics: BouncingScrollPhysics(),
                                            itemCount: cardList.length,
                                            itemBuilder:
                                                (BuildContext context, int i) {
                                              double scale = 1.0;
                                              if (topcontainer > 1) {
                                                scale = i + 1 - topcontainer;

                                                if (scale < 0) {
                                                  scale = 0;
                                                } else if (scale > 1) {
                                                  scale = 1;
                                                }
                                                /*print('scale $scale');*/
                                              }

                                              if (i == 0 && closetopcontainer) {
                                                scale = i + 1.12 - topcontainer;
                                                if (scale < 0) {
                                                  scale = 0;
                                                } else if (scale > 1) {
                                                  scale = 1;
                                                }
                                                return CardTile(
                                                  bgColor: cardList[i].storeCardBgColor,
                                                  fontColor: cardList[i].storeFontColor,
                                                  scale: scale,
                                                  logoUrl:
                                                      cardList[i].storeLogoUrl,
                                                  coverUrl:
                                                      cardList[i].cardImageUrl,
                                                  points: cardList[i].points,
                                                  name: cardList[i].storeName,
                                                  isLastCard: i ==
                                                      cardList.length -
                                                          1 /*cardList.length==1*/,
                                                  onPressed: () async {
                                                    Provider.of<UserAccountProvider>(
                                                            context,
                                                            listen: false)
                                                        .setStoreId(cardList[i]
                                                            .storeId);
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Resturantdetails()));
                                                    refresh();
                                                  },
                                                );
                                              } else {
                                                return CardTile(
                                                  bgColor: cardList[i].storeCardBgColor,
                                                  fontColor: cardList[i].storeFontColor,
                                                  scale: scale,
                                                  logoUrl:
                                                      cardList[i].storeLogoUrl,
                                                  coverUrl:
                                                      cardList[i].cardImageUrl,
                                                  points: cardList[i].points,
                                                  name: cardList[i].storeName,
                                                  isLastCard:
                                                      i == cardList.length - 1,
                                                  onPressed: () async {
                                                    Provider.of<UserAccountProvider>(
                                                            context,
                                                            listen: false)
                                                        .setStoreId(cardList[i]
                                                            .storeId);
                                                    await Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                Resturantdetails()));
                                                    refresh();
                                                  },
                                                );
                                              }
                                            }),
                                      ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  getProfile() async {
    BuildContext context = _context;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/get-profile';

    var map = convert.jsonEncode(
        <String, String>{'api_token': _accountProvider.getAccessToken});

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
          UserModel model = UserModel.fromJson(map);
          model.points = _accountProvider.getPoints;
          _accountProvider.setUserDetails(model);
          SessionManagerUtil.putString('apiToken', '${model.apiToken}');
          SessionManagerUtil.putString('status', '${model.status}');
          SessionManagerUtil.putInt('id', model.id);
          SessionManagerUtil.putString('name', '${model.name}');
          SessionManagerUtil.putString('email', '${model.email}');
          SessionManagerUtil.putString('role', '${model.role}');
          SessionManagerUtil.putString('phone', '${model.phone}');
          SessionManagerUtil.putString('profilePhoto', '${model.profileImg}');
          /*getPoints();*/
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
          /*Scaffold.of(context).showSnackBar(snackBar);*/

        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          /*Scaffold.of(context).showSnackBar(snackBar);*/
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
      /*Scaffold.of(context).showSnackBar(snackBar);*/

    }
  }

  getPoints() async {
    BuildContext context = _context;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/my-store-load-point';
    var map = convert.jsonEncode(
        <String, String>{'api_token': _accountProvider.getAccessToken});

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
          _accountProvider
              .appendUserDetails(jsonResponse['data'].toString());
          SessionManagerUtil.putString(
              'points', '${jsonResponse['data']}');
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
          /*Scaffold.of(context).showSnackBar(snackBar);*/

        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          /*Scaffold.of(context).showSnackBar(snackBar);*/
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
      /*Scaffold.of(context).showSnackBar(snackBar);*/

    }
  }

  fetchTrending() async {
    BuildContext context = _context;
    setState(() {
      closetopcontainer = false;
    });
    String url = BaseUrl.baseUrl + '/trending-store';

    try {
      http.Response response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        },
      );


      if (response.statusCode == 200) {

        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {
          Iterable iterable = jsonResponse['data'];

          trendList =
              await iterable.map((en) => TrendingModel.fromJson(en)).toList();
          UserAccountProvider _accountProvider =
          Provider.of<UserAccountProvider>(context, listen: false);
          _accountProvider.setTrendsList(trendList);

          setState(() {
            isTrendLoading = false;
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
            Scaffold.of(context).showSnackBar(snackBar);
            setState(() {
              isTrendLoading = false;
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
          Scaffold.of(context).showSnackBar(snackBar);
          setState(() {
            isTrendLoading = false;
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
        setState(() {
          isTrendLoading = false;
        });
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isTrendLoading = false;
      });
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isTrendLoading = false;
      });
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isTrendLoading = false;
      });
    }
  }

  fetchCards() async {
    BuildContext context = _context;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);
    String url = BaseUrl.baseUrl + '/show-cards';

    var map = convert.jsonEncode(
        <String, String>{'api_token': _accountProvider.getAccessToken});

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
          Iterable iterable = jsonResponse['data'];

          cardList =
              await iterable.map((en) => CardModel.fromJson(en)).toList();
          _accountProvider.setCardsList(cardList);
          /*cardList.clear();
          for (Category category in Category.popularCategoryList) {
            cardList.add(CardModel(
                storeName: category.title,
                storeLogoUrl: 's',
                storeCoverUrl: category.imagePath,
                points: category.secondry_title));
          }*/

          setState(() {
            isCardLoading = false;
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
            Scaffold.of(context).showSnackBar(snackBar);
            setState(() {
              isCardLoading = false;
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
          Scaffold.of(context).showSnackBar(snackBar);
          setState(() {
            isCardLoading = false;
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
        setState(() {
          isCardLoading = false;
        });
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isCardLoading = false;
      });
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isCardLoading = false;
      });
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isCardLoading = false;
      });
    }
  }

  Future<void> refresh() async {
    loadGetHelp();
    getProfile();
    fetchTrending();
    fetchCards();
  }

  loadGetHelp() async {
    String url = BaseUrl.baseUrl + '/get-help';

    try {
      http.Response response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        },
      );


      if (response.statusCode == 200) {

        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {
          String getHelp = jsonResponse['data']['phone_number'].toString();
          UserAccountProvider _accountProvider =
              Provider.of<UserAccountProvider>(context, listen: false);
          _accountProvider.setHelpLine(getHelp);
          SessionManagerUtil.putString('getHelp', getHelp);


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
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
        }
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
    }
  }
}
