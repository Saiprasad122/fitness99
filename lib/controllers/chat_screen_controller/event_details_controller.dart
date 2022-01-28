import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:get/get.dart';

class EventDetailsController extends GetxController {
  EventDetailsController({required this.event_id});
  final int event_id;
  final isBusy = true.obs;
  final userList = <User>[].obs;
  final isCheckedIn = false.obs;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();

  @override
  void onInit() async {
    isBusy.value = true;
    userList.clear();
    await checkInUserList();
    isBusy.value = false;
    super.onInit();
  }

  Future<void> checkInUserList() async {
    try {
      final response = await apiService.getEventCheckInList(event_id: event_id);
      if (response.status == 200 && response.data != null) {
        if (userList.isNotEmpty) {
          userList.clear();
          response.data!.forEach((element) {
            userList.add(element);
          });
        } else {
          response.data!.forEach((element) {
            userList.add(element);
          });
        }
        userList.toList().forEach(
          (element) {
            if (element.id == userModel.getid()) {
              isCheckedIn.value = true;
            }
          },
        );
      } else {
        customSnackBar(
          title: 'Something went Wrong!',
          message: 'Please try again.',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      customSnackBar(
        title: 'Something went Wrong!',
        message: 'Please try again.',
        isSuccess: false,
      );
      print(e);
    }
  }

  void checkInUser() async {
    isBusy.value = true;
    try {
      final response = await apiService.getEventCheckInByUserId(
          event_id: event_id, user_id: userModel.getid());

      if (response.message!.toLowerCase().contains('successfully') &&
          response.status == 200) {
        isCheckedIn.value = true;
        checkInUserList(); //Call the User checkIn list to update it
        customSnackBar(
          title: 'Checked in successfully',
          message: 'You have successfully checked in.',
          isSuccess: true,
        );
      } else {
        customSnackBar(
          title: 'Something went Wrong!',
          message: 'Please try again',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      print(e);
    }
    isBusy.value = false;
  }

  void checkOutUser() async {
    isBusy.value = true;
    try {
      final response = await apiService.getEventCheckOutByUserId(
          event_id: event_id, user_id: userModel.getid());

      if (response.message!.toLowerCase().contains('success') &&
          response.status == 200) {
        isCheckedIn.value = false;
        checkInUserList(); //Call the User checkIn list to update it
        customSnackBar(
          title: 'Checked out successfully',
          message: 'You have successfully checked out.',
          isSuccess: true,
        );
      } else {
        customSnackBar(
          title: 'Something went Wrong!',
          message: 'Please try agin',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      print(e);
    }
    isBusy.value = false;
  }
}
