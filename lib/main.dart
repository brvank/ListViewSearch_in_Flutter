import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_app/controller.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Fruits',
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Controller controller;

  TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    try {
      controller = Get.find();
    } catch (e) {
      print(e);
      controller = Get.put(Controller());
    }
    controller.putFruits([
      'banana',
      'mango',
      'apple',
      'guava',
      'cherry',
      'orange',
      'tomato',
      'carrot',
      'cheeku',
      'grapes'
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fruits'),
      ),
      body: Column(
        children: [
          //for search bar
          Container(
            child: ListTile(
              title: TextFormField(
                controller: _editingController,
                onChanged: (str) {
                  if (str.length == 0) {
                    for (int i = 0;
                        i < controller.showOrNot.value.length;
                        i++) {
                      controller.showOrNot.value[i].value = true;
                    }
                    return;
                  }
                  //TODO: filter code here
                  for (int i = 0; i < controller.fruitsList.value.length; i++) {
                    String fruit = controller.fruitsList.value[i];
                    if (str.length > fruit.length) {
                      controller.showOrNot.value[i].value = false;
                    } else {
                      int strLength = str.length;
                      controller.showOrNot.value[i].value = false;
                      for (int j = 0; j < fruit.length - strLength; j++) {
                        if (str == fruit.substring(j, j + strLength)) {
                          controller.showOrNot.value[i].value = true;
                          break;
                        } else {
                          continue;
                        }
                      }
                    }
                  }
                  //upto here
                },
              ),
              trailing: InkWell(
                child: Icon(
                  Icons.clear,
                ),
                onTap: () {
                  _editingController.clear();
                  for (int i = 0; i < controller.fruitsList.value.length; i++) {
                    controller.showOrNot.value[i].value = true;
                  }
                },
              ),
            ),
          ),
          //for select all
          Container(
            child: ListTile(
              title: Text(
                'Select All',
                style: TextStyle(color: Colors.blue),
              ),
              leading: Obx(() => Checkbox(
                  value: controller.allSelected.value,
                  onChanged: (state) {
                    controller.allSelected.value = state!;
                    for (int i = 0;
                        i < controller.fruitsList.value.length;
                        i++) {
                      controller.checkStatusList.value[i].value = state;
                    }
                  })),
            ),
          ),
          Expanded(
              child: Obx(() => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.fruitsList.value.length,
                  itemBuilder: (context, index) {
                    return Obx(() => controller.showOrNot.value[index].value
                        ? ListTile(
                            title: Text(controller.fruitsList.value[index]),
                            leading: Checkbox(
                                value: controller
                                    .checkStatusList.value[index].value,
                                onChanged: (bool? state) {
                                  controller
                                          .checkStatusList.value[index].value =
                                      !controller
                                          .checkStatusList.value[index].value;
                                  //finally checking if all selected or not
                                  controller.allSelected.value = allChecked();
                                }),
                          )
                        : SizedBox());
                  })))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          var temp = countChecks();
          Get.to(Result(),
              arguments: [temp, false],
              transition: Transition.rightToLeft,
              duration: Duration(milliseconds: 500));
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }

  bool countChecks() {
    bool temp = false;
    for (int i = 0; i < controller.checkStatusList.value.length; i++) {
      if (controller.checkStatusList.value[i].value) {
        if (!temp) {
          temp = true;
          controller.result.value = '';
        }
        controller.result.value += controller.fruitsList.value[i] + '\n';
      }
    }
    return temp;
  }

  bool allChecked() {
    for (int i = 0; i < controller.fruitsList.value.length; i++) {
      if (controller.showOrNot.value[i].value) {
        if (controller.checkStatusList.value[i].value) {
          continue;
        } else {
          return false;
        }
      }
    }
    return true;
  }

  void searchInFruitsList() {}
}

class Result extends StatefulWidget {
  const Result({Key? key}) : super(key: key);

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Controller controller = Get.find();
  var arg = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cart'),
        ),
        body: Center(
          child: arg[0]
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your Cart',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    Text(
                      controller.result.value,
                      style: TextStyle(color: Colors.black38, fontSize: 16),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Empty',
                      style: TextStyle(color: Colors.red, fontSize: 20),
                    ),
                    Text(
                      'No items selected!',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    )
                  ],
                ),
        ));
  }
}
