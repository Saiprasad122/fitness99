import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/change_password_req_response/change_password_request.dart';
import 'package:flutter/cupertino.dart';

class ChangePasswordController extends GetxController {
  final isBusy = false.obs;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final passwordTED = TextEditingController();
  final newPasswordTED = TextEditingController();
  final retypeNewPasswordTED = TextEditingController();
  final passwordErrTxt = ''.obs;
  final newPasswordErrTxt = ''.obs;
  final retypeNewPasswordErrTxt = ''.obs;
  final isPasswordVisible = true.obs;
  final isNewPasswordVisible = true.obs;
  final isRetypeNewPasswordVisible = true.obs;

  bool validatePassoword() {
    if (passwordTED.value.text.isEmpty) {
      passwordErrTxt.value = 'Enter the Old Password';
      return false;
    } else {
      passwordErrTxt.value = '';
      return true;
    }
  }

  bool validateNewPassoword() {
    if (newPasswordTED.value.text.isEmpty) {
      newPasswordErrTxt.value = 'Enter the New Password';
      return false;
    } else if (newPasswordTED.text.isNotEmpty &&
        newPasswordTED.text == passwordTED.text) {
      newPasswordErrTxt.value = 'Old Password and New Password can\'t be same';
      passwordErrTxt.value = 'Old Password and New Password can\'t be same';

      return false;
    } else {
      newPasswordErrTxt.value = '';
      return true;
    }
  }

  bool validateRetypeNewPassoword() {
    if (retypeNewPasswordTED.value.text.isEmpty) {
      retypeNewPasswordErrTxt.value = 'Reype the New assword';
      return false;
    } else if (retypeNewPasswordTED.value.text.isNotEmpty &&
        newPasswordTED.text != retypeNewPasswordTED.text) {
      newPasswordErrTxt.value = 'Both Passwords are not matching';
      retypeNewPasswordErrTxt.value = 'Both Passwords are not matching';
      return false;
    } else {
      retypeNewPasswordErrTxt.value = '';
      return true;
    }
  }

  void updatePassword() async {
    validatePassoword();
    validateNewPassoword();
    validateRetypeNewPassoword();
    if (validatePassoword() &&
        validateNewPassoword() &&
        validateRetypeNewPassoword()) {
      isBusy.value = true;
      try {
        final body = ChangePasswordRequest(
          user_id: userModel.getid().toString(),
          password: passwordTED.value.text,
          new_password: newPasswordTED.value.text,
        );

        final response = await apiService.changePassword(body);
        if (response.message?.toLowerCase().contains('success') ?? false) {
          Get.back();
          customSnackBar(
            title: 'Success!',
            message: 'Your Password is successfully updated',
            isSuccess: true,
          );
        } else {
          customSnackBar(
            title: 'Error!',
            message:
                'Some error while updating profile picture please try again',
            isSuccess: false,
          );
        }
      } on DioError catch (e) {
        print(e);
        if (e.response!.statusCode == 404 &&
            e.response!.data['message']
                .toString()
                .toLowerCase()
                .contains('password not match')) {
          customSnackBar(
            title: 'Incorrect Password!',
            message: 'Entered password is incorrect!',
            isSuccess: false,
          );
        } else {
          customSnackBar(
            title: 'Error!',
            message:
                'Some error while updating profile picture please try again',
            isSuccess: false,
          );
        }
      }
      isBusy.value = false;
    }
  }
}
