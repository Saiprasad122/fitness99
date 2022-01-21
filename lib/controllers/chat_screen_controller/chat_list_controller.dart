import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/models/display_group_reponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  final searchTED = TextEditingController();
  final isAnyGroups = true.obs;
  final isLoading = true.obs;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final groupList = <DisplayGroups>[].obs;
  final tempList = <DisplayGroups>[].obs;
  final searchedGroupList = [].obs;
  final collection = FirebaseFirestore.instance.collection('chatRoom');
  final textToShow = 'Your chat list is empty'.obs;

  @override
  void onInit() {
    getGroupData();
    super.onInit();
  }

  void getGroupData() async {
    isLoading.value = true;
    try {
      final res = await apiService.getGroups(userId: userModel.getid());

      if (res.data != null) {
        if (groupList.isNotEmpty) {
          groupList.clear();
          tempList.clear();
          groupList.addAll(res.data!);
          tempList.addAll(res.data!);
        } else {
          groupList.addAll(res.data!);
          tempList.addAll(res.data!);
        }
        isLoading.value = false;
      } else {
        textToShow.value = 'Your chat list is empty';
      }
    } on DioError catch (e) {
      print(e);
      textToShow.value = 'Your chat list is empty';
    } finally {
      isLoading.value = false;
    }
  }

  // void addCollection() {
  //   collection.doc(userModel.getEmail()).set({});
  // }

  // void addUser() {
  //   collection.doc(userModel.getEmail()).set({});
  // }

  // void getCollection() async {
  //   var snapshot =
  //       await collection.doc(userModel.getEmail()).collection('groups').get();
  //   snapshot.docs.forEach((element) {
  //     print('THe data is ${element.id}');
  //   });
  // }

  // void checkUser() async {
  //   var snapshot = await collection.get();
  //   snapshot.docs.forEach((element) {
  //     print(element.id);
  //   });
  // }

  void onChangedSearchTextField(String? text) {
    if (text?.isNotEmpty ?? false) {
      searchedGroupList.clear();

      tempList.forEach((element) {
        searchedGroupList.addIf(
            element.group_name.toLowerCase().startsWith(text!.toLowerCase()),
            element);
        if (searchedGroupList.isEmpty) {
          textToShow.value = 'No Groups were found';
          groupList.clear();
        }
      });
    } else if (text?.isEmpty ?? true) {
      groupList.clear();
      groupList.addAll(tempList);
      searchedGroupList.clear();
    }
  }
}
