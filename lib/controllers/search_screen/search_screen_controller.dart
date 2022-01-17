import 'package:dio/dio.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_list_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final isLoading = true.obs;
  final isBusy = false.obs;
  final userModel = Get.find<UserModelService>();
  final apiService = Get.find<ApiService>();
  final chatListController = Get.find<ChatListController>();
  final groupList = [].obs;
  final searchedGroupList = [].obs;
  final searchTED = TextEditingController();

  @override
  void onInit() {
    getAllGroupData();
    super.onInit();
  }

  void getAllGroupData() async {
    try {
      final res = await apiService.getAllGroups();
      if (res.data != null) {
        groupList.addAll(res.data!);
        isLoading.value = false;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        print(e);
      } else {
        print(e);
      }
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
      if (res.data != null && res.status == 200) {
        chatListController.getGroupData();
        userModel.updateGroupCount(userModel.getNoOfGroups() + 1);
        customSnackBar(
          title: 'Joined Group',
          message: 'Successfully Joined Group',
          isSuccess: true,
        );
      } else {
        customSnackBar(
          title: 'Failed to join',
          message: 'Failed to join the group try again later',
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
          message: 'You can\'t join group is full',
          isSuccess: false,
        );
      }
    }
    isBusy.value = false;
  }

  // void checkIfJoined(int group_id) async {
  // var userData = await usersCollection.get();
  // userData.docs.forEach((element) { })
  // var snapshot = await usersCollection
  //     .doc(userModel.getEmail())
  //     .collection('groups')
  //     .get();

  // snapshot.docs.forEach((element) {
  //   if(element.exists && element.id!=group_id){
  //     usersCollection.doc(userModel.)
  //   }
  // });
  // }

  void onChangedSearchTextField(String? text) {
    if (text?.isNotEmpty ?? false) {
      searchedGroupList.clear();
      groupList.forEach((element) {
        if (element.group_name.toString().toLowerCase().contains(text!)) {
          searchedGroupList.add(element);
          print(searchedGroupList);
          print(element.group_name);
        }
      });
    } else if (text?.isEmpty ?? true) {
      searchedGroupList.clear();
    }
  }
}
