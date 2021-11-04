import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/needed_utils.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final apiService = Get.find<ApiService>();
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;
  // DocumentSnapshot? documentSnapshot;
  final emailTED = TextEditingController();
  final passwordTED = TextEditingController();
  final forgotemailTED = TextEditingController();
  final emailErr = ''.obs;
  final passwordErr = ''.obs;
  final apiCalling = false.obs;
  final forgotEmailErr = ''.obs;
  final image = ''.obs;

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

  bool validateForgotEmail() {
    if (forgotemailTED.value.text.isEmpty) {
      forgotEmailErr.value = 'Enter email address';
      return false;
    } else if (!GetUtils.isEmail(forgotemailTED.value.text)) {
      forgotEmailErr.value = 'Enter valid email address';
      return false;
    } else {
      return true;
    }
  }

  void loginDio() async {
    apiCalling.value = true;
    try {} on DioError catch (e) {
      print(e);
    }
  }

  void login() async {
    validateEmail();
    validatePassword();

    if (validateEmail() && validateEmail()) {
      apiCalling.value = true;
      await loginApi(
        email: emailTED.value.text,
        password: passwordTED.value.text,
      );
    }
  }

  void forgotPasswordLogin() {
    validateForgotEmail();
    if (validateForgotEmail()) {
      forgotEmailErr.value = '';
      Get.back();
    }
  }

  Future<void> loginApi({email, password}) async {
    try {
      LoginRequest body = LoginRequest(email: email, password: password);
      final res = await apiService.getLoginResponse(body);

      if (res.status.toLowerCase() == 'success') {
        apiCalling.value = false;
        _prefs = Get.find<NeededVariables>().sharedPreferences;
        _prefs!.setString('email', res.user.email);

        int id = res.user.id;
        String name = res.user.userName;
        String email = res.user.email;
        String? mobileNumber =
            res.user.number ?? 'Please update your mobile number';
        String profilePicture = res.user.profilePicture ?? 'N/A';
        int groupCount = res.user.groupCount;
        //     .contains('http://fitness.rithlaundry.com/uploads')
        // ? res.result!.profilePicture
        // : 'http://fitness.rithlaundry.com/uploads/${res.result?.profilePicture ?? 'images/avatar.png'}';
        Get.find<UserModelService>().loggedIn(
          id: id,
          name: name,
          mobileNumber: mobileNumber,
          email: email,
          numberOfGroups: groupCount,
          profilePicture: profilePicture,
        );

        Get.offAllNamed(Routes.DashboardScreen);
        final userModel = Get.find<UserModelService>();
        print('The profile pic is ${userModel.getid()}');
        customSnackBar(
          'Logged In!',
          'Logged In Successfully',
          'success',
        );
      } else {
        apiCalling.value = false;
        customSnackBar(
          'Invalid Credentials!',
          'The entered values are invalid',
          'fail',
        );
      }
      apiCalling.value = false;
    } on DioError catch (e) {
      print(e);
      customSnackBar(
        'Invalid Credentials!',
        'The entered values are invalid',
        'fail',
      );
      apiCalling.value = false;

      print('error');
    }
  }
}
