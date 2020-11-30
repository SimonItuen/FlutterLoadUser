import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:load/helper/colors.dart';
import 'package:load/model/card_model.dart';
import 'package:load/model/load_reward_model.dart';
import 'package:load/model/trending_model.dart';
import 'package:load/screens/Get_Help/GetHelp.dart';
import 'package:load/screens/Home_screen/item_list/Home_screen)content.dart';
import 'package:load/screens/Home_screen/item_list/list.dart';
import 'package:load/screens/Load_rewards/loadReward.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/MyAccount_screen/myaccount.dart';
import 'package:load/screens/MyRewards/myrewards.dart';
import 'package:load/screens/Privacy_policy/PrivacyPolicy.dart';
import 'package:load/screens/Qrscan_screen/qrscan.dart';
import 'package:load/screens/Resturant_detail_screen/Resturant_detail.dart';
import 'package:load/screens/Search_screen/search.dart';
import 'package:load/screens/Term_of_use/Termofuse.dart';
import 'package:load/screens/Verification2_screen/Verification2.dart';
import 'package:load/screens/our_partners/partners.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:load/helper/base_url.dart';
import 'dart:async';
import 'dart:io';
import 'package:load/model/user_model.dart';
import 'package:load/helper/session_manager_util.dart';
import 'package:http/http.dart' as http;
import 'package:load/screens/sign_screen/sign.dart';
import 'package:url_launcher/url_launcher.dart';

class Homescreen extends StatefulWidget {
  static String routeName = '/home-screen';

  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String title = "";
  int _currentIndex = 0;
  var visable = false;
  var visable1 = false;
  var safe;
  bool isLoading = false;
  var search = false;
  var show_search = false;
  final List<Widget> _children = [
    Homecontent(),
    Loadreward(),
    Myreward(),
    Homecontent(),
    Termofuse(),
    Partners(),
    PrivacyPolicy(),
    GetHelp()
  ];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    print(index);
  }

  Future<void> initDynamicLinks() async {
    if (Provider.of<UserAccountProvider>(context, listen: false)
        .getOpenRestaurant) {
      print(
          'This na ${Provider.of<UserAccountProvider>(context, listen: false).getStoreId.toString()}');
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 3), () {
        print('Na mi');
        setState(() {
          isLoading = false;
        });
        Provider.of<UserAccountProvider>(context, listen: false)
            .setHomeLoading(false);
        Navigator.pushNamed(context, Resturantdetails.routeName);
        Provider.of<UserAccountProvider>(context, listen: false)
            .setOpenRestaurant(false);
      });
    }
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) {
        print('This $deepLink');
        Provider.of<UserAccountProvider>(context, listen: false)
            .setStoreId(deepLink.path.replaceAll('/', ''));
        if (!Provider.of<UserAccountProvider>(context, listen: false)
            .getOpenRestaurant) {
          Navigator.pushNamed(context, Resturantdetails.routeName);

          Provider.of<UserAccountProvider>(context, listen: false)
              .setOpenRestaurant(false);
          Provider.of<UserAccountProvider>(context, listen: false)
              .setFirstOpened(false);
        }
        setState(() {
          isLoading = false;
        });
        print('Yesaiaiana');
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink);
      Provider.of<UserAccountProvider>(context, listen: false)
          .setStoreId(deepLink.path.replaceAll('/', ''));
      if (!Provider.of<UserAccountProvider>(context, listen: false)
          .getOpenRestaurant) {
        setState(() {
          isLoading = true;
        });
        Provider.of<UserAccountProvider>(context, listen: false)
            .setFirstOpened(false);
        Provider.of<UserAccountProvider>(context, listen: false)
            .setOpenRestaurant(false);
        Navigator.pushNamed(context, Resturantdetails.routeName);
      }
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    initDynamicLinks();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    setState(() {
      home = true;
      load = false;
      my = false;
      help = false;
      terms = false;
      privacy = false;
      partners = false;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    Provider.of<UserAccountProvider>(context, listen: false)
        .setLoadClick(false);
    Provider.of<UserAccountProvider>(context, listen: false)
        .setMyRewardClicked(false);
    if (_currentIndex != 0) {
      setState(() {
        home = true;
        load = false;
        my = false;
        help = false;
        terms = false;
        privacy = false;
        partners = false;
        visable = false;
        visable1 = false;
        search = false;
        show_search = false;
        title = "";
        _currentIndex = 0;
      });
      return false;
    } else if (Provider.of<UserAccountProvider>(context, listen: true)
        .getStillStayInPartnerClicked) {
      /*print('This is ${Provider.of<UserAccountProvider>(context, listen: true).getStillStayInPartnerClicked}');*/
      return false;
    } else {
      return true; // n true if the route to be popped
    }
  }

  @override
  Widget build(BuildContext context) {
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: true);
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    if (_accountProvider.getLoadClicked) {
      if (_currentIndex != 1) {
        setState(() {
          home = false;
          load = true;
          my = false;
          help = false;
          terms = false;
          privacy = false;
          partners = false;
          visable = true;
          visable1 = true;
          search = false;
          show_search = false;

          title = "Load Rewards";
          _currentIndex = 1;
        });
      }
    }
    if (_accountProvider.getMyRewardClicked) {
      if (_currentIndex != 2) {
        setState(() {
          home = false;
          load = false;
          my = true;
          help = false;
          terms = false;
          privacy = false;
          partners = false;
          visable = true;
          visable1 = false;
          search = true;
          show_search = false;

          title = "My Rewards";
          _currentIndex = 2;
        });
      }
    }

    return WillPopScope(
      onWillPop: _accountProvider.getStillStayInPartnerClicked
          ? null
          : _willPopCallback,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Mycolors.red,
            elevation: 0,
            leading: InkWell(
                onTap: _currentIndex == 5 &&
                        _accountProvider.getStillStayInPartnerClicked
                    ? () {
                        /* Provider.of<UserAccountProvider>(context, listen: false)
                            .setStillStayInPartnerClick(false);*/
                        Provider.of<UserAccountProvider>(context, listen: false)
                            .setPartner('Our Partners');
                      }
                    : () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                child: _currentIndex == 5 &&
                        _accountProvider.getStillStayInPartnerClicked
                    ? BackButton(
                        color: Colors.white,
                      )
                    : IconButton(
                        icon: Image.asset(
                        'assets/menu.png',
                        height: 18,
                        width: 18,
                      ))),
            title: Center(
              child: Text(
                _currentIndex == 5
                    ? _accountProvider.getPartner.toString()
                    : title,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'OpenSans-Semibold',
                    color: Colors.white),
              ),
            ),
            actions: <Widget>[
              visable1
                  ? IconButton(
                      icon: Image.asset('assets/qrcode.png'),
                      onPressed: () {
                        Navigator.of(context).push(TransparentRoute(
                            builder: (BuildContext context) => Qrscan()));
                        //Navigator.push(context, MaterialPageRoute(builder: (context)=>Searchscreen()));
                      })
                  : IconButton(
                      icon: Icon(
                        Icons.search,
                        color: !show_search ? Colors.white : Mycolors.red,
                        size: search ? 23 : 23,
                      ),
                      onPressed: !show_search
                          ? () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Searchscreen()));
                            }
                          : null)
            ],
          ),
          key: _scaffoldKey,
          drawer: _currentIndex == 5 &&
                  _accountProvider.getStillStayInPartnerClicked
              ? null
              : MyDrawer(
                  onTap: (ctx, i) {
                    setState(() {
                      _currentIndex = i;
                      if (_currentIndex == 0) {
                        setState(() {
                          // print(width);
                          visable = false;
                          visable1 = false;
                          search = false;
                          show_search = false;
                          title = "";
                        });
                      }
                      if (_currentIndex == 1) {
                        setState(() {
                          visable = true;
                          visable1 = true;
                          search = false;
                          show_search = false;

                          title = "Load Rewards";
                        });
                      }
                      if (_currentIndex == 2) {
                        setState(() {
                          visable = true;
                          visable1 = false;
                          search = true;
                          show_search = false;

                          title = "My Rewards";
                        });
                      }
                      if (_currentIndex == 4) {
                        setState(() {
                          visable = true;
                          visable1 = false;
                          search = false;
                          show_search = false;

                          title = "Terms of Use";
                        });
                      }

                      if (_currentIndex == 5) {
                        setState(() {
                          visable = true;
                          visable1 = false;
                          search = false;
                          show_search = true;
                          title = _accountProvider.getPartner.toString();
                        });
                      }
                      if (_currentIndex == 6) {
                        setState(() {
                          visable = true;
                          visable1 = false;
                          search = false;
                          show_search = true;

                          title = "Privacy Policy";
                        });
                      }
                      Provider.of<UserAccountProvider>(context, listen: false)
                          .setStillStayInPartnerClick(false);
                      Provider.of<UserAccountProvider>(context, listen: false)
                          .setLoadClick(false);
                      Provider.of<UserAccountProvider>(context, listen: false)
                          .setMyRewardClicked(false);
                      Navigator.pop(ctx);
                    });
                  },
                ),
          floatingActionButton: Visibility(
            visible: !visable,
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context).push(TransparentRoute(
                    builder: (BuildContext context) => Qrscan()));
              },
              backgroundColor: Mycolors.red,
              child: Image.asset('assets/qrcode.png'),
              elevation: 8,
            ),
          ),
          body: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              AbsorbPointer(
                absorbing: isLoading,
                child: Container(
                    width: width,
                    height: height,
                    color: Colors.white,
                    child: Stack(children: [
                      Container(
                        width: width,
                        height: height,
                        // padding: EdgeInsets.symmetric(horizontal: 16),
                        child: SingleChildScrollView(
                          physics: NeverScrollableScrollPhysics(),
                          child: Column(
                            children: [
                              Container(
                                width: width,
                                height: height,
                                child: _children[_currentIndex],
                              )
                            ],
                          ),
                        ),
                      ),
                    ])),
              ),
              Visibility(
                visible: isLoading,
                child: Container(
                    color: Color(0x99000000),
                    child: Center(
                      child: CircularProgressIndicator(),
                    )),
              )
            ],
          )),
    );
  }
}

class MyDrawer extends StatefulWidget {
  final Function onTap;

  const MyDrawer({Key key, this.onTap}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

bool home = true;
bool load = false;
bool my = false;
bool help = false;
bool terms = false;
bool privacy = false;
bool partners = false;

class _MyDrawerState extends State<MyDrawer> {
  bool helpLoading = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Mycolors.white
          .withOpacity(0.02), //or set color with: Color(0xFF0000FF)
    ));
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: true);
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Container(
          // padding: EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //SizedBox(height: height/40,),

              Container(
                width: width,
                height: height / 5,
                color: Mycolors.white.withOpacity(0.02),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height / 15,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18, right: 20),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Myaccountscreen()));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Mycolors.red,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(1.0),
                                  child: CircleAvatar(
                                    backgroundColor: Colors.grey,
                                    radius: width / 5 * 0.5,
                                    backgroundImage: NetworkImage(
                                        _accountProvider.getProfileUrl),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        _accountProvider.getFullName,
                                        softWrap: false,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: 'OpenSans-Semibold',
                                            color: Mycolors.dark),
                                      ),
                                      Text(
                                        _accountProvider.getPhone,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: 'BAHNSCHRIFT-regular',
                                            color: Mycolors.dark),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 15),
                                child: Icon(
                                  Icons.arrow_forward,
                                  color: Mycolors.dark4,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 40,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    home = true;
                    load = false;
                    my = false;
                    help = false;
                    terms = false;
                    privacy = false;
                    partners = false;
                  });
                  widget.onTap(context, 0);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          home ? Mycolors.red.withOpacity(0.02) : Colors.white),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height / 15,
                        width: 5,
                        color: home ? Mycolors.red : Colors.white,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      //  Image.asset('assets/profile1.png',height: 22,),
                      // SizedBox(width: width/15,),
                      Text(
                        "Home",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'OpenSans-Semibold',
                            color: Mycolors.dark),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 150,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    home = false;
                    load = true;
                    my = false;
                    help = false;
                    terms = false;
                    privacy = false;
                    partners = false;
                  });
                  widget.onTap(context, 1);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          load ? Mycolors.red.withOpacity(0.02) : Colors.white),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height / 15,
                        width: 5,
                        color: load ? Mycolors.red : Colors.white,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      //  Image.asset('assets/profile1.png',height: 22,),
                      // SizedBox(width: width/15,),
                      Row(
                        children: [
                          Text(
                            "Load Rewards",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'OpenSans-Semibold',
                                color: Mycolors.dark),
                          ),
                          SizedBox(
                            width: width / 10,
                          ),
                          Container(
                            padding: EdgeInsets.all(4),
                            decoration:
                                _accountProvider.getPoints.trim().length == 1
                                    ? BoxDecoration(
                                        color: Mycolors.dark,
                                        shape: BoxShape.circle)
                                    : BoxDecoration(
                                        color: Mycolors.dark,
                                        borderRadius:
                                            BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Center(
                                child: Text(
                                  _accountProvider.getPoints,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'BAHNSCHRIFT-regular',
                                      color: Mycolors.yellow),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 150,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    home = false;
                    load = false;
                    my = true;
                    help = false;
                    terms = false;
                    privacy = false;
                    partners = false;
                  });
                  widget.onTap(context, 2);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          my ? Mycolors.red.withOpacity(0.02) : Colors.white),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height / 15,
                        width: 5,
                        color: my ? Mycolors.red : Colors.white,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      //  Image.asset('assets/profile1.png',height: 22,),
                      // SizedBox(width: width/15,),
                      Text(
                        "My Rewards",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'OpenSans-Semibold',
                            color: Mycolors.dark),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 150,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    home = false;
                    load = false;
                    my = false;
                    help = false;
                    terms = false;
                    privacy = false;
                    partners = true;
                  });
                  widget.onTap(context, 5);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: partners
                          ? Mycolors.red.withOpacity(0.02)
                          : Colors.white),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height / 15,
                        width: 5,
                        color: partners ? Mycolors.red : Colors.white,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      //  Image.asset('assets/profile1.png',height: 22,),
                      // SizedBox(width: width/15,),
                      Text(
                        "Our Partners",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'OpenSans-Semibold',
                            color: Mycolors.dark),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 150,
              ),
              InkWell(
                onTap: () async {
                  setState(() {});
                  await launchWhatsApp(
                      phone: _accountProvider.getHelpLine,
                      message: 'I Need Help');
                  print(_accountProvider.getHelpLine);
                  Navigator.of(context).pop();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color:
                          help ? Mycolors.red.withOpacity(0.02) : Colors.white),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height / 15,
                        width: 5,
                        color: help ? Mycolors.red : Colors.white,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      //  Image.asset('assets/profile1.png',height: 22,),
                      // SizedBox(width: width/15,),
                      Row(
                        children: <Widget>[
                          Text(
                            "Get Help",
                            style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'OpenSans-Semibold',
                                color: Mycolors.dark),
                          ),
                          helpLoading
                              ? SpinKitCircle(size: 20, color: Mycolors.red)
                              : Container()
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 150,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    home = false;
                    load = false;
                    my = false;
                    help = false;
                    terms = true;
                    privacy = false;
                    partners = false;
                  });
                  widget.onTap(context, 4);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: terms
                          ? Mycolors.red.withOpacity(0.02)
                          : Colors.white),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height / 15,
                        width: 5,
                        color: terms ? Mycolors.red : Colors.white,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      //  Image.asset('assets/profile1.png',height: 22,),
                      // SizedBox(width: width/15,),
                      Text(
                        "Terms of Use",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'OpenSans-Semibold',
                            color: Mycolors.dark),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 150,
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    home = false;
                    load = false;
                    my = false;
                    help = false;
                    terms = false;
                    privacy = true;
                    partners = false;
                  });
                  widget.onTap(context, 6);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: privacy
                          ? Mycolors.red.withOpacity(0.02)
                          : Colors.white),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height / 15,
                        width: 5,
                        color: privacy ? Mycolors.red : Colors.white,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      //  Image.asset('assets/profile1.png',height: 22,),
                      // SizedBox(width: width/15,),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'OpenSans-Semibold',
                            color: Mycolors.dark),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: height / 150,
              ),
              InkWell(
                onTap: () async {
                  await logout(context);
                  Provider.of<UserAccountProvider>(context, listen: false)
                      .setStoreId('-1');
                  Provider.of<UserAccountProvider>(context, listen: false)
                      .setTrendsList(List<TrendingModel>());
                  Provider.of<UserAccountProvider>(context, listen: false)
                      .setCardsList(List<CardModel>());
                  Provider.of<UserAccountProvider>(context, listen: false)
                      .setLoadRewardsHistory(List<LoadRewardModel>());
                  Provider.of<UserAccountProvider>(context, listen: false)
                      .setLoadRewards(List<LoadRewardModel>());
                  Provider.of<UserAccountProvider>(context, listen: false)
                      .setOpenRestaurant(false);
                  widget.onTap(context, 0);
                  Navigator.of(context).pushNamedAndRemoveUntil(
                      Signscreen.routeName, (Route<dynamic> route) => false);
                },
                child: Container(
                  decoration: BoxDecoration(color: Colors.white),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        height: height / 15,
                        width: 5,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: width / 20,
                      ),
                      //  Image.asset('assets/profile1.png',height: 22,),
                      // SizedBox(width: width/15,),
                      Text(
                        "Logout",
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'OpenSans-Semibold',
                            color: Mycolors.dark),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  logout(BuildContext context) async {
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/user-logout';
    print(url);
    try {
      http.Response response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "X-Requested-With": "XMLHttpRequest"
        },
      );

      print(response.body);
      if (response.statusCode == 200) {
        print('eien');
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {
          SessionManagerUtil.clearAll();
          print(jsonResponse['success'].toString());
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
            //Scaffold.of(context).showSnackBar(snackBar);

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
          //Scaffold.of(context).showSnackBar(snackBar);

        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          //Scaffold.of(context).showSnackBar(snackBar);
        }
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      //Scaffold.of(context).showSnackBar(snackBar);

    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      //Scaffold.of(context).showSnackBar(snackBar);

    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      //Scaffold.of(context).showSnackBar(snackBar);

    }
  }

  Future<void> launchWhatsApp({
    @required String phone,
    @required String message,
  }) async {
    setState(() {
      helpLoading = true;
    });
    String url() {
      if (Platform.isIOS) {
        return "whatsapp://wa.me/$phone/?text=${Uri.parse(message)}";
      } else {
        https: //wa.me/$phone?text=I'm%20interested%20in%20your%20car%20for%20sale
        return "https://wa.me/$phone?text=${Uri.parse(message)}";
      }
    }

    if (await canLaunch(url())) {
      await launch(url());
    } else {
      throw 'Could not launch ${url()}';
    }
    setState(() {
      helpLoading = false;
    });
  }
}

class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var curve = Curves.ease;

    var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
    return SlideTransition(
      position: animation.drive(tween),
      child: result,
    );
  }
}
