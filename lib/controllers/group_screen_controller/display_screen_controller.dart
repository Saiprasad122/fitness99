import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

class DisplayScreenController extends GetxController {
  final groupList = [].obs;
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
}
