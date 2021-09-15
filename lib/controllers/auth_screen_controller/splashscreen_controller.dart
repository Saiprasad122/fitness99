import 'dart:async';

import 'package:fitness_99/core/services/needed_utils.dart';
// import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashViewController extends GetxController {
  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;
  @override
  void onInit() {
    Timer(Duration(seconds: 2), () async {
      _prefs = Get.find<NeededVariables>().sharedPreferences;
      if (_prefs!.getString('email') != null) {
        print('THe shard pref is ${_prefs!.getString('email')}');
        // Get.find<UserModelService>().loggedIn(
        //   name: _prefs!.getString('user_name')!,
        //   mobileNumber: _prefs!.getString('mobile_number')!,
        //   email: _prefs!.getString('email')!,
        //   numberOfGroups: '0',
        // );
        Get.offNamed(Routes.DashboardScreen);
      } else {
        Get.offNamed(Routes.OnBoardScreen);
      }
    });
    super.onInit();
  }
}
