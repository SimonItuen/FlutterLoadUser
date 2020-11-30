import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';
import 'package:load/model/category_store_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/screens/Resturant_detail_screen/Resturant_detail.dart';
import 'package:load/widgets/reward_tile.dart';
import 'package:provider/provider.dart';

class PartnersPageTwo extends StatefulWidget {
  final PageController pageController;
  final List<CategoryStoreModel> list;
  final bool isLoading;
  final Function() refresh;

  PartnersPageTwo(this.pageController, this.list, this.refresh, this.isLoading);

  @override
  _PartnersPageTwoState createState() => _PartnersPageTwoState();
}

class _PartnersPageTwoState extends State<PartnersPageTwo> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, widget.refresh);
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height / 1,
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: widget.isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : widget.list.isEmpty
              ? Center(
                  child: Text(
                  "No Partners available yet",
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'OpenSans-Regular',
                      color: Mycolors.dark),
                ))
              : ListView.separated(
                  separatorBuilder: (context, index) {
                    return SizedBox(
                      height: height / 30,
                    );
                  },
                  padding:
                      EdgeInsets.only(top: 20, left: 8, right: 8, bottom: 100),
                  itemCount: widget.list.length,
                  itemBuilder: (context, int i) {
                    return RewardTile(
                      name: widget.list[i].storeName,
                      category: Provider.of<UserAccountProvider>(context, listen: true).getPartner.toString(),
                      coverUrl: widget.list[i].storeCoverUrl,
                      logoUrl: widget.list[i].storeLogoUrl,
                      onPressed: () {
                        Provider.of<UserAccountProvider>(context, listen: false)
                            .setStoreId(widget.list[i].id);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Resturantdetails()));
                      },
                    );
                  }),
    );
  }
}
