import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:load/helper/colors.dart';
import 'package:load/model/partner_model.dart';
import 'package:load/providers/user_account_provider.dart';
import 'package:load/widgets/partners_tile.dart';
import 'package:provider/provider.dart';


class PartnersPageOne extends StatefulWidget {
  final PageController pageController;
  final List<PartnersModel> list;
  final Function() refresh;
  final bool isLoading;

  PartnersPageOne(this.pageController, this.list, this.refresh, this.isLoading);

  @override
  _PartnersPageOneState createState() => _PartnersPageOneState();




}

class _PartnersPageOneState extends State<PartnersPageOne> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height -AppBar().preferredSize.height *2;
   return SingleChildScrollView(
     padding: EdgeInsets.only(left: 10,right: 10, top: 10, bottom: 30),
     child: Container(
        width: width,
        height: height,
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
            : GridView.builder(
          itemCount: widget.list.length,
          gridDelegate:
          SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 20 ),
          itemBuilder: (BuildContext context, int index) {
            return OurPartnersTile(
              name: widget.list[index].title,
              onPressed: () {
                Provider.of<UserAccountProvider>(context, listen: false).setPartner(widget.list[index].title);
                Provider.of<UserAccountProvider>(context, listen: false).setCategoryId(widget.list[index].id);
                widget.pageController.jumpToPage(1);
              },
              coverUrl: widget.list[index].image,
            );
          },
        ),
      ),
   );
  }
}
