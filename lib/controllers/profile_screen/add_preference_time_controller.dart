import 'package:dio/dio.dart';
import 'package:fitness_99/controllers/profile_screen/view_preferences_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/add_preferences_request/add_preferences_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddPreferenceTimeController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final preferenceController = Get.find<PreferenceController>();
  final fromTime = ''.obs;
  final toTime = ''.obs;
  final fromTimeErrText = ''.obs;
  final toTimeErrText = ''.obs;
  final currentTime = TimeOfDay.now();
  final selectedDay = 'Select a Day'.obs;
  final selectDayColor = Colors.black.obs;
  final isBusy = false.obs;
  double ftime = 0.0, ttime = 0.0;
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

  bool validateRightTime(double fromtime, double totime) {
    if (fromtime >= totime) {
      fromTimeErrText.value =
          'Starting time cannot be greater than Ending time';
      toTimeErrText.value = 'Ending time cannot be lesser than Starting time';

      return false;
    } else if (fromtime <= totime) {
      fromTimeErrText.value = '';
      toTimeErrText.value = '';
      return true;
    } else {
      return false;
    }
  }

  void fromTimePicked(BuildContext context) async {
    await selectTime(context).then(
      (value) {
        ftime = value.hour.toDouble() + value.minute.toDouble();
        fromTime.value = value.format(context);
        fromTimeErrText.value = '';
      },
    );
  }

  void toTimePicked(BuildContext context) async {
    if (validateFromTime()) {
      await selectTime(context).then(
        (value) {
          ttime = value.hour.toDouble() + value.minute.toDouble();
          toTime.value = value.format(context);
          toTimeErrText.value = '';
        },
      );
    }
  }

  Future<TimeOfDay> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (picked != null) {
      return picked;
    } else {
      return TimeOfDay.now();
    }
  }

  void addPreference() {
    validateSelectDay();
    validateFromTime();
    validateToTime();
    if (validateFromTime() && validateToTime()) {
      validateRightTime(ftime, ttime);
    }
    if (validateSelectDay() &&
        validateFromTime() &&
        validateToTime() &&
        validateRightTime(ftime, ttime)) {
      selectDayColor.value = Colors.black;
      fromTimeErrText.value = '';
      toTimeErrText.value = '';
      addPreferenceApi();
    }
  }

  void addPreferenceApi() async {
    isBusy.value = true;
    try {
      AddPreferencesRequest body = AddPreferencesRequest(
        day: selectedDay.value,
        user_id: userModel.getid().toString(),
        from_time: fromTime.value,
        to_time: toTime.value,
      );

      final response = await apiService.addPreferences(body);

      if (response.message!.toLowerCase().contains('success') &&
          response.status == 200) {
        preferenceController.getPreference();
        Get.back();
        customSnackBar(
          title: 'Added Preference!',
          message: 'Your Preference added successfully',
          isSuccess: true,
        );
      } else {
        customSnackBar(
          title: 'Something went Wrong!',
          message: 'Please try again.',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      print(e);
      customSnackBar(
        title: 'Something went Wrong!',
        message: 'Please try again.',
        isSuccess: false,
      );
    }
    isBusy.value = false;
  }
}
