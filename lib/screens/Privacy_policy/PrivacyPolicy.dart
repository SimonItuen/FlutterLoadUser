import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/helper/session_manager_util.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:provider/provider.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:async';

class PrivacyPolicy extends StatefulWidget {
  @override
  _PrivacyPolicyState createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  String privacyPolicy;
  bool isLoading = false;
  BuildContext _context;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () async {
      await loadPrivacyPolicy();
      retrievePrivacyPolicy();
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
    return Scaffold(
      body: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints viewportConstraints) {
        _context = context;
        return Container(
          width: width,
          height: height,
          color: Mycolors.red,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top:20),
                  padding: EdgeInsets.only(left: 34, right: 20, top: 20),
                  width: width,
                  //height: height,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24)),
                      color: Colors.white),
                  child:  isLoading
                      ? Center(
                    child: CircularProgressIndicator(),
                  )
                      :SingleChildScrollView(
                      child: Container(
                              child: Text(
                              privacyPolicy.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'OpenSans-Regular',
                                  color: Mycolors.dark),
                            ))),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  loadPrivacyPolicy() async {
    BuildContext context = _context;
    setState(() {
      isLoading = true;
    });
    String url = BaseUrl.baseUrl + '/get-privacy-policy';
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
          privacyPolicy = jsonResponse['data']['content'];
          SessionManagerUtil.putString('privacyPolicy', privacyPolicy);

          print(jsonResponse);
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

  retrievePrivacyPolicy() {
    if(privacyPolicy == null){
      setState(() {
        isLoading=false;
        privacyPolicy = SessionManagerUtil.getString('privacyPolicy');
      });
    }
  }
}
