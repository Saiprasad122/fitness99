import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreferenceTimeController extends GetxController {
  final fromTime = ''.obs;
  final toTime = ''.obs;
  final fromTimeErrText = ''.obs;
  final toTimeErrText = ''.obs;
  final currentTime = TimeOfDay.now();
  final selectedDay = 'Select a Day'.obs;
  final selectDayColor = Colors.black.obs;
  final days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  bool validateSelectDay() {
    if (selectedDay.value == 'Select a Day') {
      selectDayColor.value = AppColors.error;
      return false;
    } else {
      return true;
    }
  }

  bool validateFromTime() {
    if (fromTime.value.isEmpty) {
      fromTimeErrText.value = 'Select from Time';
      return false;
    } else {
      return true;
    }
  }

  bool validateToTime() {
    if (toTime.value.isEmpty) {
      toTimeErrText.value = 'Select to Time';
      return false;
    } else {
      return true;
    }
  }

  void fromTimePicked(BuildContext context) async {
    fromTime.value = await selectTime(context);
  }

  void toTimePicked(BuildContext context) async {
    toTime.value = await selectTime(context);
  }

  Future<String> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (picked != null) {
      return picked.format(context);
    }
    return '';
  }

  void addPreference() {
    validateSelectDay();
    validateFromTime();
    validateToTime();
    if (validateSelectDay() && validateFromTime() && validateToTime()) {
      selectDayColor.value = Colors.black;
      fromTimeErrText.value = '';
      toTimeErrText.value = '';
      Get.back();
    }
  }
}
