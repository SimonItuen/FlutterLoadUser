import 'package:flutter/material.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/helper/session_manager_util.dart';
import 'package:load/model/load_reward_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Load_rewards/history.dart';
import 'package:load/screens/Load_rewards/rewards.dart';
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/screens/verification3_screen/verification3.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class Loadreward extends StatefulWidget {
  @override
  _LoadrewardState createState() => _LoadrewardState();
}

class _LoadrewardState extends State<Loadreward> {
  PageController controller=PageController();
  var reward=false;
  var history=false;
  bool rewardLoading=false;
  bool historyLoading =false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      history=false;
      reward=true;
    });
    Future.delayed(Duration.zero, (){
      fetchLoadRewards();
      fetchLoadHistory();
      getPoints();
    });
  }
  @override
  Widget build(BuildContext context) {
    var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: true);
    return Container(
      width: width,
      height: height,
      color: Mycolors.red,
      child: Column(
        children: [
          SizedBox(height: height/50,),
          Expanded(
            child: Container(
             // padding: EdgeInsets.only(left: 16,right: 16,top: 20),
              width: width,
              //height: height,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topLeft: Radius.circular(24),topRight: Radius.circular(24)),
                color: Colors.white
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16,top: 20,bottom: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Current Points",
                                                    style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark4),),
                        Text(_accountProvider.getPoints.toString(),
                                                    style: TextStyle(fontSize: 18,fontFamily: 'BAHNSCHRIFT-regular',color: Mycolors.red),),
                      ],
                    ),
                    
                  ),
                  Container(
                    width: width,
                    height: 2,
                    color: Mycolors.white,
                  ),
                  SizedBox(height: height/200,),
                  Padding(
                    padding: const EdgeInsets.only(left: 16,right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: (){
                            controller.jumpToPage(0);
                            setState(() {
                              reward=true;
                              history=false;
                            });
                          },
                          child: Container(
                            width: width/2.2,
                            height: height/20,
                           // color: Colors.red,
                            child: Center(
                              child: Text("Rewards",
                                                            style: TextStyle(fontSize: 16,fontFamily:reward?'OpenSans-Semibold': 'OpenSans-Regular',color: Mycolors.dark),),
                            ),
                          ),
                        ),
                          InkWell(
                            onTap: (){
                            controller.jumpToPage(1);
                              setState(() {
                                history=true;
                                reward=false;
                              });
                            },
                            child: Container(
                              width: width/2.2,
                            height: height/20,
                              child: Center(
                                child: Text("History",
                                                            style: TextStyle(fontSize: 16,fontFamily:history?'OpenSans-Semibold': 'OpenSans-Regular',color: Mycolors.dark),),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                  SizedBox(height: height/150,),
                  Row(
                    children: [
                      Container(
                    width: width/2,
                    height: 2,
                    color:reward? Mycolors.indicator: Mycolors.white,
                  ),
                  Container(
                    width: width/2,
                    height: 2,
                    color:history? Mycolors.indicator: Mycolors.white,
                  ),
                    ],
                  ),

                  Expanded(
                    child: Container(
                      width: width,
                      //height: height/2,
                      color: Colors.white,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: PageView(
                        onPageChanged: (v){
                          setState(() {
                            if(v==0){
                              reward=true;
                              history=false;
                            }
                            if(v==1){
                              reward=false;
                              history=true;
                            }
                          });
                        },
                        //physics: NeverScrollableScrollPhysics(),
                        controller: controller,
                        children: [
                            Rewards(rewardLoading),
                            History(historyLoading)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  /*getPoints() async {
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/current-point';
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
          _accountProvider
              .appendUserDetails(jsonResponse['data']['current_points'].toString());
          SessionManagerUtil.putString(
              'points', '${jsonResponse['data']['current_points']}');
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
            *//*Scaffold.of(context).showSnackBar(snackBar);*//*

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
          *//*Scaffold.of(context).showSnackBar(snackBar);*//*

        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          *//*Scaffold.of(context).showSnackBar(snackBar);*//*
        }
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      *//*Scaffold.of(context).showSnackBar(snackBar);*//*

    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      *//*Scaffold.of(context).showSnackBar(snackBar);*//*

    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      *//*Scaffold.of(context).showSnackBar(snackBar);*//*

    }
  }*/

  getPoints() async {
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/my-store-load-point';
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

  Future<void> fetchLoadHistory() async {
    setState(() {
      historyLoading=true;
    });
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: false);
    String url = BaseUrl.baseUrl + '/reward-collect-history';
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
          _accountProvider.setLoadRewardsHistory(list);
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
        setState(() {
          historyLoading=false;
        });

      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      setState(() {
        historyLoading=false;
      });

    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      setState(() {
        historyLoading=false;
      });

    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      setState(() {
        historyLoading=false;
      });

    }
  }

  Future<void> fetchLoadRewards() async {
    setState(() {
      rewardLoading=true;
    });
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
           

          }
        }
      } 
      else {
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
      setState(() {
        rewardLoading=false;
      });
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
     
      setState(() {
        rewardLoading=false;
      });

    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
     
      setState(() {
        rewardLoading=false;
      });

    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
     
      setState(() {
        rewardLoading=false;
      });

    }
  }
}