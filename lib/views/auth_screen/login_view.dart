// import 'package:fitness_99_project/helpers/auth.helper.dart';
// import 'package:fitness_99_project/screens/auth/auth.export.dart';
// import 'package:fitness_99_project/screens/screens.export.dart';
// import 'package:fitness_99_project/utils.dart';
import 'package:fitness_99/controllers/login_screen_controller.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_detail_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreenView extends StatelessWidget {
  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/onboard_img/fitness_signup_bg.png',
            fit: BoxFit.fill,
            filterQuality: FilterQuality.high,
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            child: Center(
              child: Form(
                key: controller.form,
                child: Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50 *
                            AppSizedBoxConfigs.responsiveHeightValueToDivide,
                      ),
                      Text('Welcome Back,',
                          style: TextStyles.sgproRegular.f20.white),
                      SizedBox(
                        height: 20 *
                            AppSizedBoxConfigs.responsiveHeightValueToDivide,
                      ),
                      Text('LOG IN', style: TextStyles.sgproMedium.f36.white),
                      const Spacer(),
                      CustomDetailsTextField(
                        displayText: 'Email Address',
                        hintText: 'john@gmail.com',
                        iconData: Icons.email,
                        textEditingController: controller.emailTED,
                        textInputType: TextInputType.emailAddress,
                        errText: controller.emailErr.value,
                      ),
                      SizedBox(
                        height: 20 *
                            AppSizedBoxConfigs.responsiveHeightValueToDivide,
                      ),
                      CustomDetailsTextField(
                        displayText: 'Password',
                        iconData: Icons.password_rounded,
                        hintText: '********',
                        textEditingController: controller.passwordTED,
                        isObscureText: true,
                        obscuringText: '*',
                        errText: controller.passwordErr.value,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: Text(
                          'Forgot Password?',
                          style: TextStyles.sgproRegular.f18.greyLight,
                          textAlign: TextAlign.end,
                        ),
                      ),
                      SizedBox(
                        height: 50 *
                            AppSizedBoxConfigs.responsiveHeightValueToDivide,
                      ),
                      InkWell(
                        onTap: controller.login,
                        child: Container(
                          height: 45 *
                              AppSizedBoxConfigs.responsiveHeightValueToDivide,
                          width: double.infinity,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: Colors.yellow[700],
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Text(
                            'LOGIN NOW',
                            style: TextStyles.sgproMedium.f20.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30 *
                            AppSizedBoxConfigs.responsiveHeightValueToDivide,
                      ),
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
                                .copyWith(color: Colors.blue),
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
          ),
          if (controller.apiCalling)
            Positioned.fill(
                child: SizedBox.expand(
              child: Container(
                color: Colors.black45,
                child: Center(
                  child: SizedBox(
                    height:
                        60 * AppSizedBoxConfigs.responsiveHeightValueToDivide,
                    width: AppSizedBoxConfigs.screenWidth * 0.15,
                    child: CircularProgressIndicator(),
                  ),
                ),
              ),
            ))
        ],
      ),
    );
  }
}
