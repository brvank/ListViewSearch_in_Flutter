import 'dart:isolate';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ui_app/NetworkCheck/jarvis_network_connectivity.dart';
import 'package:ui_app/NetworkCheck/jarvis_network_connectivity_controller.dart';
import 'package:ui_app/NetworkCheck/network_binding.dart';
import 'package:ui_app/jarvis_video_player/jarvis_video_player_ui.dart';
import 'package:ui_app/myap.dart';

void main(){
  runApp(GetMaterialApp(
    initialBinding: NetworkBinding(),
    theme: ThemeData(
      brightness: Brightness.light
    ),
    darkTheme: ThemeData(
      brightness: Brightness.dark
    ),
    title: 'My App',
    home: Scaffold(
      appBar: AppBar(
        title: Text('Jarvis Video Player'),
      ),
      body: JarvisVideoPlayerUI(),
    ),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  late NetworkConnectivityManager _networkConnectivityManager;

  @override
  void initState(){
    super.initState();

    try{
      print(super.initState.toString());
    }catch(e){
      print('error');
    }

    try{
      _networkConnectivityManager = Get.find();
    }catch(e){
      print('don"t find --');
      _networkConnectivityManager = Get.put(NetworkConnectivityManager());
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                child: Center(child: CircularProgressIndicator(strokeWidth: 4,color: Colors.red,backgroundColor: Color(0x00ffffff),),),
                width: 400,
                height: 400,
              ),
              SizedBox(
                child: Center(child: CircularProgressIndicator(strokeWidth: 4,color: Colors.blue,backgroundColor: Color(0x00ffffff),),),
                width: 150,
                height: 150,
              ),
            ],
          ),
          BottomSheet(onClosing: (){}, builder: (context){
            return Container(
              child: Text('this is for demo only'),
            );
          }),
          InkWell(
            child: Icon(
              Icons.arrow_forward,
              size: 30,
            ),
            onTap: (){
              Get.to(MyHomePage());
            },
          ),
          FaIcon(FontAwesomeIcons.bell, color: Colors.black54,),
          FaIcon(FontAwesomeIcons.bell, color: Colors.blue,),
          FaIcon(FontAwesomeIcons.bellSlash, color: Colors.orange,),
          FaIcon(FontAwesomeIcons.conciergeBell, color: Colors.blue,),
          FaIcon(FontAwesomeIcons.hamburger, color: Colors.orange,),
          FaIcon(FontAwesomeIcons.hamburger, color: Colors.blue,),
          FaIcon(FontAwesomeIcons.diceThree, color: Colors.orange,),
          FaIcon(FontAwesomeIcons.dice, color: Colors.blue,),
          FaIcon(FontAwesomeIcons.camera, color: Colors.orange,),
          FaIcon(FontAwesomeIcons.camera, color: Colors.blue,),
          FaIcon(FontAwesomeIcons.cameraRetro, color: Colors.orange,),
        ],
      ),
    );
  }

}
