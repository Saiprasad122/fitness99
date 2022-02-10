import 'package:dio/dio.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_list_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/display_group_reponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final isLoading = true.obs;
  final isBusy = false.obs;
  final userModel = Get.find<UserModelService>();
  final apiService = Get.find<ApiService>();
  final chatListController = Get.find<ChatListController>();
  final groupList = <DisplayGroups>[].obs;
  final tempList = <DisplayGroups>[].obs;
  final searchedGroupList = [].obs;
  final searchTED = TextEditingController();
  final textToShow = 'No Groups to search'.obs;

  @override
  void onInit() {
    getAllGroupData();
    super.onInit();
  }

  void getAllGroupData() async {
    try {
      final res = await apiService.getAllGroups();
      if (res.data != null) {
        if (res.data?.isNotEmpty ?? false) {
          textToShow.value = 'No Groups to search';
          groupList.clear();
          tempList.clear();
          tempList.addAll(res.data!);
          groupList.addAll(res.data!);
          isLoading.value = false;
        } else {
          tempList.addAll(res.data!);
          groupList.addAll(res.data!);
        }
      } else {
        textToShow.value = 'No Groups to search';
      }
    } on DioError catch (e) {
      textToShow.value = 'No Groups to search';
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void joinGroup(int group_id) async {
    isBusy.value = true;
    try {
      final res = await apiService.joinGroup(
          userID: userModel.getid(), group_id: group_id);
      if (res.message!.toLowerCase().contains('sent') && res.status == 200) {
        chatListController.getGroupData();
        userModel.updateGroupCount(userModel.getNoOfGroups() + 1);
        customSnackBar(
          title: 'Invitation Sent',
          message: 'Successfully Invitation Sent',
          isSuccess: true,
        );
      } else {
        customSnackBar(
          title: 'Failed to Sent',
          message: 'Failed to sent the invitation try again later',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404 &&
          e.response!.data['message']
              .toString()
              .toLowerCase()
              .contains('exists')) {
        customSnackBar(
          title: 'Already exists!',
          message: 'You have already joined this group',
          isSuccess: false,
        );
      } else if (e.response!.statusCode == 404 &&
          e.response!.data['message']
              .toString()
              .toLowerCase()
              .contains('full')) {
        customSnackBar(
          title: 'Group is full',
          message: 'You can\'t send invitation group is full',
          isSuccess: false,
        );
      }
    }
    isBusy.value = false;
  }

  void onChangedSearchTextField(String? text) {
    if (text?.isNotEmpty ?? false) {
      searchedGroupList.clear();
      tempList.forEach((element) {
        searchedGroupList.addIf(
            element.group_name.toLowerCase().startsWith(text!.toLowerCase()),
            element);
        if (searchedGroupList.isEmpty) {
          groupList.clear();
          textToShow.value = 'No Groups were found';
        }
      });
    } else if (text?.isEmpty ?? true) {
      groupList.clear();
      groupList.addAll(tempList);
      searchedGroupList.clear();
    }
  }
}
