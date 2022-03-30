import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Routing & Navigation"),
        ),
        body: StreamBuilder(
            stream: future(),
            builder: (BuildContext ctxt,
                AsyncSnapshot snapShot) {
              if (!snapShot.hasData) return CircularProgressIndicator();
              var result = snapShot.data;
              switch (result) {
                case ConnectivityResult.none:
                  print("no net");
                  return Center(child: Text("No Internet Connection!"));
                case ConnectivityResult.mobile:
                  print("yes net");
                  return Center(
                    child: Text('Welcome to home Page'),
                  );
                case ConnectivityResult.wifi:
                  InternetAddress.lookup('google.com').then((value){
                    if(value.isNotEmpty && value[0].rawAddress.isNotEmpty){
                      print(value.toString());
                      print('welocm');
                      return Center(child: Text("Welcome to home page"),);
                    }else{
                      print('no internet');
                     return Center(child: Text("No internet connection"),);
                    }
                  });
                  return Center(child: Text("Unwanted problem"),);
                default:
                  return Center(child: Text("No Internet Connection!"));
              }
            })
    );
  }

  Stream<ConnectivityResult> future(){
    return Connectivity().onConnectivityChanged;
  }


}