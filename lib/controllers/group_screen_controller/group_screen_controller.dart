import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class GroupScreenController extends GetxController {
  final groupNameTED = TextEditingController();
  final goalTED = TextEditingController();
  final locationTED = TextEditingController();
  final maxMembersTED = TextEditingController();
  final commentsTED = TextEditingController();
  final groupList = [].obs;
  final isLoading = false.obs;
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

  void createGroup() async {}
}
