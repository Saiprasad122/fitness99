import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/models/sendInvitationGroupRequestResponse/send_invitation_group_response.dart';
import 'package:get/get.dart';

class GroupUserRequestController extends GetxController {
  GroupUserRequestController({required this.group_id});

  final isBusy = false.obs;
  final group_id;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();

  final userList = <Users>[].obs;

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void getUserData() async {
    isBusy.value = true;
    try {
      final res = await apiService.getGroupInvitation(group_id: group_id);
      if (res.message!.toLowerCase().contains('success') && res.status == 200) {
        if (userList.isNotEmpty) {
          userList.clear();
          userList.addAll(res.data!.user);
        } else {
          userList.addAll(res.data!.user);
        }
      }
      print(userList.length);
    } on DioError catch (e) {
      print(e);
    }
    isBusy.value = false;
  }
}
