import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:flutter/material.dart';

class SplashScreenView extends StatelessWidget {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //initializing the app fonts, sizes, textstyles, etc configs
    AppFontSizeConfigs().init(context);

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
