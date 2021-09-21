import 'package:fitness_99/controllers/auth_screen_controller/signup_screen_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_button.dart';
import 'package:fitness_99/global/widgets/custom_detail_textfield.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nil/nil.dart';

class SignUpScreenView extends StatelessWidget {
  final controller = Get.put(SignUpScreenController());

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
                backgroundColor: Colors.white,
                resizeToAvoidBottomInset: false,
                body: Image.asset(
                  'assets/images/onboard_img/fitness_signup_bg.png',
                  fit: BoxFit.fill,
                  filterQuality: FilterQuality.high,
                ),
              ),
              Scaffold(
                backgroundColor: Colors.transparent,
                resizeToAvoidBottomInset: false,
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
                        const SizedBox(height: 45),
                        Text('Hello,',
                            style: TextStyles.sgproRegular.f24.white),
                        const SizedBox(height: 18),
                        Text(
                          'SIGN UP',
                          style: TextStyles.sgproBold.f42.white,
                        ),
                        const SizedBox(height: 20),
                        const Spacer(),
                        CustomDetailsTextField(
                          displayText: 'User Name',
                          iconData: Icons.person,
                          hintText: 'john',
                          textInputType: TextInputType.name,
                          errText: controller.nameErr.value,
                          textEditingController: controller.nameTED,
                        ),
                        const SizedBox(height: 10),
                        CustomDetailsTextField(
                          displayText: 'Email Adress',
                          iconData: Icons.email,
                          hintText: 'john@gmail.com',
                          textInputType: TextInputType.emailAddress,
                          errText: controller.emailErr.value,
                          textEditingController: controller.emailTED,
                        ),
                        const SizedBox(height: 10),
                        CustomDetailsTextField(
                          displayText: 'Password',
                          iconData: Icons.vpn_key_sharp,
                          hintText: '*******',
                          isObscureText: true,
                          errText: controller.passwordErr.value,
                          textEditingController: controller.passwordTED,
                        ),
                        const SizedBox(height: 35),
                        CustomButton(
                          text: 'SUBMIT',
                          onTap: controller.signup,
                          color: AppColors.secondaryColor,
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
