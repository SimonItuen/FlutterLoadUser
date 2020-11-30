import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/model/load_reward_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/MyRewards/points.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'rewardRedeemed.dart';
import 'package:load/widgets/load_reward_item_tile.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class RedeemRewardsdetails extends StatefulWidget {
  final String title;
  final String imgUrl;
  final String id;

  RedeemRewardsdetails({this.title, this.imgUrl, this.id});

  @override
  _RedeemRewardsdetailsState createState() => _RedeemRewardsdetailsState();
}

class _RedeemRewardsdetailsState extends State<RedeemRewardsdetails> {
  PageController controller =
      PageController(initialPage: 0, viewportFraction: 0.88);
  int _currentPage = 0;
  bool isLoading = false;
  BuildContext _context;

  _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                            child: PageView.builder(
                                controller: controller,
                                itemCount: 1,
                                itemBuilder: (ctx, i) {
                                  return LoadRewardItemTile(
                                    coverUrl: widget.imgUrl.toString(),
                                  );
                                })),
                        Container(
                          padding: EdgeInsets.all(16),
                          child: SizedBox(
                            height: 4,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: Container(
                            width: width,
                            margin: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Mycolors.red_dark),
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                onPressed: () async {

                                  await getReward(widget.id.toString());

                                  //Navigator.pop(context);
                                },
                                color: _accountProvider
                                        .getLoadRewardItemsList.isNotEmpty
                                    ? Mycolors.red_dark
                                    : Mycolors.red_light,
                                child: Center(
                                  child: Text(
                                    "Redeem",
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
    print(url);
    var map = convert.jsonEncode(<String, String>{
      'api_token': _accountProvider.getAccessToken,
      'reward_id': rewardId
    });
    print(map);
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          },
          body: map);

      print(response.body);
      if (response.statusCode == 200) {
        print('eien');
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {
          fetchLoadRewards();
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
          /*await Scaffold.of(context).showSnackBar(snackBar).closed;*/
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              opaque: false, // set to false
              pageBuilder: (_, __, ___) => RewardRedeemed(pointDetail: widget.title, message: 'You have successfully redeemed', type: 'REWARD',),
            ),
          );
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

  Future<void> fetchLoadRewards() async {
    BuildContext context = _context;
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: false);
    String url = BaseUrl.baseUrl + '/load-rewards';
    print(url);
    var map = convert.jsonEncode(
        <String, String>{'api_token': _accountProvider.getAccessToken});
    print(map);
    try {
      http.Response response = await http.post(url,
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          },
          body: map);

      print(response.body);
      if (response.statusCode == 200) {
        print('eien');
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {
          Iterable iterable = jsonResponse['data'];

         List<LoadRewardModel> list =
          await iterable.map((en) => LoadRewardModel.fromJson(en)).toList();
          _accountProvider.setLoadRewards(list);
          print(jsonResponse);

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
            ;
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
          ;
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
        ;
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      ;
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      ;
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      ;
    }
  }
}
