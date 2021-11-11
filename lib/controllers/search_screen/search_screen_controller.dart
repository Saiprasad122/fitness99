import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/display_group_reponse.dart';
import 'package:get/get.dart';

class SearchScreenController extends GetxController {
  final isLoading = true.obs;
  final isBusy = false.obs;
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

  void joinGroup(int group_id) async {
    isBusy.value = true;
    try {
      final res = await apiService.joinGroup(
          userID: userModel.getid(), group_id: group_id);
      if (res.data != null && res.status == 200) {
        customSnackBar('Joined Group', 'Successfully Joined Group', true);
      } else if (res.status == 404) {
        print('-----------------------------------------');
      } else {
        customSnackBar('Failed to join',
            'Failed to join the group try again later', false);
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404 &&
          e.response!.data['message']
              .toString()
              .toLowerCase()
              .contains('exists')) {
        customSnackBar(
            'Already exists!', 'You have already joined this group', false);
      } else if (e.response!.statusCode == 404 &&
          e.response!.data['message']
              .toString()
              .toLowerCase()
              .contains('full')) {
        customSnackBar('Group full', 'You can\'t join group is full', false);
      }
    }
    isBusy.value = false;
  }
}
