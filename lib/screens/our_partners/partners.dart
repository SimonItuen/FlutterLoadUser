import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/model/trending_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:load/widgets/partners_tile.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/model/partner_model.dart';
import 'dart:convert' as convert;
import 'package:load/model/category_store_model.dart';
import 'package:load/screens/our_partners/page_one.dart';
import 'package:load/screens/our_partners/page_two.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:io';

import 'package:provider/provider.dart';

class Partners extends StatefulWidget {
  @override
  _PartnersState createState() => _PartnersState();

}

class _PartnersState extends State<Partners> {
  TextEditingController controller = TextEditingController();
  PageController _pageController = PageController(initialPage: 0, keepPage: false);
  final focus = FocusNode();
  List<PartnersModel> list = List<PartnersModel>();
  List<CategoryStoreModel> listTwo = List<CategoryStoreModel>();

  bool isCategoryLoading = false;
  bool isCategoryPartnersLoading = false;
  BuildContext _context;
  int _currentPage = 0;

  _onPageChanged(int index) {
    if(index==1){
      Provider.of<UserAccountProvider>(context, listen: false).setStillStayInPartnerClick(true);

    }else{
      Provider.of<UserAccountProvider>(context, listen: false).setStillStayInPartnerClick(false);
      Provider.of<UserAccountProvider>(context, listen: false).setPartner('Our Partners');
    }
    setState(() {
      _currentPage = index;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    Future.delayed(Duration.zero, () {
      Provider.of<UserAccountProvider>(context, listen: false).setStillStayInPartnerClick(false);
      fetchCategories();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> _willPopCallback() async {
    // await showDialog or Show add banners or whatever
    // then
    if (_currentPage!=0) {
      _pageController.jumpToPage(0);
      return false;
    } else {
      return true; // n true if the route to be popped
    }
  }



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        body: LayoutBuilder(builder:
            (BuildContext context, BoxConstraints viewportConstraints) {
          _context = context;
          return Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Container(
              child: Stack(
                //fit: StackFit.loose,
                children: [
                  BackdropBg(),
                  // Container(
                  //   width: width,
                  //   height: height/50,
                  //   color: Mycolors.red,
                  // ),
                  PageView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      onPageChanged: _onPageChanged,
                      controller: _pageController,
                      itemCount: 2,
                      itemBuilder: (ctx, i) {
                        if (i == 0) {
                          return PartnersPageOne(_pageController, list,
                              fetchCategories, isCategoryLoading);
                        } else if (i == 1) {
                          return PartnersPageTwo(_pageController, listTwo,
                              fetchPartners, isCategoryPartnersLoading);
                        } else {
                          return null;
                        }
                      })
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Future<void> fetchCategories() async {

    BuildContext context = _context;
    setState(() {
      list.clear();
      isCategoryLoading = true;
    });
    String url = BaseUrl.baseUrl + '/our-partner';

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

          list =
              await iterable.map((en) => PartnersModel.fromJson(en)).toList();

          setState(() {
            isCategoryLoading = false;
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
              isCategoryLoading = false;
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
            isCategoryLoading = false;
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
        setState(() {
          isCategoryLoading = false;
        });
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isCategoryLoading = false;
      });
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isCategoryLoading = false;
      });
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isCategoryLoading = false;
      });
    }
  }

  Future<void> fetchPartners() async {
    BuildContext context = _context;
    setState(() {
      isCategoryPartnersLoading = true;
    });

    String url = BaseUrl.baseUrl + '/partner-wise-store';

    var map = convert.jsonEncode(<String, String>{
      'category_id':
          Provider.of<UserAccountProvider>(context, listen: false).getCategoryId
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
          Iterable iterable = jsonResponse['data'];

          listTwo =
              await iterable.map((en) => CategoryStoreModel.fromJson(en)).toList();

          setState(() {
            isCategoryPartnersLoading = false;
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
              isCategoryPartnersLoading = false;
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
            isCategoryPartnersLoading = false;
          });
        } else {
          final snackBar = SnackBar(
            content: Text('Couldn\'t Connect, please try again'),
            duration: Duration(seconds: 4),
          );
          Scaffold.of(context).showSnackBar(snackBar);
        }
        setState(() {
          isCategoryPartnersLoading = false;
        });
      }
    } on TimeoutException catch (e) {
      final snackBar = SnackBar(
        content: Text('Timeout Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isCategoryPartnersLoading = false;
      });
    } on SocketException catch (e) {
      final snackBar = SnackBar(
        content: Text('Socket Error: ${e.message}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isCategoryPartnersLoading = false;
      });
    } on Error catch (e) {
      final snackBar = SnackBar(
        content: Text('General Error: ${e}'),
        duration: Duration(seconds: 4),
      );
      Scaffold.of(context).showSnackBar(snackBar);
      setState(() {
        isCategoryPartnersLoading = false;
      });
    }
  }
}
