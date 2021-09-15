import 'package:fitness_99/controllers/auth_screen_controller/login_screen_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_button.dart';
import 'package:fitness_99/global/widgets/custom_detail_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ForgotPasswordScreeen extends StatelessWidget {
  final controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/onboard_img/fitness_signup_bg.png',
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 25),
                Text(
                  'FORGOT PASSWORD',
                  style: TextStyles.sgproMedium.f26.white,
                ),
              ],
            ),
          ),
          Container(
            constraints:
                BoxConstraints(maxHeight: AppSizedBoxConfigs.screenHeight),
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    'assets/svgs/auth_screen/lock.svg',
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'We just need your registered E-Mail Address to send you a reset code',
                    style: TextStyles.sgproRegular.f16,
                  ),
                  const SizedBox(height: 20),
                  Obx(
                    () => CustomDetailsTextField(
                      displayText: 'Email',
                      hintText: 'john@gmail.com',
                      iconData: Icons.email,
                      textEditingController: controller.forgotemailTED,
                      errText: controller.forgotEmailErr.value,
                      textInputType: TextInputType.emailAddress,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: 'SEND OTP',
                    onTap: controller.forgotPasswordLogin,
                    color: Colors.amber[700],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
