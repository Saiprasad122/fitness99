import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:get/get.dart';

class InviteMembersController extends GetxController {
  InviteMembersController({required this.group_id});
  final group_id;
  final isBusy = false.obs;
  final apiService = Get.find<ApiService>();
  final userList = <User>[];

  @override
  void onInit() {
    getUserList();
    super.onInit();
  }

  void getUserList() async {
    isBusy.value = true;
    try {
      final res = await apiService.getInviteMembersMyGroup(group_id: group_id);
      if (res.data?.isNotEmpty ?? false) {
        if (userList.isNotEmpty) {
          userList.clear();
          userList.addAll(res.data!);
        } else {
          userList.addAll(res.data!);
        }
      } else {
        customSnackBar(
          title: 'No User found!',
          message: 'No users were please update categories',
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
    isBusy.value = false;
  }
}
