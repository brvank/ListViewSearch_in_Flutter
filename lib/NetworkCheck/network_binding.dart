import 'package:get/get.dart';
import 'package:ui_app/NetworkCheck/jarvis_network_connectivity_controller.dart';

class NetworkBinding extends Bindings{


  @override
  void dependencies() {
    // TODO: implement dependencies

    Get.lazyPut<NetworkConnectivityManager>(() => NetworkConnectivityManager());
  }


}