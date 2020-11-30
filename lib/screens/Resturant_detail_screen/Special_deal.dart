import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:load/helper/colors.dart';

class Speacialdeal extends StatefulWidget {
  @override
  _SpeacialdealState createState() => _SpeacialdealState();
}

class _SpeacialdealState extends State<Speacialdeal> {
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
     var width=MediaQuery.of(context).size.width;
    var height=MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      color: Colors.black.withOpacity(0.5),
      child: Stack(
        children: [
         // IconButton(icon: Icon(Icons.cancel,color: Colors.white,size: 25,), onPressed: (){}),
          Column(
            children: [
              SizedBox(height: height/5,),
              Expanded(child: Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(12),topRight: Radius.circular(12))
                ),
                child: Center(
                  child: Column(
                    children: [
                      SizedBox(height: height/2.6,),
                        Text("Special Deal 100% OFF",
                                        style: Theme.of(context).primaryTextTheme.headline4,),
                      SizedBox(height: height/20,),
                      Text("606 312 16",
                                        style: Theme.of(context).primaryTextTheme.headline5,),
                          Expanded(child: SizedBox(),),              
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Container(
                          width: width,
                          height: height/14,
                          margin: EdgeInsets.symmetric(horizontal: 16),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                          color: Mycolors.red_dark,
                          ),
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                            ),
                            onPressed: (){
                              Navigator.pop(context);
                          }, child: Center(
                            child:Text("GO BACK",
                                          style: Theme.of(context).primaryTextTheme.headline3,) ,
                          )),
                        ),
                      )
                        
                    ],
                  ),
                ),
              ))
            ],
          ),
          Positioned(
            //padding: const EdgeInsets.all(28.0),
            right: width/40,
            top: height/20,
            child: FlatButton(
              child: Icon(Icons.cancel,size: 45,color: Colors.white,),
              onPressed: (){
Navigator.pop(context);
            },),
          ),
          Positioned(
            left: width/7,
            top: height/6,
            child: Container(
              width: width/1.4,
              height: width/1.4,
              decoration: BoxDecoration(
              //color: Colors.black,
                borderRadius: BorderRadius.circular(14)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.asset('assets/qr-code.png',fit: BoxFit.fill,)),
            ),
          )
        ],
      ),
    );
  }
}