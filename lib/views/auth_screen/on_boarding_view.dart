// import 'package:fitness_99_project/screens/auth/auth.export.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/onboard_img/fitness_signup_bg.png',
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                    height:
                        30 * AppSizedBoxConfigs.responsiveHeightValueToDivide),
                Text(
                  'Welcome Back,',
                  style: TextStyles.sgproMedium.f20.white,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text('99 FITNESS\nFRIENDS',
                    style: TextStyles.sgproMedium.f42.white),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/onboard_img/fflogo.png',
                    filterQuality: FilterQuality.high,
                    height:
                        150 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                    width: AppSizedBoxConfigs.screenWidth * 0.5,
                  ),
                  Text(
                    'Sign up',
                    style: TextStyles.sgproMedium.f26,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'its easier to sign up',
                    style: TextStyles.sgproLight.f16.greyLight
                        .copyWith(letterSpacing: 1),
                  ),
                  SizedBox(
                    height:
                        30 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.LoginScreen);
                    },
                    child: Container(
                      height:
                          45 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.yellow[700],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Text('EXISTING',
                          style: TextStyles.sgproMedium.f20.white),
                    ),
                  ),
                  SizedBox(
                    height:
                        30 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                  ),
                  InkWell(
                    onTap: () {
                      Get.toNamed(Routes.SignupScreen);
                    },
                    child: Container(
                      height:
                          45 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey)),
                      child: Text('New', style: TextStyles.sgproMedium.greyMid),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
