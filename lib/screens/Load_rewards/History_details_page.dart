import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:load/widgets/load_reward_item_tile.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class Historydetails extends StatefulWidget {
  final String title;

  Historydetails({this.title});

  @override
  _HistorydetailsState createState() => _HistorydetailsState();
}

class _HistorydetailsState extends State<Historydetails> {
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
                                  .getLoadRewardItemsList.isNotEmpty&&_accountProvider
                              .getLoadRewardItemsList.length>1
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

  /*getReward(String rewardId) async {
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
  }*/
}
