import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final nameTED = TextEditingController();
  final emailTED = TextEditingController();
  final numberTED = TextEditingController();
  final nameErr = ''.obs;
  final emailErr = ''.obs;
  final numberErr = ''.obs;

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

  bool validateName() {
    if (nameTED.value.text.isEmpty) {
      nameErr.value = 'Enter user name';
      return false;
    } else {
      return true;
    }
  }

  bool validateNumber() {
    if (numberTED.value.text.isEmpty) {
      numberErr.value = 'Enter mobile number';
      return false;
    } else if (!numberTED.value.text.isPhoneNumber) {
      numberErr.value = 'Enter valid mobile number';
      return false;
    } else {
      return true;
    }
  }

  void submit() {
    validateEmail();
    validateName();
    validateNumber();
    if (validateEmail() && validateName() && validateNumber()) {
      print('hey');
      Get.back();
      customSnackBar(
        'Success!',
        'Your profile is created successfully',
        'success',
      );
    }
  }
}
