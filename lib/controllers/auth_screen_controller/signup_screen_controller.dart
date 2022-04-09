import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/signUpResponseRequest/sign_up_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreenController extends GetxController {
  final apiService = Get.find<ApiService>();
  final emailTED = TextEditingController();
  final passwordTED = TextEditingController();
  final nameTED = TextEditingController();
  final form = GlobalKey<FormState>();
  final nameErr = ''.obs;
  final emailErr = ''.obs;
  final passwordErr = ''.obs;
  final apiCalling = false.obs;

  bool validateName() {
<<<<<<< HEAD
    if (nameTED.value.text.trim().isEmpty) {
      nameErr.value = 'Enter user name';
=======
    if (nameTED.value.text.isEmpty) {
      nameErr.value = 'Enter Username';
>>>>>>> 698d9f8c256141699d62db6624ae30208c4fda72
      return false;
    } else {
      return true;
    }
  }

  bool validateEmail() {
<<<<<<< HEAD
    if (emailTED.value.text.trim().isEmpty) {
      emailErr.value = 'Enter email address';
      return false;
    } else if (!GetUtils.isEmail(emailTED.value.text.trim())) {
      emailErr.value = 'Enter valid email address';
=======
    if (emailTED.value.text.isEmpty) {
      emailErr.value = 'Enter Email Address';
      return false;
    } else if (!GetUtils.isEmail(emailTED.value.text)) {
      emailErr.value = 'Enter valid Email Address';
>>>>>>> 698d9f8c256141699d62db6624ae30208c4fda72
      return false;
    } else {
      return true;
    }
  }

  bool validatePassword() {
    if (passwordTED.value.text.isEmpty) {
      passwordErr.value = 'Enter Password';
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
      signUpApi(
        userName: nameTED.value.text.trim(),
        email: emailTED.value.text.trim(),
        password: passwordTED.value.text,
      );
    }
  }

  Future<void> signUpApi({
    required String userName,
    required String email,
    required String password,
  }) async {
    SignUpRequest body = SignUpRequest(
      email: email,
      password: password,
      userName: userName,
    );
    final res = await apiService.getSignUpResponse(body);
    if (res.message.toLowerCase() == 'success') {
      apiCalling.value = false;
      Get.offNamed(Routes.LoginScreen);
      customSnackBar(
        title: 'Account Created!',
        message: 'Account has been successfully created',
        isSuccess: true,
      );
    } else if (res.message.toLowerCase() ==
        "the email has already been taken.") {
      apiCalling.value = false;
      customSnackBar(
        title: 'Email already exists!',
        message: 'The email has already been taken.',
        isSuccess: false,
      );
    } else {
      apiCalling.value = false;
      customSnackBar(
        title: 'Something went Wrong!',
        message: 'Please try again.',
        isSuccess: false,
      );
    }
  }
}
