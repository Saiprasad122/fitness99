import 'package:fitness_99/core/api/api_service.dart';
import 'package:get/get.dart';

class GroupUserRequestController extends GetxController {
  final isBusy = false.obs;
  final apiService = Get.find<ApiService>();
}
