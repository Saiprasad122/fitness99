import 'package:dio/dio.dart';
import 'package:fitness_99/controllers/chat_screen_controller/display_activity_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/createActivityRequestResponse/create_activity_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateActivityController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final titleTED = TextEditingController();
  final descriptionTED = TextEditingController();
  final locationTED = TextEditingController();
  final notesTED = TextEditingController();
  final titleErrText = ''.obs;
  final descriptionErrText = ''.obs;
  final locationErrText = ''.obs;
  final notesErrText = ''.obs;
  final selectDayErrText = ''.obs;
  final fromTimeErrText = ''.obs;
  final toTimeErrText = ''.obs;
  final isBusy = false.obs;
  final selectedDay = 'Select Day'.obs;
  final dropdownValue = 'Select Day'.obs;
  Rx<String> fromTime = '--:--'.obs;
  Rx<String> toTime = '--:--'.obs;
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

  bool validateTitle() {
    if (titleTED.value.text.isEmpty) {
      titleErrText.value = 'Enter Title';
      return false;
    } else {
      return true;
    }
  }

  bool validateDescription() {
    if (descriptionTED.value.text.isEmpty) {
      descriptionErrText.value = 'Enter Description';
      return false;
    } else {
      return true;
    }
  }

  bool validateLocation() {
    if (locationTED.value.text.isEmpty) {
      locationErrText.value = 'Enter Location';
      return false;
    } else {
      return true;
    }
  }

  bool validateNotes() {
    if (notesTED.value.text.isEmpty) {
      notesErrText.value = 'Enter Notes';
      return false;
    } else {
      return true;
    }
  }

  bool validateSelectedDay() {
    if (selectedDay.value.toLowerCase() == 'select day') {
      selectDayErrText.value = 'Select Day';
      print(selectDayErrText.value);
      return false;
    } else {
      return true;
    }
  }

  bool validateFromTime() {
    if (fromTime.value.isEmpty) {
      fromTime.value = 'Select from time';
      print(fromTime.value);
      return false;
    } else {
      return true;
    }
  }

  bool validateToTime() {
    if (toTime.value.isEmpty) {
      toTime.value = 'Select to time';
      print(toTime.value);
      return false;
    } else {
      return true;
    }
  }

  void createActivity(String group_id) async {
    validateTitle();
    validateDescription();
    validateLocation();
    validateNotes();
    validateSelectedDay();
    validateFromTime();
    validateToTime();
    if (validateTitle() &&
        validateDescription() &&
        validateLocation() &&
        validateNotes() &&
        validateSelectedDay() &&
        validateFromTime() &&
        validateToTime()) {
      titleErrText.value = '';
      descriptionErrText.value = '';
      locationErrText.value = '';
      notesErrText.value = '';
      selectDayErrText.value = '';
      fromTimeErrText.value = '';
      toTime.value = '';
      isBusy.value = true;
      await createActivityAPI(
        title: titleTED.text,
        description: descriptionTED.text,
        location: locationTED.text,
        note: notesTED.text,
        day: selectedDay.value,
        fromTime: fromTime.value,
        toTime: toTime.value,
        group_id: group_id,
        user_id: userModel.getid().toString(),
      );
      isBusy.value = false;
    }
  }

  Future<void> createActivityAPI({
    required String title,
    required String description,
    required String location,
    required String note,
    required String day,
    required String fromTime,
    required String toTime,
    required String group_id,
    required String user_id,
  }) async {
    try {
      CreateActivityRequest body = CreateActivityRequest(
        title: title,
        description: description,
        location: location,
        note: note,
        day: day,
        from_time: fromTime,
        to_time: toTime,
        group_id: group_id,
        user_id: user_id,
      );

      final response = await apiService.createActivityResponse(body);

      if (response.message?.toLowerCase().contains('success') ?? false) {
        Get.back();
        final diplayActivityController = Get.put<DisplayActivityController>(
            DisplayActivityController(group_id: int.parse(group_id)));

        diplayActivityController.getActivityList(int.parse(group_id));
        customSnackBar(
          title: 'Success',
          message: 'Activity created successfully',
          isSuccess: true,
        );
      } else {
        customSnackBar(
          title: 'Error!',
          message: 'Please try again later',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      print(e);
      customSnackBar(
        title: 'Error!',
        message: 'Please try again later',
        isSuccess: false,
      );
    }
  }
}
