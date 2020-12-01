import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/MyRewards/points.dart';
import 'package:load/model/reward_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/MyRewards/points.dart';
import 'package:load/widgets/reward_tile.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Checkreward extends StatefulWidget {
  @override
  _CheckrewardState createState() => _CheckrewardState();
}

class _CheckrewardState extends State<Checkreward> {
  List<RewardModel> list = new List<RewardModel>();
  bool isLoading = false;
  BuildContext _context;

  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () {
      fetchReward();
    });
  }


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
     var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    _context=context;
    return Material(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Mycolors.red,
          centerTitle: true,
          title: Text('My Rewards' ,style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right:10.0),
              child: Icon(Icons.search,color: Colors.white,),
            )
            ],
        ),
        body: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              _context=context;
              return  Container(
                //padding: EdgeInsets.symmetric(horizontal: 8),
                width: width,
                height: height,
                child: isLoading
                    ? Center(
                  child: CircularProgressIndicator(),
                )
                    :RefreshIndicator(
                  onRefresh: fetchReward,
                  child: list.isEmpty? Center(
                    child: Text(
                      "No rewards yet",
                      style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'OpenSans-Regular',
                          color: Mycolors.dark),
                    ),
                  )
                      :ListView.separated(
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          height: height / 30,
                        );
                      },
                      padding:
                      EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 100),
                      itemCount: list.length,
                      itemBuilder: (context, int i) {
                        return RewardTile(
                          name: list[i].storeName,
                          coverUrl: list[i].storeCoverUrl,
                          logoUrl: list[i].storeLogoUrl,
                          points: list[i].points,
                          onPressed: () {
                            Navigator.of(context).push(
                              PageRouteBuilder(
                                opaque: false, // set to false
                                pageBuilder: (_, __, ___) => Points(),
                              ),
                            );
                          },
                        );
                      }),
                ),
              );
            }),
      ),
    );
  }

  Future<void> fetchReward() async {
    BuildContext context=_context;
    UserAccountProvider _accountProvider =
    Provider.of<UserAccountProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    String url = BaseUrl.baseUrl + '/my-rewards';

    try {
      http.Response response = await http.get(url,
          headers: {
            "Content-Type": "application/json",
            "X-Requested-With": "XMLHttpRequest"
          },
      );


      if (response.statusCode == 200) {

        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['success'].toString() == 'true') {
          Iterable iterable = jsonResponse['data'];

          list = await iterable.map((en) => RewardModel.fromJson(en)).toList();

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
        }
        setState(() {
          isLoading = false;
        });
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isLoading = false;
      });
    }
  }
}