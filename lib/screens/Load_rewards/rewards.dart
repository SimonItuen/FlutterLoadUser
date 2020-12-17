import 'package:flutter/material.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/helper/session_manager_util.dart';
import 'package:load/model/cache_reward_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Load_rewards/Redeem_Rewards_details_page.dart';
import 'package:load/screens/Load_rewards/Rewards_details_page.dart';
import 'package:load/screens/MyRewards/points.dart';
import 'package:load/widgets/load_reward_tile.dart';
import 'package:load/model/load_reward_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;
import 'dart:async';
import 'dart:io';

import 'package:provider/provider.dart';

class Rewards extends StatefulWidget {
  final bool isLoading;
/*  final List<CacheRewardModel> cacheList;*/
  Rewards(this.isLoading, /*this.cacheList*/);
  @override
  _RewardsState createState() => _RewardsState();
}

class _RewardsState extends State<Rewards> {
  BuildContext _context;
  List<LoadRewardModel> list = List<LoadRewardModel>();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      fetchLoadRewards();
    });
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
        list =_accountProvider.getLoadRewardList;
        return Container(
          child: RefreshIndicator(
            onRefresh: fetchLoadRewards,
            child: widget.isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : list.isEmpty
                    ? Center(
                        child: Text(
                        'No Load Rewards available',
                        style: TextStyle(
                            fontFamily: 'OpenSans-Regular',
                            color: Mycolors.dark4),
                      ))
                    : ListView.builder(
                        itemCount: list.length,
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.only(top: 4, bottom: 4),
                        itemBuilder: (BuildContext context, int i) {
                          return LoadRewardTile(
                            name: list[i].rewardName,
                            isLocked: list[i].isLocked,
                            points: list[i].requiredLoadPoints,
                            onPressed: () async {
                              Provider.of<UserAccountProvider>(context,
                                      listen: false)
                                  .setLoadRewardList(list[i].list);
                              if(list[i].list.length ==1){
                                Navigator
                                    .push(
                                    context,
                                    FadedRoute(
                                        builder:
                                            (context) =>
                                            RedeemRewardsdetails(
                                              title:
                                              list[i].rewardName.toString(),
                                              imgUrl:list[i].list[0].rewardImage.toString(),
                                              id: list[i].list[0].rewardId.toString(),
                                            )));
                              }else{
                                await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Rewardsdetails(
                                                title:
                                                list[i].rewardName.toString(),
                                                /*    cacheList: widget.cacheList,*/
                                                storeId: list[i].id)));
                              }
                              /*int flag=-1;
                              String prev = '-1';
                              String imgUrl;
                              for(int j =0; j< widget.cacheList.length; j++){
                                print(j);
                                if(widget.cacheList[j].storeId==list[i].id){
                                  print('This is the value, ${widget.cacheList[j].rewardId}');
                                  if(widget.cacheList[j].rewardId!='-1'){
                                    prev=widget.cacheList[j].rewardId;
                                    imgUrl=widget.cacheList[j].imgUrl;
                                    flag=0;
                                    print(prev);
                                  }
                                  break;

                                }
                              }
*/
                              /*int index =widget.cacheList.indexOf(CacheRewardModel(storeId:list[i].id,rewardId:'-1',);
                              *//*widget.cacheList.insert(index, list[i].l);*/
                              /*list[i].list[0].*/
                              /*if(flag==0) {
                                print('i Came here');
                                Navigator
                                    .push(
                                    context,
                                    FadedRoute(
                                        builder:
                                            (context) =>
                                            RedeemRewardsdetails(
                                              title:
                                              list[i].rewardName.toString(),
                                              imgUrl:imgUrl,
                                              id: prev,
                                            )));
                                *//*Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) => Points(pointDetail: list[i].rewardName, message: 'You have successfully redeemed', type: 'REWARD',),
                              ),
                            );*//*
                                fetchLoadRewards();
                              }else{*/
                                /*await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            Rewardsdetails(
                                                title:
                                                list[i].rewardName.toString(),
                                            *//*    cacheList: widget.cacheList,*//*
                                                storeId: list[i].id)));*/
                                /*Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) => Points(pointDetail: list[i].rewardName, message: 'You have successfully redeemed', type: 'REWARD',),
                              ),
                            );*/
                                fetchLoadRewards();
                              }
                            /*},*/
                          );
                        },
                      ),
          ),
        );
      }),
    );
  }

  Future<void> fetchLoadRewards() async {
    BuildContext context = _context;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);
    String url = BaseUrl.baseUrl + '/load-rewards';

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

          list =
              await iterable.map((en) => LoadRewardModel.fromJson(en)).toList();

          _accountProvider.setLoadRewards(list);
          /*if(list.length!=widget.cacheList.length) {
            widget.cacheList.clear();
            for (LoadRewardModel m in list) {
              widget.cacheList.add(
                  CacheRewardModel(storeId: m.id, rewardId: '-1'));
            }
          }*/
          await getPoints();


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

  /*getPoints() async {
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: false);

    String url = BaseUrl.baseUrl + '/current-point';

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
            */ /*Scaffold.of(context).showSnackBar(snackBar);*/ /*

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
          */ /*Scaffold.of(context).showSnackBar(snackBar);*/ /*

        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          */ /*Scaffold.of(context).showSnackBar(snackBar);*/ /*
        }
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      */ /*Scaffold.of(context).showSnackBar(snackBar);*/ /*

    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      */ /*Scaffold.of(context).showSnackBar(snackBar);*/ /*

    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      */ /*Scaffold.of(context).showSnackBar(snackBar);*/ /*

    }
  }*/
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

}
