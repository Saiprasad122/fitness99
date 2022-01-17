import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class DisplayGroupScreenController extends GetxController {
  final searchTED = TextEditingController();
  final groupList = [].obs;
  final searchedGroupList = [].obs;
  final isLoading = true.obs;
  final userModel = Get.find<UserModelService>();
  final apiService = Get.find<ApiService>();

  @override
  void onInit() {
    getGroupData();
    super.onInit();
  }

  void getGroupData() async {
    isLoading.value = true;
    try {
      final res = await apiService.getMyGroups(userId: userModel.getid());
      if (res.data != null) {
        if (groupList.isNotEmpty) {
          groupList.clear();
          groupList.addAll(res.data!);
        } else {
          groupList.addAll(res.data!);
        }
        isLoading.value = false;
      }
    } on DioError catch (e) {
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

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
