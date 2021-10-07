import 'dart:async';

import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:get/get.dart';

class SplashViewController extends GetxController {
  final userModel = Get.find<UserModelService>();
  @override
  void onInit() {
    Timer(
      Duration(seconds: 2),
      () async {
        if (userModel.getEmail() != "N/A") {
          print('THe shared pref is ${userModel.getEmail()}');
          Get.offNamed(Routes.DashboardScreen);
        } else {
          Get.offNamed(Routes.OnBoardScreen);
        }
      },
    );
    super.onInit();
  }
}
