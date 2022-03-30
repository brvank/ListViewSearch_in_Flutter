import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_app/NetworkCheck/jarvis_network_connectivity_controller.dart';

class NetworkPage extends StatefulWidget {
  const NetworkPage({Key? key}) : super(key: key);

  @override
  _NetworkPageState createState() => _NetworkPageState();
}

class _NetworkPageState extends State<NetworkPage> {

  late NetworkConnectivityManager _networkConnectivityManager;

  @override
  void initState(){
    super.initState();

    try{
      _networkConnectivityManager = Get.find();
    }catch(e){
      print('don"t find');
      _networkConnectivityManager = Get.put(NetworkConnectivityManager());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Network connection page'),
      ),
      body: Obx(() => Container(
        child: Center(
          child: _networkConnectivityManager.connected.value?Text('Connected to the internet'):Text('Not connected to the internet'),
        ),
      )),
    );
  }
}
