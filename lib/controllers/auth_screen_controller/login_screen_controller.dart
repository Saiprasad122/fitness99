import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/needed_utils.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_model.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  final apiService = Get.put(ApiService.create());
  LoginResponse? _loginResponse;
  LoginResponse? get loginResponse => _loginResponse;
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

      // AuthenticationHelper()
      //     .signIn(email: emailTED.value.text, password: passwordTED.value.text)
      //     .then(
      //   (result) async {
      //     if (result == null) {
      //       SharedPreferences preferences =
      //           await SharedPreferences.getInstance();
      //       preferences.setString('email', emailTED.value.text);
      //       print('THe shard pref is ${preferences.getString('email')}');
      //       Get.back();
      //       customSnackBar(
      //         'Login Successfully',
      //         '',
      //         'success',
      //       );
      //       Get.offAllNamed(Routes.DashboardScreen);
      //     } else {
      //       apiCalling.value = false;
      //       customSnackBar(
      //         'Invalid Credentials!',
      //         'The entered values are invalid',
      //         'fail',
      //       );
      //     }
      //   },
      // );
    }
  }

  void forgotPasswordLogin() {
    validateForgotEmail();
    if (validateForgotEmail()) {
      forgotEmailErr.value = '';
      Get.back();
    }
  }

  Future<String> loginApi({email, password}) async {
    // var url = 'http://fitness.rithlaundry.com/api/user/login';
    LoginRequest body = LoginRequest(email: email, password: password);
    final res = await apiService.getLoginResponse(body);

    // final response = await Dio().post(url, data: body);
    // var statusBody = jsonDecode(response.toString());
    // print('The data is ${statusBody['result']}');
    if (res.message.toLowerCase() == 'success') {
      apiCalling.value = false;
      _prefs = Get.find<NeededVariables>().sharedPreferences;
      _prefs!.setString('email', res.result.email);
      String name = res.result.userName;
      String email = res.result.email;
      String mobileNumber =
          res.result.phoneNumber ?? 'Please update your phone number';

      Get.find<UserModelService>().loggedIn(
        name: name,
        mobileNumber: mobileNumber,
        email: email,
        numberOfGroups: '0',
      );

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
    apiCalling.value = false;
    return '';
  }
}
