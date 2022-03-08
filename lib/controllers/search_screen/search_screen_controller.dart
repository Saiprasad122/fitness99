import 'package:dio/dio.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_list_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/display_group_reponse.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/displayGlobalEventListResponse.dart';

class SearchScreenController extends GetxController
    with GetSingleTickerProviderStateMixin {
  TabController? tabController;
  final isGroupLoading = true.obs;
  final isEventLoading = true.obs;
  final isBusy = false.obs;
  final userModel = Get.find<UserModelService>();
  final apiService = Get.find<ApiService>();
  final chatListController = Get.find<ChatListController>();
  final groupList = <DisplayGroups>[].obs;
  final tempGroupList = <DisplayGroups>[].obs;
  final tempEventList = <DisplayGlobalEventList>[].obs;
  final eventList = <DisplayGlobalEventList>[].obs;
  final searchedGroupList = [].obs;
  final searchedEventList = <DisplayGlobalEventList>[].obs;
  final searchGroupsTED = TextEditingController();
  final searchEventsTED = TextEditingController();
  final textToShowGroups = 'No Groups to search'.obs;
  final textToShowEvents = 'No Events to search'.obs;

  @override
  void onInit() {
    getAllEventList();
    getAllGroupData();
    tabController = TabController(length: 2, vsync: this);
    super.onInit();
  }

  @override
  void dispose() {
    tabController!.dispose();
    super.dispose();
  }

  void getAllGroupData() async {
    try {
      final res = await apiService.getAllGroups();
      if (res.data != null) {
        if (res.data?.isNotEmpty ?? false) {
          textToShowGroups.value = 'No Groups to search';
          groupList.clear();
          tempGroupList.clear();
          tempGroupList.addAll(res.data!);
          groupList.addAll(res.data!);
          isGroupLoading.value = false;
        } else {
          tempGroupList.addAll(res.data!);
          groupList.addAll(res.data!);
        }
      } else {
        textToShowGroups.value = 'No Groups to search';
      }
    } on DioError catch (e) {
      textToShowGroups.value = 'No Groups to search';
      print(e);
    } finally {
      isGroupLoading.value = false;
    }
  }

  void getAllEventList() async {
    try {
      final res = await apiService.getGlobalEventList();
      if (res.data != null) {
        if (res.data?.isNotEmpty ?? false) {
          tempEventList.clear();
          eventList.clear();
          tempEventList.addAll(res.data!);
          eventList.addAll(res.data!);
          isEventLoading.value = false;
        } else {
          tempEventList.addAll(res.data!);
          eventList.addAll(res.data!);
        }
      }
    } on DioError catch (e) {
      print(e);
    } finally {
      isEventLoading.value = false;
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

  void onChangedGroupListSearchTextField(String? text) {
    if (text?.isNotEmpty ?? false) {
      searchedGroupList.clear();
      tempGroupList.forEach((element) {
        searchedGroupList.addIf(
          element.group_name.toLowerCase().startsWith(text!.toLowerCase()),
          element,
        );
        if (searchedGroupList.isEmpty) {
          groupList.clear();
          textToShowGroups.value = 'No Groups were found';
        }
      });
    } else if (text?.isEmpty ?? true) {
      groupList.clear();
      groupList.addAll(tempGroupList);
      searchedGroupList.clear();
    }
  }

  void onChangedEventListSearchTextField(String? text) {
    if (text?.isNotEmpty ?? false) {
      searchedEventList.clear();
      tempEventList.forEach((element) {
        searchedEventList.addIf(
            element.title.toLowerCase().startsWith(text!.toLowerCase()),
            element);
        if (searchedGroupList.isEmpty) {
          eventList.clear();
          textToShowEvents.value = 'No Groups were found';
        }
      });
    } else if (text?.isEmpty ?? true) {
      eventList.clear();
      eventList.addAll(tempEventList);
      searchedEventList.clear();
    }
  }
}
