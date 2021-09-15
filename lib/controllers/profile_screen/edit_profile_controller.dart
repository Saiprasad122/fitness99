import 'dart:io';

import 'package:fitness_99/core/services/needed_utils.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileController extends GetxController {
  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;
  final nameTED = TextEditingController();
  final emailTED = TextEditingController();
  final numberTED = TextEditingController();
  final nameErr = ''.obs;
  final emailErr = ''.obs;
  final numberErr = ''.obs;
  final numberTextInputFormatter = LengthLimitingTextInputFormatter(10);
  final picker = ImagePicker();
  final img = File('').obs;

  bool validateEmail() {
    if (emailTED.value.text.isEmpty) {
      emailErr.value = 'Enter email address';
      return false;
    } else if (!GetUtils.isEmail(emailTED.value.text)) {
      emailErr.value = 'Enter valid email address';
      return false;
    } else {
      emailErr.value = '';
      return true;
    }
  }

  bool validateName() {
    if (nameTED.value.text.isEmpty) {
      nameErr.value = 'Enter user name';
      return false;
    } else {
      nameErr.value = '';
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
    } else if (!numberTED.value.text.startsWith(RegExp(r'[6-9]'))) {
      numberErr.value = 'Enter a valid mobile number';
      return false;
    } else {
      numberErr.value = '';
      return true;
    }
  }

  Future pickImage() async {
    try {
      final file = await picker.pickImage(source: ImageSource.gallery);
      img.value = File(file!.path);
    } catch (e) {
      print(e);
    }
  }

  void submit() {
    validateEmail();
    validateName();
    validateNumber();
    if (validateEmail() && validateName() && validateNumber()) {
      Get.back();
      customSnackBar(
        'Success!',
        'Your profile is created successfully',
        'success',
      );
    }
  }

  @override
  void onInit() {
    _prefs = Get.find<NeededVariables>().sharedPreferences;
    nameTED.text = _prefs!.getString('user_name')!;
    emailTED.text = _prefs!.getString('email')!;
    numberTED.text = _prefs!.getString('mobile_number')!;

    super.onInit();
  }
}
