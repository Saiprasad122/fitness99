import 'package:fitness_99/controllers/auth_screen_controller/login_screen_controller.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_button.dart';
import 'package:fitness_99/global/widgets/custom_detail_textfield.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';

class LoginScreenView extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          constraints:
              BoxConstraints(maxHeight: AppSizedBoxConfigs.screenHeight),
          child: Stack(
            children: [
              Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.white,
                body: Image.asset(
                  'assets/images/onboard_img/fitness_signup_bg.png',
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  constraints: BoxConstraints(
                      maxHeight: AppSizedBoxConfigs.screenHeight),
                  child: Obx(
                    () => Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 50),
                        Text('Welcome Back,',
                            style: TextStyles.sgproRegular.f22.white),
                        const SizedBox(height: 20),
                        Text('LOG IN', style: TextStyles.sgproMedium.f42.white),
                        const Spacer(),
                        const SizedBox(height: 20),
                        CustomDetailsTextField(
                          displayText: 'Email Address',
                          hintText: 'john@gmail.com',
                          iconData: Icons.email,
                          textEditingController: controller.emailTED,
                          textInputType: TextInputType.emailAddress,
                          errText: controller.emailErr.value,
                        ),
                        const SizedBox(height: 15),
                        CustomDetailsTextField(
                          displayText: 'Password',
                          iconData: Icons.password_rounded,
                          hintText: '********',
                          textEditingController: controller.passwordTED,
                          isObscureText: true,
                          obscuringText: '*',
                          errText: controller.passwordErr.value,
                        ),
                        const SizedBox(height: 10),
                        GestureDetector(
                          onTap: () =>
                              Get.toNamed(Routes.ForgotPasswordScreeen),
                          child: Container(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'Forgot Password?',
                              style: TextStyles.sgproRegular.f18.greyLight,
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        const SizedBox(height: 42),
                        CustomButton(
                          text: 'LOGIN NOW',
                          onTap: controller.login,
                          color: AppColors.secondaryColor,
                        ),
                        const SizedBox(height: 25),
                        InkWell(
                          onTap: () {
                            Get.toNamed(Routes.SignupScreen);
                          },
                          child: Container(
                            width: double.infinity,
                            alignment: Alignment.center,
                            child: Text(
                              'Sign up for a new account ?',
                              style: TextStyles.sgproRegular.f20
                                  .copyWith(color: AppColors.customBlue),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ),
                        const Spacer()
                      ],
                    ),
                  ),
                ),
              ),
              Obx(
                () => controller.apiCalling.value
                    ? CustomProgressIndicator()
                    : nil,
              )
            ],
          ),
        ),
      ),
    );
  }
}
