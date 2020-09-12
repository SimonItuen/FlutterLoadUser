import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Home_screen/item_list/Home_screen)content.dart';
import 'package:load/screens/Home_screen/item_list/list.dart';
import 'package:load/screens/Load_rewards/loadReward.dart';
import 'package:load/screens/MyAccount_screen/myaccount.dart';
import 'package:load/screens/MyRewards/myrewards.dart';
import 'package:load/screens/Qrscan_screen/qrscan.dart';
import 'package:load/screens/Search_screen/search.dart';
import 'package:load/screens/Term_of_use/Termofuse.dart';
import 'package:load/screens/Verification2_screen/Verification2.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  String title="";
    int _currentIndex = 0;
    var visable=false;
    var visable1=false;
    var safe;
  final List<Widget> _children = [
    Homecontent(),
    Loadreward(),
    Myreward(),
    Homecontent(),
    Termofuse(),
    
  ];
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
   print(index);
  
 }
 
  @override
  void initState() {
  
    super.initState();
    setState(() {
      
      home=true;
                   load=false;
                   my=false;
                   help=false;
                   terms=false;
                   privacy=false;
    });
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
        var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    
    return Scaffold(
      key: _scaffoldKey,
      drawer: MyDrawer(onTap: (ctx,i){
        setState(() {

          _currentIndex=i;
           if(_currentIndex==0){
     setState(() {
      // print(width);
       visable=false;
    visable1=false;
       title="";
     });
   }
   if(_currentIndex==1){
     setState(() {
       visable=true;
    visable1=true;
       title="Load Rewards";
     });
   }
   if(_currentIndex==2){
     setState(() {
       visable=true;
    visable1=false;
       title="My Rewards";
     });
   }
    if(_currentIndex==4){
     setState(() {
       visable=true;
    visable1=false;
       title="Terms of Use";
     });
   }
          Navigator.pop(ctx);
        });
      },),
      floatingActionButton: Opacity(
        opacity: visable?0:1,
        child: FloatingActionButton(onPressed: (){
          Navigator.of(context).push(
    TransparentRoute(builder: (BuildContext context) => Qrscan())
);

        },
        backgroundColor: Mycolors.red,
        child: Image.asset('assets/qrcode.png'),
        elevation: 8,
        ),
      ),
      body: Container(
        width: width,
        height: height,
        color: Colors.white,
        child: Stack(
          children: [
            Container(
              width: width,
              height: height/3.5,
             // color: Colors.black,
              child: Image.asset('assets/curve.png',fit: BoxFit.cover,)),
              Container(
                width: width,
                height: height,
               // padding: EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: height/20,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              onTap: (){
                                _scaffoldKey.currentState.openDrawer();
                              },
                              child: Image.asset('assets/menu.png',height: 18,)),
                           // Expanded(child: SizedBox()),
                           Padding(
                             padding: const EdgeInsets.only(left: 33),
                             child: Text(title ,style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Colors.white),),
                           ),

                        visable1?   IconButton(icon:Image.asset('assets/qrcode.png'), 
                            onPressed: (){
                              //Navigator.push(context, MaterialPageRoute(builder: (context)=>Searchscreen()));
                            })
                        : IconButton(icon:Icon(Icons.search,color: Colors.white,), 
                            onPressed: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Searchscreen()));
                            })
                                

                           
                              
                          ],
                        ),
                      ),
                      Container(
                        width: width,
                        height: height,
                        child: _children[_currentIndex],
                      )
                  
          ],
        ),
                ),
      ),
          ])
    ));
  }
}



class MyDrawer extends StatefulWidget {
  final Function onTap;
  

  const MyDrawer({Key key, this.onTap}) : super(key: key);
  @override
  _MyDrawerState createState() => _MyDrawerState();
}
bool home=true;
bool load=false;
bool my=false;
bool help=false;
bool terms=false;
bool privacy=false;

class _MyDrawerState extends State<MyDrawer> {

  
  @override
  Widget build(BuildContext context) {
     var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Container(
         // padding: EdgeInsets.only(left: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //SizedBox(height: height/40,),

              Container(
                width: width,
                height: height/5,
               color: Mycolors.white,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: height/15,),
                      Padding(
                        padding: const EdgeInsets.only(left: 20,right: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                   // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: (){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Myaccountscreen()));
                              },
                              child: Image.asset('assets/profile2.png',scale: 0.8,)),
                            SizedBox(width: width/30,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                              SizedBox(height: height/150,),
                                 Text("Jhon Doe",
                              style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                              SizedBox(height: height/100,),
                              Text("+965 55112233",
                              style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Mycolors.dark),),
                              ],
                            ),
                            Expanded(child: SizedBox()),
                            Padding(
                              padding: const EdgeInsets.only(top: 15),
                              child: Icon(Icons.arrow_forward,color: Mycolors.dark4,),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

             
              
              SizedBox(height: height/40,),
             InkWell(
                onTap: (){
                  setState(() {
                   home=true;
                   load=false;
                   my=false;
                   help=false;
                   terms=false;
                   privacy=false;
                  
                  });
                 widget.onTap(context,0);
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: home?Mycolors.red.withOpacity(0.1):Colors.white
                  ),
                  child: Row(
                     // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: height/15,
                          width: 5,
                          color:home?Mycolors.red: Colors.white,
                        ),
                        SizedBox(width: width/20,),
                      //  Image.asset('assets/profile1.png',height: 22,),
                       // SizedBox(width: width/15,),
                        Text("Home",
                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                      ],
                    ),
                ),
              ),


               SizedBox(height: height/150,),
             InkWell(
                onTap: (){
                  
                  setState(() {
                   home=false;
                   load=true;
                   my=false;
                   help=false;
                   terms=false;
                   privacy=false;
                  
                  });
                 widget.onTap(context,1);
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: load?Mycolors.red.withOpacity(0.1):Colors.white
                  ),
                  child: Row(
                     // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: height/15,
                          width: 5,
                          color:load?Mycolors.red: Colors.white,
                        ),
                        SizedBox(width: width/20,),
                      //  Image.asset('assets/profile1.png',height: 22,),
                       // SizedBox(width: width/15,),
                        Row(
                          children: [
                            Text("Load Rewards",
                                      style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                            SizedBox(width: width/10,),
                            Container(
                              width: width/6,
                              height: height/30,
                              decoration: BoxDecoration(
                                color: Mycolors.dark,
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Center(
                                child: Text("1500",
                                      style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.yellow),),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                ),
              ),

              SizedBox(height: height/150,),
             InkWell(
                onTap: (){
                  setState(() {
                   home=false;
                   load=false;
                   my=true;
                   help=false;
                   terms=false;
                   privacy=false;
                  
                  });
                 widget.onTap(context,2);
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: my?Mycolors.red.withOpacity(0.1):Colors.white
                  ),
                  child: Row(
                     // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: height/15,
                          width: 5,
                          color:my?Mycolors.red: Colors.white,
                        ),
                        SizedBox(width: width/20,),
                      //  Image.asset('assets/profile1.png',height: 22,),
                       // SizedBox(width: width/15,),
                        Text("My Rewards",
                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                      ],
                    ),
                ),
              ),


              SizedBox(height: height/150,),
             InkWell(
                onTap: (){
                  setState(() {
                   home=false;
                   load=false;
                   my=false;
                   help=true;
                   terms=false;
                   privacy=false;
                  
                  });
                 widget.onTap(context,0);
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: help?Mycolors.red.withOpacity(0.1):Colors.white
                  ),
                  child: Row(
                     // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: height/15,
                          width: 5,
                          color:help?Mycolors.red: Colors.white,
                        ),
                        SizedBox(width: width/20,),
                      //  Image.asset('assets/profile1.png',height: 22,),
                       // SizedBox(width: width/15,),
                        Text("Get Help",
                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                      ],
                    ),
                ),
              ),

            SizedBox(height: height/150,),
             InkWell(
                onTap: (){
                  setState(() {
                   home=false;
                   load=false;
                   my=false;
                   help=false;
                   terms=true;
                   privacy=false;
                  
                  });
                 widget.onTap(context,4);
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: terms?Mycolors.red.withOpacity(0.1):Colors.white
                  ),
                  child: Row(
                     // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: height/15,
                          width: 5,
                          color:terms?Mycolors.red: Colors.white,
                        ),
                        SizedBox(width: width/20,),
                      //  Image.asset('assets/profile1.png',height: 22,),
                       // SizedBox(width: width/15,),
                        Text("Terms of Use",
                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                      ],
                    ),
                ),
              ),


               SizedBox(height: height/150,),
             InkWell(
                onTap: (){
                  setState(() {
                   home=false;
                   load=false;
                   my=false;
                   help=false;
                   terms=false;
                   privacy=true;
                  
                  });
                 widget.onTap(context,0);
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: privacy?Mycolors.red.withOpacity(0.1):Colors.white
                  ),
                  child: Row(
                     // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: height/15,
                          width: 5,
                          color:privacy?Mycolors.red: Colors.white,
                        ),
                        SizedBox(width: width/20,),
                      //  Image.asset('assets/profile1.png',height: 22,),
                       // SizedBox(width: width/15,),
                        Text("Privacy Policy",
                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                      ],
                    ),
                ),
              ),

               SizedBox(height: height/150,),
             InkWell(
                onTap: (){
                  Navigator.pop(context);
                  setState(() {
                  
                  
                  });
                 widget.onTap(context,0);
                  },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white
                  ),
                  child: Row(
                     // mainAxisAlignment: MainAxisAlignment.center,
                     crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          height: height/15,
                          width: 5,
                          color: Colors.white,
                        ),
                        SizedBox(width: width/20,),
                      //  Image.asset('assets/profile1.png',height: 22,),
                       // SizedBox(width: width/15,),
                        Text("Logout",
                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                      ],
                    ),
                ),
              ),
              
             
            ],
          ),
        ),
      ),
    );
  }
}


class TransparentRoute extends PageRoute<void> {
  TransparentRoute({
    @required this.builder,
    RouteSettings settings,
  })  : assert(builder != null),
        super(settings: settings, fullscreenDialog: false);

  final WidgetBuilder builder;

  @override
  bool get opaque => false;

  @override
  Color get barrierColor => null;

  @override
  String get barrierLabel => null;

  @override
  bool get maintainState => true;

  @override
  Duration get transitionDuration => Duration(milliseconds: 350);

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final result = builder(context);
    return FadeTransition(
      opacity: Tween<double>(begin: 0, end: 1).animate(animation),
      child: Semantics(
        scopesRoute: true,
        explicitChildNodes: true,
        child: result,
      ),
    );
  }
}