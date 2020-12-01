import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Load_rewards/Redeem_Rewards_details_page.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:load/widgets/load_reward_item_tile.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Rewardsdetails extends StatefulWidget {
  final String title;

  Rewardsdetails({this.title});

  @override
  _RewardsdetailsState createState() => _RewardsdetailsState();
}

class _RewardsdetailsState extends State<Rewardsdetails> {
  PageController controller ;
  int _currentPage = 0;
  bool isLoading = false;
  BuildContext _context;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }


  @override
  void initState() {
    super.initState();
    controller =
        PageController(initialPage: (Provider.of<UserAccountProvider>(context, listen: false).loadRewardItemsList.length/2).floor(), viewportFraction: 0.88);
    _currentPage = (Provider.of<UserAccountProvider>(context, listen: false).loadRewardItemsList.length/2).floor();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
        title: Text(
          widget.title.toString(),
          style: TextStyle(
              fontSize: 18,
              fontFamily: 'OpenSans-Semibold',
              color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Mycolors.red,
      ),
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        _context = context;
        return Container(
          width: width,
          height: height,
          color: Colors.white,
          child: Stack(
            alignment: AlignmentDirectional.topCenter,
            children: <Widget>[
              AbsorbPointer(
                absorbing: isLoading,
                child: Stack(
                  children: [
                    BackdropBg(),
                    Container(
                      width: width,
                      height: height / 50,
                      color: Mycolors.red,
                    ),
                    Column(
                      children: [
                        Expanded(
                          child:
                          _accountProvider.getLoadRewardItemsList.isNotEmpty
                              ? PageView.builder(
                              onPageChanged: _onPageChanged,
                              controller: controller,
                              itemCount: _accountProvider
                                  .getLoadRewardItemsList.length,
                              itemBuilder: (ctx, i) {
                                return LoadRewardItemTile(
                                  coverUrl: _accountProvider
                                      .getLoadRewardItemsList[i]
                                      .rewardImage
                                      .toString(),
                                );
                              })
                              : Center(
                            child: Text('Not available',
                                style: TextStyle(
                                    fontFamily: 'OpenSans-Semibold',
                                    color: Colors.black)),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: _accountProvider
                                  .getLoadRewardItemsList.isNotEmpty
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SmoothPageIndicator(
                                      controller: controller,
                                      count: _accountProvider
                                          .getLoadRewardItemsList.length,
                                      axisDirection: Axis.horizontal,
                                      effect: SlideEffect(
                                          spacing: 8.0,
                                          radius: 81.0,
                                          dotWidth: 16.0,
                                          dotHeight: 4.0,
                                          paintStyle: PaintingStyle.fill,
                                          strokeWidth: 1.5,
                                          dotColor:
                                              Mycolors.red.withOpacity(0.3),
                                          activeDotColor: Mycolors.red),
                                    )
                                  ],
                                )
                              : Container(),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Container(
                            width: width,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: _accountProvider
                                      .getLoadRewardItemsList.isNotEmpty
                                  ? Mycolors.red_dark
                                  : Mycolors.red_light,
                            ),
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: _accountProvider
                                        .getLoadRewardItemsList.isEmpty
                                    ? () {}
                                    : () {
                                        //Navigator.pop(context);
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
                                                  "Are you sure you want to select this reward?",
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
                                                    },
                                                    child: Text(
                                                      "NO",
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              'OpenSans-Semibold',
                                                          color: Mycolors.red),
                                                    ),
                                                  ),
                                                  FlatButton(
                                                    onPressed: () async {
                                                      Navigator.of(context).pop();
                                                      Navigator
                                                          .pushReplacement(
                                                              context,
                                                              FadedRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          RedeemRewardsdetails(
                                                                            title:
                                                                                widget.title,
                                                                            imgUrl:
                                                                                _accountProvider.getLoadRewardItemsList[_currentPage].rewardImage,
                                                                            id: _accountProvider.getLoadRewardItemsList[_currentPage].rewardId,
                                                                          )));
                                                    },
                                                    child: Text(
                                                      "YES",
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
                                      },
                                color: _accountProvider
                                        .getLoadRewardItemsList.isNotEmpty
                                    ? Mycolors.red_dark
                                    : Mycolors.red_light,
                                child: Center(
                                  child: Text(
                                    "Select Reward",
                                    style: Theme.of(context)
                                        .primaryTextTheme
                                        .headline3,
                                  ),
                                )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
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
          ),
        );
      }),
    );
  }

  getReward(String rewardId) async {
    setState(() {
      isLoading = true;
    });
    BuildContext context = _context;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/rewardCollectBannerwise';

    var map = convert.jsonEncode(<String, String>{
      'api_token': _accountProvider.getAccessToken,
      'reward_id': rewardId
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
          setState(() {
            isLoading = false;
          });
          final snackBar = SnackBar(
            content: Text(jsonResponse['message']
                .toString()
                .replaceAll('{', '')
                .replaceAll('}', '')
                .replaceAll('[', '')
                .replaceAll(']', '')),
            duration: Duration(seconds: 1),
          );
          await Scaffold.of(context).showSnackBar(snackBar).closed;
          Navigator.of(context).pop();
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
          Scaffold.of(context).showSnackBar(snackBar);
          setState(() {
            isLoading = false;
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          Scaffold.of(context).showSnackBar(snackBar);
          setState(() {
            isLoading = false;
          });
        }
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      print('General Error: ${e}');
      Scaffold.of(context).showSnackBar(snackBar);
    }
  }
}

class FadedRoute extends PageRoute<void> {
  FadedRoute({
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
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}