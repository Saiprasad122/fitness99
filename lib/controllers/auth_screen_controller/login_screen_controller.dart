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
  final emailTED = TextEditingController();
  final passwordTED = TextEditingController();
  final forgotemailTED = TextEditingController();
  final emailErr = ''.obs;
  final passwordErr = ''.obs;
  final apiCalling = false.obs;
  final forgotEmailErr = ''.obs;
  final image = ''.obs;

  bool validateEmail() {
    if (emailTED.value.text.trim().isEmpty) {
      emailErr.value = 'Enter email address';
      return false;
    } else if (!GetUtils.isEmail(emailTED.value.text.trim())) {
      emailErr.value = 'Enter valid email address';
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

  bool validateForgotEmail() {
    if (forgotemailTED.value.text.isEmpty) {
      forgotEmailErr.value = 'Enter Email Address';
      return false;
    } else if (!GetUtils.isEmail(forgotemailTED.value.text)) {
      forgotEmailErr.value = 'Enter valid Email Address';
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
        email: emailTED.value.text.trim(),
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

  Future<void> loginApi(
      {required String email, required String password}) async {
    try {
      LoginRequest body = LoginRequest(email: email, password: password);
      final res = await apiService.getLoginResponse(body);

      if (res.message!.toLowerCase() == 'success' && res.data != null) {
        apiCalling.value = false;
        _prefs = Get.find<NeededVariables>().sharedPreferences;
        _prefs!.setString('email', res.data!.user.email);

        int id = res.data!.user.id;
        String name = res.data!.user.user_name;
        String email = res.data!.user.email;
        String? mobileNumber =
            res.data!.user.number ?? 'Please update your mobile number';
        String profilePicture = res.data!.user.profile_picture ?? 'N/A';
        int groupCount = res.data!.user.group_count;
        int pendingInvitation = res.data!.pending_invitation;

        //adding userData to local database
        Get.find<UserModelService>().loggedIn(
          id: id,
          name: name,
          mobileNumber: mobileNumber,
          email: email,
          numberOfGroups: groupCount,
          profilePicture: profilePicture,
          pendingInvitaion: pendingInvitation,
        );
        //

        Get.offAllNamed(Routes.DashboardScreen);
        customSnackBar(
          title: 'Logged In!',
          message: 'Logged In Successfully',
          isSuccess: true,
        );
      } else {
        apiCalling.value = false;
        customSnackBar(
          title: 'Invalid Credentials!',
          message: 'The entered values are invalid',
          isSuccess: false,
        );
      }
      apiCalling.value = false;
    } on DioError catch (e) {
      print(e);
      customSnackBar(
        title: 'Invalid Credentials!',
        message: 'The entered values are invalid',
        isSuccess: false,
      );
      apiCalling.value = false;
    }
  }
}
