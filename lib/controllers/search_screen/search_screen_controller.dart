import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/models/display_group_reponse.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final isLoading = true.obs;
  final userModel = Get.find<UserModelService>();
  final apiService = Get.find<ApiService>();
  List<DisplayGroups> groupList = [];

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
}
