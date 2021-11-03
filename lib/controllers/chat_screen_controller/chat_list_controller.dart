import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  final isAnyGroups = true.obs;
  final isLoading = true.obs;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final groupList = [].obs;

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
