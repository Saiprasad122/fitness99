import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/signUpResponseRequest/sign_up_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignUpScreenController extends GetxController {
  final userModel = Get.find<UserModelService>();
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
      signUpApi(
        userName: nameTED.value.text,
        email: emailTED.value.text,
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
        'Account Created!',
        'Account has been successfully created',
        true,
      );
    } else if (res.message.toLowerCase() ==
        "the email has already been taken.") {
      apiCalling.value = false;
      customSnackBar(
        'Email already exists!',
        'The email has already been taken.',
        false,
      );
    } else {
      apiCalling.value = false;
      customSnackBar(
        'Something wrong!',
        'Please try again.',
        false,
      );
    }
  }
}
