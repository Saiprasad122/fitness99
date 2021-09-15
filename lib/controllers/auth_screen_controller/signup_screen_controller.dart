import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:fitness_99/core/services/needed_utils.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreenController extends GetxController {
  final emailTED = TextEditingController();
  final passwordTED = TextEditingController();
  final nameTED = TextEditingController();
  final form = GlobalKey<FormState>();
  final nameErr = ''.obs;
  final emailErr = ''.obs;
  final passwordErr = ''.obs;
  final apiCalling = false.obs;
  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;

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
      // AuthenticationHelper()
      //     .signUp(email: emailTED.text, password: passwordTED.text)
      //     .then(
      //   (result) {
      //     if (result == null) {
      //       Get.back();
      //       customSnackBar('Account created successfully!', '', 'success');
      //       Get.offAllNamed(Routes.DashboardScreen);
      //     } else {
      //       apiCalling.value = false;
      //       customSnackBar(
      //         'Try again!',
      //         'There is some error please try again',
      //         'fail',
      //       );
      //     }
      //   },
      // );
    }
  }

  Future<String> signUpApi({userName, email, password}) async {
    // var uri = Uri.parse('http://fitness.rithlaundry.com/api/user/login');
    Map body = {
      "user_name": userName,
      "email": email,
      "password": password,
    };
    final response = await Dio()
        .post('http://fitness.rithlaundry.com/api/user/register', data: body);
    var statusBody = jsonDecode(response.toString());
    print('The data is ${statusBody['result']}');
    if (statusBody['message'] == 'Registered Successfully') {
      apiCalling.value = false;

      _prefs = Get.find<NeededVariables>().sharedPreferences;
      _prefs!.setString('email', statusBody['result']['email']);

      String name = statusBody['result']['user_name'];
      String mobileNumber = statusBody['result']['phone_number'] ??
          'Please update your phone number';
      String email = statusBody['result']['email'];

      // preferences.setString('user_name', statusBody['result']['user_name']);
      // preferences.setString(
      //     'mobile_number', statusBody['result']['phone_number'] ?? 'null');
      // preferences.setString(
      //     'moibile_num', statusBody['result']['phone_number']);
      Get.find<UserModelService>().loggedIn(
        name: name,
        mobileNumber: mobileNumber,
        email: email,
        numberOfGroups: '0',
      );
      print('THe shard pref is ${_prefs!.getString('email')}');
      Get.back();
      Get.offAllNamed(Routes.DashboardScreen);
    } else {
      apiCalling.value = false;
      customSnackBar(
        'Invalid Credentials!',
        'The entered values are invalid',
        'fail',
      );
    }
    print('The status code is ${response.statusCode}');
    print('The data is ${statusBody['result']['user_name']}');
    apiCalling.value = false;
    return '';
  }
}
