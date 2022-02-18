import 'package:dio/dio.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/controllers/chat_screen_controller/display_activity_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/createActivityRequestResponse/create_activity_request.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'mssg_type_enum.dart';

class CreateActivityController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final chatScreenController = Get.find<ChatScreenController>();
  final titleTED = TextEditingController();
  final descriptionTED = TextEditingController();
  final locationTED = TextEditingController();
  final notesTED = TextEditingController();
  final titleErrText = ''.obs;
  final descriptionErrText = ''.obs;
  final locationErrText = ''.obs;
  final notesErrText = ''.obs;
  final fromTimeErrText = ''.obs;
  final toTimeErrText = ''.obs;
  final isBusy = false.obs;
  final selectedDay = 'Select Day'.obs;
  final selectDayColor = Colors.black.obs;
  final fromTime = ''.obs;
  final toTime = ''.obs;
  final currentTime = TimeOfDay.now();
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

  void onChangedTitle(String text) {
    if (text.isNotEmpty) {
      titleErrText.value = '';
    } else {
      titleErrText.value = 'Enter Title';
    }
  }

  void onChangedDescription(String text) {
    if (text.isNotEmpty) {
      descriptionErrText.value = '';
    } else {
      descriptionErrText.value = 'Enter Description';
    }
  }

  void onChangedLocation(String text) {
    if (text.isNotEmpty) {
      locationErrText.value = '';
    } else {
      locationErrText.value = 'Enter Location';
    }
  }

  void onChangedNotes(String text) {
    if (text.isNotEmpty) {
      notesErrText.value = '';
    } else {
      notesErrText.value = 'Enter Notes';
    }
  }

  void fromTimePicked(BuildContext context) async {
    // fromTime.value = await selectTime(context);

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
      selectDayColor.value = AppColors.error;
      return false;
    } else {
      return true;
    }
  }

  bool validateFromTime() {
    if (fromTime.value.isEmpty) {
      fromTimeErrText.value = 'Select from time';
      print(fromTime.value);
      return false;
    } else {
      return true;
    }
  }

  bool validateToTime() {
    if (toTime.value.isEmpty) {
      toTimeErrText.value = 'Select to time';
      print(toTime.value);
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

  void createActivity(String group_id) async {
    validateTitle();
    validateDescription();
    validateLocation();
    validateNotes();
    validateSelectedDay();
    validateFromTime();
    validateToTime();
    if (validateFromTime() && validateToTime()) {
      validateRightTime(ftime, ttime);
    }
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
      fromTimeErrText.value = '';
      toTimeErrText.value = '';
      isBusy.value = true;
      // await createActivityAPI(
      //   title: titleTED.text,
      //   description: descriptionTED.text,
      //   location: locationTED.text,
      //   note: notesTED.text,
      //   day: selectedDay.value,
      //   fromTime: fromTime.value,
      //   toTime: toTime.value,
      //   group_id: group_id,
      //   user_id: userModel.getid().toString(),
      // );
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
        chatScreenController.addData(
            messageType: MessageType.activity,
            message:
                '${userModel.getUserName()} created new activity in $location @${DateFormat('dd/MM/yyyy').format(DateTime.now())} $fromTime');

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
