import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/base_url.dart';
import 'package:load/helper/colors.dart';
import 'package:load/model/search_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Home_screen/Home.dart';
import 'package:load/screens/Login_screen/Login.dart';
import 'package:load/screens/Reset2_password_screen/reset2_password.dart';
import 'package:load/screens/Resturant_detail_screen/Resturant_detail.dart';
import 'package:load/widgets/backdrop_bg.dart';
import 'package:load/widgets/reward_tile.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/MyRewards/points.dart';
import 'package:load/widgets/reward_tile.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Searchscreen extends StatefulWidget {
  @override
  _SearchscreenState createState() => _SearchscreenState();
}

class _SearchscreenState extends State<Searchscreen> {
  List<SearchModel> list = List<SearchModel>();
  bool isLoading = false;
  String info = 'Search for your favourite stores';
  BuildContext _context;
  bool allow= false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      // appBar: AppBar(
      //   automaticallyImplyLeading: true,
      //   leading: IconButton(icon: Icon(Icons.arrow_back,color: Colors.white,), onPressed: (){
      //     Navigator.pop(context);
      //   }),
      //   title:  Container(

      //     height: height/18,
      //     decoration: BoxDecoration(

      //       borderRadius: BorderRadius.circular(12),
      //     color: Colors.white,
      //     ),
      //     child: Theme(
      //       data: ThemeData(
      //         primaryColor: Mycolors.red

      //       ),
      //       child: TextFormField(

      //           decoration: new InputDecoration(
      //             contentPadding: EdgeInsets.only(top: 3,left: 10),
      //             suffixIcon: Icon(Icons.search),
      //            // labelText: "Email Address",
      //             labelStyle: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.red) ,
      //             hintText: 'Search stores',
      //             hintStyle:  TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
      //             fillColor: Colors.white,

      //             enabledBorder: OutlineInputBorder(
      //               borderRadius: BorderRadius.circular(14),
      //               borderSide: BorderSide(

      //                 color: Colors.white
      //               )
      //             ),
      //             focusedBorder: OutlineInputBorder(
      //               borderRadius: new BorderRadius.circular(14.0),
      //               borderSide: new BorderSide(
      //                 color: Colors.white
      //               ),
      //             ),

      //             border: new OutlineInputBorder(

      //               borderRadius: new BorderRadius.circular(14.0),
      //               borderSide: new BorderSide(
      //                 color: Colors.white
      //               ),
      //             ),
      //             //fillColor: Colors.green
      //           ),
      //           validator: (val) {

      //           },
      //           keyboardType: TextInputType.emailAddress,
      //           style: new  TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),
      //         ),
      //     ),
      //   ),

      //   //centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Mycolors.red,
      // ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints viewportConstraints) {
          _context = context;
          return Container(
            width: width,
            height: height,
            color: Colors.white,
            child: Stack(
              children: [
                BackdropBg(),
                Container(
                  width: width,
                  height: height / 50,
                  color: Mycolors.red,
                ),
                Container(
                  //padding: EdgeInsets.symmetric(horizontal: 8),
                  width: width,
                  height: height,
                  child: isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : list.isEmpty||!allow
                          ? Center(
                              child: Text(
                                info,
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: 'OpenSans-Regular',
                                    color: Mycolors.dark),
                              ),
                            )
                          : ListView.separated(
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height: height / 47,
                                );
                              },
                              padding: EdgeInsets.only(
                                  top: 120, left: 8, right: 8, bottom: 20),
                              itemCount: list.length,
                              itemBuilder: (context, int i) {
                                return RewardTile(
                                  onPressed: () {
                                    Provider.of<UserAccountProvider>(context, listen: false).setStoreId(list[i].id);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Resturantdetails()));
                                  },
                                  coverUrl: list[i].storeCoverUrl,
                                  name: list[i].storeName,
                                  category: list[i].categoryName,
                                  logoUrl: list[i].storeLogoUrl,
                                );
                              }),
                ),
                Container(
                  width: width,
                  height: height / 20,
                  color: Mycolors.red,
                ),
                Positioned(
                  top: 40,
                  child: Container(
                    width: width,
                    height: height / 14,
                    color: Mycolors.red,
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Container(
                          height: height / 19,
                          width: width / 1.2,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.white,
                          ),
                          child: Theme(
                            data: ThemeData(primaryColor: Mycolors.red),
                            child: TextFormField(
                              autofocus: true,
                              onChanged: (value) async{
                                if (value.trim().length > 0) {
                                  search(value);
                                  setState(() {
                                    info = 'No Results';
                                    allow =true;
                                  });
                                } else {
                                  list.clear();
                                  setState(() {
                                    allow =false;
                                    list.clear();
                                    info = 'Search for your favourite stores';
                                  });
                                }
                              },
                              decoration: new InputDecoration(
                                contentPadding:
                                    EdgeInsets.only(top: 3, left: 10),
                                suffixIcon: Icon(Icons.search),
                                // labelText: "Email Address",
                                labelStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'OpenSans-Regular',
                                    color: Mycolors.red),
                                hintText: 'Search stores',
                                hintStyle: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'OpenSans-Regular',
                                    color: Mycolors.dark2),
                                fillColor: Colors.white,

                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(14),
                                    borderSide:
                                        BorderSide(color: Colors.white)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(14.0),
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                ),

                                border: new OutlineInputBorder(
                                  borderRadius: new BorderRadius.circular(14.0),
                                  borderSide:
                                      new BorderSide(color: Colors.white),
                                ),
                                //fillColor: Colors.green
                              ),
                              validator: (val) {},
                              keyboardType: TextInputType.emailAddress,
                              style: new TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'OpenSans-Regular',
                                  color: Mycolors.dark2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> search(String keyword) async {
    BuildContext context = _context;
    UserAccountProvider _accountProvider =
        Provider.of<UserAccountProvider>(context, listen: false);
    setState(() {
      isLoading = true;
    });
    String url = BaseUrl.baseUrl + '/search-stores';
    print(url);
    var map = convert.jsonEncode(<String, String>{'store_name': keyword});
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

          list = await iterable.map((en) => SearchModel.fromJson(en)).toList();
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
