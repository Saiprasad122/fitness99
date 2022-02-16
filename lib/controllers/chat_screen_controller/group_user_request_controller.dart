import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/models/sendInvitationGroupRequestResponse/accept_reject_group_invitation_request.dart';
import 'package:fitness_99/models/sendInvitationGroupRequestResponse/send_invitation_group_response.dart';
import 'package:get/get.dart';

import '../../models/loginReposnseRequest/login_response.dart';

class GroupUserRequestController extends GetxController {
  GroupUserRequestController({required this.group_id});

  final isBusy = false.obs;
  final group_id;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();

  final userList = <User>[].obs;

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
          userList.addAll(res.data?.user ?? []);
        } else {
          userList.addAll(res.data?.user ?? []);
        }
      }
      print(userList.length);
    } on DioError catch (e) {
      print(e);
    }
    isBusy.value = false;
  }

  Future<void> acceptUser(String userId) async {
    try {
      final res = await apiService.groupInvitationResponse(
          AcceptRejectGroupInivitationRequest(
              user_id: userId, group_id: group_id.toString(), status: '1'));
      print(userList.length);
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> rejectUser(String userId) async {
    try {
      final res = await apiService.groupInvitationResponse(
          AcceptRejectGroupInivitationRequest(
              user_id: userId, group_id: group_id.toString(), status: '0'));
      print(userList.length);
    } on DioError catch (e) {
      print(e);
    }
  }

  void removeUserAtIndex(int index) {
    userList.removeAt(index);
  }
}
