import 'package:fitness_99/controllers/auth_screen_controller/splashscreen_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(SplashViewController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset(
          'assets/images/onboard_img/fflogo.png',
          filterQuality: FilterQuality.high,
          width: AppSizedBoxConfigs.screenWidth - 70,
        ),
      ),
    );
  }
}
