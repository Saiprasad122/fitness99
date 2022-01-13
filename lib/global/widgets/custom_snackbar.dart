import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void customSnackBar({
  required String title,
  required String message,
  required bool isSuccess,
}) {
  Get.snackbar(
    '',
    '',
    titleText: Text(
      title,
      style: TextStyles.sgproMedium.f20.white,
    ),
    messageText: Text(
      message,
      style: TextStyles.sgproRegular.f16.white,
    ),
    snackPosition: SnackPosition.BOTTOM,
    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    backgroundColor: isSuccess ? Colors.green : Colors.red,
  );
}
