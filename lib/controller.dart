import 'package:get/get.dart';

class Controller extends GetxController{

  var result = 'No fruits in cart'.obs;
  var allSelected = false.obs;
  var fruitsList = <String>[].obs;
  var checkStatusList = <RxBool>[].obs;
  var showOrNot = <RxBool>[].obs;

  void putFruits(List<String> fruits){
    var listLength = fruits.length;
    for(int i=0;i<listLength;i++){
      fruitsList.value.add(fruits[i]);
      checkStatusList.value.add(false.obs);
      showOrNot.value.add(true.obs);
    }

    fruitsList.sort();
  }

}