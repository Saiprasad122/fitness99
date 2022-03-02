// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';
import 'package:fitness_99/controllers/group_screen_controller/display_my_group_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/models/pending_invitation_response/pending_invitation_model.dart';
import 'package:fitness_99/models/sendInvitationGroupRequestResponse/accept_reject_group_invitation_request.dart';
import 'package:get/get.dart';

class PendingInvitationController extends GetxController {
  final pendingInvitesList = <PendingInvitationModel>[].obs;
  final isBusy = false.obs;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();

  @override
  void onInit() {
    super.onInit();
    getUserData();
  }

  void getUserData() async {
    isBusy.value = true;
    try {
      final res = await apiService.getPendingInvitationsForUser(
        userId: userModel.getid(),
      );
      if (res.message!.toLowerCase().contains('success') && res.status == 200) {
        if (pendingInvitesList.isNotEmpty) {
          pendingInvitesList.clear();
          pendingInvitesList.addAll(res.data ?? []);
        } else {
          pendingInvitesList.addAll(res.data ?? []);
        }
      }
      print(pendingInvitesList.length);
    } on DioError catch (e) {
      print(e);
    }
    isBusy.value = false;
  }

  Future<void> acceptGroupInvitation(int groupId) async {
    try {
      final res = await apiService.userPendingInvitationResponse(
        AcceptRejectGroupInivitationRequest(
            user_id: userModel.getid().toString(),
            group_id: groupId.toString(),
            status: '1'),
      );

      Get.find<DisplayGroupScreenController>().getGroupData();

      print(pendingInvitesList.length);
    } on DioError catch (e) {
      print(e);
    }
  }

  Future<void> rejectGroupInvitation(int groupId) async {
    try {
      final res = await apiService.groupInvitationResponse(
        AcceptRejectGroupInivitationRequest(
            user_id: userModel.getid().toString(),
            group_id: groupId.toString(),
            status: '0'),
      );
      Get.find<DisplayGroupScreenController>().getGroupData();
      print(pendingInvitesList.length);
    } on DioError catch (e) {
      print(e);
    }
  }

  void removeUserWithId(int groupId) {
    pendingInvitesList.removeWhere((element) => element.group?.id == groupId);
  }
}
