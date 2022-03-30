import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NetworkConnectivityManager extends GetxController {
  var connected = false.obs;

  final Connectivity _connectivity = Connectivity();
  @override
  void onInit() {
    getConnectivity();
    _connectivity.onConnectivityChanged.listen((_connectivityResult) {
      updateState(_connectivityResult);
    });
  }

  Future<void> getConnectivity() async {
    print('checking connection');
    var _connectivityResult;
    try {
      _connectivityResult = await _connectivity.checkConnectivity();
      updateState(_connectivityResult);
    } catch (e) {
      print(e);
    }
  }

  Future<void> updateState(ConnectivityResult _connectivityResult) async {
    switch (_connectivityResult) {
      case ConnectivityResult.none:
        connected.value = false;
        break;
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
        connected.value = await checkIfWifiHasInternetAccess();
        break;
    }
    print(connected.value.toString() + 'connection status');
  }

  Future<bool> checkIfWifiHasInternetAccess() async {
    try {
      var dio = Dio();
      var result = await dio.get('https://www.google.com/');
      return true;
    } catch (e) {
      print('error');
      print(e.runtimeType);
      return false;
    }
  }

  @override
  void onClose() {}
}
