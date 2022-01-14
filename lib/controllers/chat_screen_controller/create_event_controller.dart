import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateEventController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final isBusy = false.obs;
  final titleTED = TextEditingController();
  final descriptionTED = TextEditingController();
  final locationTED = TextEditingController();
  final titleErrText = ''.obs;
  final descriptionErrText = ''.obs;
  final locationErrText = ''.obs;
  final selectDateTimeErrText = ''.obs;
  final selectedDate = ''.obs;
  final selectedTime = ''.obs;
  final currentTime = TimeOfDay.now();
  final days = [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ];

  Future<void> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (picked != null) {
      selectedTime.value = picked.format(context);
    }
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2090),
    );
    if (picked != null) {
      selectedDate.value = DateFormat('dd/MM/yyyy').format(picked);
      selectTime(context);
    }
  }

  bool validateTitle() {
    if (titleTED.text.isEmpty) {
      titleErrText.value = 'Enter Title';
      return false;
    } else {
      return true;
    }
  }

  bool validateDescription() {
    if (descriptionTED.text.isEmpty) {
      descriptionErrText.value = 'Enter Description';
      return false;
    } else {
      return true;
    }
  }

  bool validateLocation() {
    if (locationTED.text.isEmpty) {
      locationErrText.value = 'Enter Location';
      return false;
    } else {
      return true;
    }
  }

  bool validateDateTime() {
    if (selectedDate.value.isEmpty && selectedTime.value.isEmpty) {
      selectDateTimeErrText.value = 'Select Date and Time';
      return false;
    } else if (selectedDate.value.isNotEmpty && selectedTime.value.isEmpty) {
      selectDateTimeErrText.value = 'Select Time';
      return false;
    } else {
      return true;
    }
  }

  void createEvent() {
    validateTitle();
    validateDescription();
    validateLocation();
    validateDateTime();
    if (validateTitle() &&
        validateDescription() &&
        validateLocation() &&
        validateDateTime()) {
      titleErrText.value = '';
      descriptionErrText.value = '';
      locationErrText.value = '';
      selectDateTimeErrText.value = '';
    }
  }
}
