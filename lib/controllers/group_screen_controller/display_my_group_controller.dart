import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/models/display_group_reponse.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class DisplayGroupScreenController extends GetxController {
  final searchTED = TextEditingController();
  final groupList = <DisplayGroups>[].obs;
  final tempList = <DisplayGroups>[].obs;
  final searchedGroupList = [].obs;
  final isLoading = true.obs;
  final userModel = Get.find<UserModelService>();
  final apiService = Get.find<ApiService>();
  final textToShow = 'Tap to on "+" to create your first group'.obs;

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
          tempList.clear();
          groupList.addAll(res.data!);
          tempList.addAll(res.data!);
        } else {
          tempList.addAll(res.data!);
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
