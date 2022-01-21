import 'package:dio/dio.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/controllers/chat_screen_controller/display_all_events_controller.dart';
import 'package:fitness_99/controllers/chat_screen_controller/mssg_type_enum.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/createEventRequestResponse/create_event_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CreateEventController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final chatScreenController = Get.find<ChatScreenController>();
  final isBusy = false.obs;
  final titleTED = TextEditingController();
  final descriptionTED = TextEditingController();
  final locationTED = TextEditingController();
  final membersTED = TextEditingController();
  final titleErrText = ''.obs;
  final descriptionErrText = ''.obs;
  final locationErrText = ''.obs;
  final membersErrText = ''.obs;
  final selectDateTimeErrText = ''.obs;
  final selectedDate = ''.obs;
  final apiSelectedDate = ''.obs;
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

  void onChangedMember(String text) {
    if (text.isNotEmpty) {
      membersErrText.value = '';
    } else {
      membersErrText.value = 'Enter Members';
    }
  }

  Future<void> selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: currentTime,
    );
    if (picked != null) {
      selectedTime.value = picked.format(context);
      selectDateTimeErrText.value = '';
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
      apiSelectedDate.value = DateFormat('yyyy/MM/dd').format(picked);
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

  bool validateMaxMembers() {
    if (membersTED.text.isEmpty) {
      membersErrText.value = 'Enter Member';
      return false;
    } else if (int.parse(membersTED.text) > 25 ||
        int.parse(membersTED.text) < 1) {
      membersErrText.value = 'Group members range must be between 1-25';
      return false;
    } else if (!membersTED.text.isNum) {
      membersErrText.value = 'Enter a valid number';
      return false;
    }
    return true;
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

  void createEvent(String group_id) {
    validateTitle();
    validateDescription();
    validateLocation();
    validateDateTime();
    validateMaxMembers();
    if (validateTitle() &&
        validateDescription() &&
        validateLocation() &&
        validateDateTime() &&
        validateMaxMembers()) {
      titleErrText.value = '';
      descriptionErrText.value = '';
      locationErrText.value = '';
      selectDateTimeErrText.value = '';
      membersErrText.value = '';
      isBusy.value = true;
      createEventAPI(
        title: titleTED.text,
        description: descriptionTED.text,
        location: locationTED.text,
        date: apiSelectedDate.value,
        time: selectedTime.value,
        member: membersTED.text,
        user_id: userModel.getid().toString(),
        group_id: group_id,
      );
      isBusy.value = false;
    }
  }

  Future<void> createEventAPI({
    required String title,
    required String description,
    required String location,
    required String member,
    required String date,
    required String time,
    required String group_id,
    required String user_id,
  }) async {
    try {
      CreateEventRequest body = CreateEventRequest(
        title: title,
        description: description,
        location: location,
        members: member,
        date: date,
        time: time,
        user_id: user_id,
        group_id: group_id,
      );

      final response = await apiService.createEventResponse(body);

      if (response.message?.toLowerCase().contains('success') ?? false) {
        chatScreenController.addData(
            messageType: MessageType.event,
            message:
                '${userModel.getUserName()} created new event in $location @$selectedDate $time');
        Get.back();
        final diplayActivityController = Get.put<DisplayEventController>(
            DisplayEventController(group_id: int.parse(group_id)));

        diplayActivityController.getEventList(int.parse(group_id));
        customSnackBar(
          title: 'Success',
          message: 'Event created successfully',
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
