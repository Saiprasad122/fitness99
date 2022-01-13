import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class MemberListController extends GetxController {
  final isApiCalling = false.obs;
  final apiService = Get.find<ApiService>();
  final memberList = [].obs;

  void getMemberList(int group_id) async {
    isApiCalling.value = true;
    try {
      final res = await apiService.getMemberList(group_id: group_id);
      if (res.data != null && res.status == 200) {
        if (memberList.isNotEmpty) {
          memberList.clear();
          memberList.addAll(res.data!);
        } else {
          memberList.addAll(res.data!);
        }
      } else {
        customSnackBar(
          title: 'Error!',
          message: 'Please try again later',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      print(e);
      customSnackBar(
        title: 'Error!',
        message: 'Please try again later',
        isSuccess: false,
      );
    }
    isApiCalling.value = false;
  }
}
