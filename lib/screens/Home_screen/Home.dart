import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';
import 'package:load/screens/Home_screen/item_list/list.dart';
import 'package:load/screens/MyAccount_screen/myaccount.dart';
import 'package:load/screens/Qrscan_screen/qrscan.dart';
import 'package:load/screens/Verification2_screen/Verification2.dart';

class Homescreen extends StatefulWidget {
  @override
  _HomescreenState createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
    int _currentIndex = 0;
  final List<Widget> _children = [
    Verification2screen(),
    Verification2screen(),
    Verification2screen(),
    Verification2screen(),
    
  ];
  void onTabTapped(int index) {
   setState(() {
     _currentIndex = index;
   });
 }
  ScrollController controller=ScrollController();
  ScrollController categorycontroller=ScrollController();
  bool closetopcontainer=false;
  var visability=false;
  double topcontainer=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(() {
      double value=controller.offset/125;
      // if(value>2){
      //   setState(() {
      //     controller.offset>0;
      //   });
      // }
      
     setState(() {
       topcontainer=value;
       print(value);
        // if(topcontainer>2){
        //                     setState(() {
        //                       topcontainer=0;
                              
        //                     });
        //                   }
        closetopcontainer=controller.offset>10;
     });
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
          Navigator.pop(ctx);
        });
      },),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(
    TransparentRoute(builder: (BuildContext context) => Qrscan())
);

      },
      backgroundColor: Mycolors.red,
      child: Image.asset('assets/qrcode.png'),
      elevation: 8,
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
                          children: [
                            InkWell(
                              onTap: (){
                                _scaffoldKey.currentState.openDrawer();
                              },
                              child: Image.asset('assets/menu.png',height: 18,)),
                            Expanded(child: SizedBox()),
                                                     Icon(Icons.search,color: Colors.white,),

                           
                              
                          ],
                        ),
                      ),
                      SizedBox(height: height/15,),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                         // color: Colors.black,
                          width: width,
                          height: height/4.4,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(image: AssetImage('assets/card1.png'),fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(12),
                            boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),]
                          ),
                          child: Container(
                            padding: EdgeInsets.only(left: 20,top: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image.asset('assets/logo1.png',height: 35,),
                                    SizedBox(height: height/70,),
                                    Image.asset('assets/profile2.png'),
                                    SizedBox(height: height/100,),
                                    Text("Abdullah Salah",
                                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Bold',color: Mycolors.dark),),
                                    Text("+965 55111111",
                                                  style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                                      ],
                                    ),
                                    Expanded(child: SizedBox()),

                                    Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                   Padding(
                                     padding: const EdgeInsets.only(left: 40),
                                     child: Text("1500",
                                                    style: TextStyle(fontSize: 28,fontFamily: 'OpenSans-Bold',color: Mycolors.dark2),),
                                   ),
                                //SizedBox(height: height/300,),
                               
                                Padding(
                                  padding: const EdgeInsets.only(left: 40),
                                  child: Text("Points",
                                                style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Regular',color: Mycolors.dark2),),
                                ),
                                SizedBox(height: height/20,),
                                
                                Container(
                                  width: width/2.4,
                                  height: height/18,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(topLeft: Radius.circular(20),bottomLeft: Radius.circular(20),),
                                    color: Colors.black.withOpacity(0.5)
                                  ),
                                  child: Center(
                                    child: Text("Check Rewards",
                                                  style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Bold',color: Mycolors.white),),
                                  ),
                                ),
                                  ],
                                )
                                  ],
                                )
                              ],
                            ),
                          ),
                          )
                      ),
                      SizedBox(height:closetopcontainer?0: height/50,),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: AnimatedOpacity(
                          duration: Duration(milliseconds: 400),
                        opacity: closetopcontainer?0:1,
                          child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text("Trending",
                                                  style: TextStyle(fontSize: 18,fontFamily: 'OpenSans-Bold',color: Mycolors.dark),),
                                  Expanded(child: SizedBox()),
                                   Text("View All",
                                                  style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Semibold',color: Mycolors.red),),
                                ],
                              ),
                        ),
                      ),
                      SizedBox(height:closetopcontainer?0: height/150,),

                    AnimatedOpacity(
                        duration: Duration(milliseconds: 400),
                        opacity: closetopcontainer?0:1,
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        width: width,
                        alignment: Alignment.topCenter,
                        height: closetopcontainer?0:height/4.2,
                        child: ListView.separated(
                          padding: EdgeInsets.only(left: 16,right: 16),
                          
                          separatorBuilder: (context, index) {return SizedBox(width: 10,);},
                          itemCount: 3,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context,int i){
                            return Center(
                              child: FittedBox(
                                fit: BoxFit.cover,
                                alignment: Alignment.topCenter,
                                child: Container(
                          width: width/1.3,
                          height: height/4.5,
                          decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                  boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                          ],
                  color: Colors.white,
                          ),
                          child: Stack(
                                children: [
                                  Container(
                                    width: width,
                                    height: height/6.2,
                                    child: Image.asset('assets/food1.png',fit: BoxFit.fill,),
                                  ),
                                  Positioned(
                                    bottom: 5,
                                    left: 5,
                                    child: Image.asset('assets/pizza.png')),

                                    Positioned(
                                      bottom: 9,
                                      left: 80,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("Pizza Hut",
                                                        style: TextStyle(fontSize: 16,fontFamily: 'OpenSans-Semibold',color: Mycolors.dark),),
                                           Text("Pizza",
                                                        style: TextStyle(fontSize: 12,fontFamily: 'OpenSans-Regular',color: Mycolors.dark4),),
                                        ],
                                      ),
                                    )
                                ],
                          ),
                        ),
                              ),
                            )
 ;
                          }),
                      ),
                    ),
                    Container(
                      width: width,
                      height: height/1.7,
                     // padding: EdgeInsets.symmetric(horizontal: 16),
                     // color: Colors.red,
                      child: ListView.builder(
                        padding: EdgeInsets.only(bottom: 20,top: 20),
                        controller: controller,
                        itemCount: Category.popularCategoryList.length,
                        itemBuilder:(BuildContext context,int i){
                          double scale=1.0;
                        
                          if (topcontainer>1){
                            scale=i+1-topcontainer;
                            //print(scale);
                            if(scale<0){
                            scale=0;
                          }else if(scale>1){
                            scale=1;
                          }
                          }
                          
                          return Opacity(
                            opacity: scale,
                            child: Transform(
                              alignment: Alignment.bottomCenter,
                              transform: Matrix4.identity()..scale(scale,scale),
                              child: Align(
                                heightFactor: 0.75,
                                alignment: Alignment.topCenter,
                                child: FittedBox(
                                  fit: BoxFit.cover,
                                  child: Container(
                                    margin: EdgeInsets.symmetric(horizontal: 16),
                                    width: width,
                                    height: 180,
                                     decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(24),
                                        boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: Offset(0, 3), // changes position of shadow
                                      ),
                        ],
                  color: Colors.white,),
                  child: ClipRRect(
                    borderRadius:  BorderRadius.circular(24),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(child: Image.asset(Category.popularCategoryList[i].imagePath,fit: BoxFit.fill,)),
                            Positioned(
                              left: 30,
                              top: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                Text(Category.popularCategoryList[i].secondry_title,
                                          style: TextStyle(fontSize: 14,fontFamily: 'OpenSans-Regular',color: Category.popularCategoryList[i].color),),
                                Text(Category.popularCategoryList[i].title,
                                          style: TextStyle(fontSize: 34,fontFamily: 'OpenSans-Semibold',color: Category.popularCategoryList[i].color),),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    )),
                                  ),
                                ),
                              ),
                            ),
                          );
                        } ),
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
                 widget.onTap(context,0);
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
                            SizedBox(width: width/5,),
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
                 widget.onTap(context,0);
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
                 widget.onTap(context,0);
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