import 'package:fitness_99/controllers/more_screen_controller/change_password_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatelessWidget {
  final controller = Get.put(ChangePasswordController());
  ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Change Password',
          style: TextStyles.sgproBold.f26.black,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      CustomProfileTextField(
                        displayText: 'Old Password',
                        hintText: '********',
                        textInputType: TextInputType.visiblePassword,
                        errText: controller.passwordErrTxt.value,
                        textEditingController: controller.passwordTED,
                        isObscureText: controller.isPasswordVisible.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.isPasswordVisible.value =
                                !(controller.isPasswordVisible.value);
                          },
                          icon: Icon(
                            controller.isPasswordVisible.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomProfileTextField(
                        displayText: 'New Password',
                        hintText: '********',
                        textInputType: TextInputType.visiblePassword,
                        errText: controller.newPasswordErrTxt.value,
                        textEditingController: controller.newPasswordTED,
                        isObscureText: controller.isNewPasswordVisible.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.isNewPasswordVisible.value =
                                !(controller.isNewPasswordVisible.value);
                          },
                          icon: Icon(
                            controller.isNewPasswordVisible.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      CustomProfileTextField(
                        displayText: 'Retype New Password',
                        hintText: '********',
                        textInputType: TextInputType.visiblePassword,
                        errText: controller.retypeNewPasswordErrTxt.value,
                        textEditingController: controller.retypeNewPasswordTED,
                        isObscureText:
                            controller.isRetypeNewPasswordVisible.value,
                        suffixIcon: IconButton(
                          onPressed: () {
                            controller.isRetypeNewPasswordVisible.value =
                                !(controller.isRetypeNewPasswordVisible.value);
                          },
                          icon: Icon(
                            controller.isRetypeNewPasswordVisible.value
                                ? Icons.visibility_off_outlined
                                : Icons.visibility_outlined,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                CustomBottomButton(
                    text: 'Update Password', onTap: controller.updatePassword)
              ],
            ),
            controller.isBusy.value
                ? const CustomProgressIndicator()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
