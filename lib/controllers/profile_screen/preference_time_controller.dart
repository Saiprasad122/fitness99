import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreferenceTimeController extends GetxController {
  Rx<String> fromTime = ''.obs;
  Rx<String> toTime = ''.obs;
  final currentTime = TimeOfDay.now();
  final selectedDay = 'Sunday'.obs;
  final dropdownValue = 'Sunday'.obs;
  final days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  void onChangeDropdownValue(String val) {
    dropdownValue.value = val;
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
}
