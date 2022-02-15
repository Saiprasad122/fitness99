import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class GroupLimitController extends GetxController {
  final isBusy = false.obs;
  final commentTED = TextEditingController();
  final commentErrTxt = ''.obs;
  final limitnumTED = TextEditingController();
  final limitNumErrTxt = ''.obs;

  bool validateComment() {
    if (commentTED.text.isEmpty) {
      commentErrTxt.value = 'Enter Comment';
      return false;
    } else {
      return true;
    }
  }

  bool validateLimit() {
    if (limitnumTED.text.isEmpty) {
      limitNumErrTxt.value = 'Enter Title';
      return false;
    } else {
      return true;
    }
  }

  void submitRequest() {
    validateComment();
    validateLimit();
    if (validateComment() && validateLimit()) {
      Get.back();
      commentErrTxt.value = '';
      limitNumErrTxt.value = '';
    }
  }
}
