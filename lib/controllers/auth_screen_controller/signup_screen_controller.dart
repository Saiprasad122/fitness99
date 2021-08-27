import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/helpers/auth.helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreenController extends GetxController {
  final emailTED = TextEditingController();
  final passwordTED = TextEditingController();
  final nameTED = TextEditingController();
  final form = GlobalKey<FormState>();
  final nameErr = ''.obs;
  final emailErr = ''.obs;
  final passwordErr = ''.obs;
  final apiCalling = false.obs;

  bool validateName() {
    if (nameTED.value.text.isEmpty) {
      nameErr.value = 'Enter user name';
      return false;
    } else {
      return true;
    }
  }

  bool validateEmail() {
    if (emailTED.value.text.isEmpty) {
      emailErr.value = 'Enter email address';
      return false;
    } else if (!GetUtils.isEmail(emailTED.value.text)) {
      emailErr.value = 'Enter valid email address';
      return false;
    } else {
      return true;
    }
  }

  bool validatePassword() {
    if (passwordTED.value.text.isEmpty) {
      passwordErr.value = 'Enter password';
      return false;
    } else {
      return true;
    }
  }

  void signup() {
    validateEmail();
    validateName();
    validatePassword();
    if (validateName() && validateEmail() && validatePassword()) {
      apiCalling.value = true;

      // if (_form.currentState?.validate() ?? false) {
      //   setState(() {
      //     _apiCalling = true;
      //   });
      AuthenticationHelper()
          .signUp(email: emailTED.text, password: passwordTED.text)
          .then((result) {
        if (result == null) {
          Get.back();
          customSnackBar('Account created successfully!', '', 'success');
          Get.offNamed(Routes.DashboardScreen);
        } else {
          apiCalling.value = false;
          // ScaffoldMessenger.of(context).clearSnackBars();
          customSnackBar(
              'Try again!', 'There is some error please try again', 'fail');
        }
      });
    }
  }
}
