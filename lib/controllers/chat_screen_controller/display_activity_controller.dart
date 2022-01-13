import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:get/get.dart';

class DisplayActivityController extends GetxController {
  DisplayActivityController({required this.group_id});
  final int group_id;
  final isBusy = false.obs;
  final activityList = [].obs;
  final apiService = Get.find<ApiService>();

  @override
  void onInit() {
    getActivityList(group_id);
    super.onInit();
  }

  void getActivityList(int group_id) async {
    try {
      final response = await apiService.getActivityList(group_id: group_id);

      if (response.status == 200) {
        if (activityList.isNotEmpty) {
          activityList.clear();
          activityList.add(response.data);
        } else {
          activityList.add(response.data);
        }
      }
    } on DioError catch (e) {
      print(e);
    } finally {
      isBusy.value = false;
    }
  }
}
