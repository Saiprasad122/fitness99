// import 'package:fitness_99_project/screens/auth/auth.export.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
                const SizedBox(height: 25),
                Text(
                  'Welcome Back,',
                  style: TextStyles.sgproMedium.f22.white,
                ),
                const SizedBox(height: 5),
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
                  const SizedBox(height: 60),
                  Image.asset(
                    'assets/images/onboard_img/fflogo.png',
                    filterQuality: FilterQuality.high,
                    height:
                        150 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                    width: AppSizedBoxConfigs.screenWidth * 0.5,
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'Sign up',
                    style: TextStyles.sgproMedium.f26,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'its easier to sign up',
                    style: TextStyles.sgproLight.f16.greyMid
                        .copyWith(letterSpacing: 1),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'EXISTING',
                    onTap: () => Get.toNamed(Routes.LoginScreen),
                    color: AppColors.secondaryColor,
                  ),
                  const SizedBox(height: 35),
                  Container(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => Get.toNamed(Routes.SignupScreen),
                      child: Text(
                        'NEW',
                        style: TextStyles.sgproMedium.f20.greyMid,
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: Colors.grey[100],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
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
