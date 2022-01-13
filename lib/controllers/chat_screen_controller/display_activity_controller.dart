import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/models/display_activity_response.dart';
import 'package:get/get.dart';

class DisplayActivityController extends GetxController {
  DisplayActivityController({required this.group_id});
  final int group_id;
  final isBusy = false.obs;
  final List<Content> activityList = [];
  final apiService = Get.find<ApiService>();

  @override
  void onInit() {
    getActivityList(group_id);
    super.onInit();
  }

  void getActivityList(int group_id) async {
    try {
      isBusy.value = true;
      final response = await apiService.getActivityList(group_id: group_id);

      if (response.status == 200) {
        if (activityList.isNotEmpty) {
          activityList.clear();
          activityList.addAll(response.data.content);
        } else {
          activityList.addAll(response.data.content);
        }
      }
      isBusy.value = false;
    } on DioError catch (e) {
      print(e);
      isBusy.value = false;
    } finally {
      isBusy.value = false;
    }
  }
}
