import 'dart:async';

import 'package:get/get.dart';

class SplashViewController extends GetxController {
  @override
  void onInit() {
    Timer(Duration(seconds: 5), () {
      Get.back();
      Get.put('/onBoardScreen');
    });
    super.onInit();
  }
}
