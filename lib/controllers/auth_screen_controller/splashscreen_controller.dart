import 'dart:async';

import 'package:fitness_99/global/router/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewController extends GetxController {
  @override
  void onInit() {
    Timer(Duration(seconds: 2), () async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      print('THe shard pref is ${preferences.getString('email')}');
      if (preferences.getString('email') != null) {
        Get.offNamed(Routes.DashboardScreen);
      } else {
        Get.back();
        Get.put(Routes.OnBoardScreen);
      }
    });
    super.onInit();
  }
}
