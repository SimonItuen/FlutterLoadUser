import 'dart:async';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/session_manager_util.dart';
import 'package:load/model/user_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Resturant_detail_screen/Resturant_detail.dart';
import 'package:load/screens/sign_screen/sign.dart';
import 'package:provider/provider.dart';

class Splashscreen extends StatefulWidget {
  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  String storeId = '-1';

  Future<void> initDynamicLinks() async {
    await Future.delayed(Duration(seconds: 3));
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;

      if (deepLink != null) {
        storeId = deepLink.path.replaceAll('/', '');

        Provider.of<UserAccountProvider>(context, listen: false)
            .setStoreId(storeId);
        Provider.of<UserAccountProvider>(context, listen: false)
            .setOpenRestaurant(true);
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      storeId = deepLink.path.replaceAll('/', '');

        Provider.of<UserAccountProvider>(context, listen: false)
            .setStoreId(storeId);
        Provider.of<UserAccountProvider>(context, listen: false)
            .setOpenRestaurant(true);
    }
  }

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    initDynamicLinks();
    Future.delayed(Duration.zero, () async {
      checkLogin();
    });
  }

  /*initDynamicLinks(BuildContext context) async {
    await Future.delayed(Duration(seconds: 3));
    var data = await FirebaseDynamicLinks.instance.getInitialLink();
    var deepLink = data?.link;
    if (false) {
      final queryParams = deepLink.queryParameters;
      if (queryParams.length > 0) {
        var userName = queryParams['userId'];
      }
    }
    FirebaseDynamicLinks.instance.onLink(onSuccess: (dynamicLink) async {
      var deepLink = dynamicLink?.link;
      await Navigator.pushNamed(context, Resturantdetails.routeName);
      debugPrint('DynamicLinks onLink $deepLink');
    }, onError: (e) async {
      debugPrint('DynamicLinks onError $e');
    });
  }*/

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  checkLogin() async {
    await SessionManagerUtil.getInstance();

    if (SessionManagerUtil.getString('apiToken') == null ||
        SessionManagerUtil.getString('apiToken').trim().isEmpty) {
      Navigator.of(context).pushReplacementNamed(Signscreen.routeName);
      print('null');

    } else {
      print('yes');
      UserModel model = UserModel(
        apiToken: SessionManagerUtil.getString('apiToken'),
        email: SessionManagerUtil.getString('email'),
        status: SessionManagerUtil.getString('status'),
        id: SessionManagerUtil.getInt('id'),
        name: SessionManagerUtil.getString('name'),
        role: SessionManagerUtil.getString('role'),
        phone: SessionManagerUtil.getString('phone'),
        profileImg: SessionManagerUtil.getString('profilePhoto'),
      );
      if (!(SessionManagerUtil.getString('points') == null) &&
          (SessionManagerUtil.getString('points').trim().isNotEmpty)) {
        model.points = SessionManagerUtil.getString('points');
      }
      Provider.of<UserAccountProvider>(context, listen: false)
          .setUserDetails(model);
      if (!(SessionManagerUtil.getString('getHelp') == null) &&
          (SessionManagerUtil.getString('getHelp').trim().isNotEmpty)) {
        String helpLine = SessionManagerUtil.getString('getHelp');
        Provider.of<UserAccountProvider>(context, listen: false)
            .setHelpLine(helpLine);
      }
      /*if (storeId != '-1') {
        Provider.of<UserAccountProvider>(context, listen: false)
            .setStoreId(storeId);
        Navigator.pushNamed(context, Resturantdetails.routeName);
      } else {*/
        Navigator.of(context).pushReplacementNamed(Homescreen.routeName);

    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
      ),
    );
  }
}
