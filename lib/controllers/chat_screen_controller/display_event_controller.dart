import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/models/display_event_response.dart';
import 'package:get/get.dart';

class DisplayEventController extends GetxController {
  DisplayEventController({required this.group_id});
  final apiService = Get.find<ApiService>();
  final int group_id;
  final isBusy = false.obs;
  final List<Content> eventList = [];
  @override
  void onInit() {
    getEventList(group_id);
    super.onInit();
  }

  void getEventList(int group_id) async {
    try {
      isBusy.value = true;
      final response = await apiService.getEventList(group_id: group_id);

      if (response.status == 200) {
        if (eventList.isNotEmpty) {
          eventList.clear();
          eventList.addAll(response.data.content);
        } else {
          eventList.addAll(response.data.content);
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
