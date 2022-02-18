import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/invite_members_response.dart';
import 'package:fitness_99/models/send_request_from_my_group_request.dart';
import 'package:get/get.dart';

class InviteMembersController extends GetxController {
  InviteMembersController({required this.group_id});
  final group_id;
  final isBusy = false.obs;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final userList = <Users>[];
  final pendingUserList = <Pending_user>[];

  @override
  void onInit() {
    getUserList();
    super.onInit();
  }

  void getUserList() async {
    isBusy.value = true;
    try {
      final res = await apiService.getInviteMembersMyGroup(group_id: group_id);
      if (res.data != null) {
        if (userList.isNotEmpty) {
          userList.clear();
          userList.addAll(res.data!.users);
        } else {
          userList.addAll(res.data!.users);
        }
        if (pendingUserList.isNotEmpty) {
          pendingUserList.clear();
          pendingUserList.addAll(res.data!.pending_user);
        } else {
          pendingUserList.addAll(res.data!.pending_user);
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

  void sendRequest({required int group_id, required int user_id}) async {
    isBusy.value = true;
    try {
      final body = SendReqFromMyGroupRequest(
          group_id: group_id.toString(), user_id: user_id.toString());

      final res = await apiService.sendInvitationFromMyGroup(body);

      if (res.status == 200 &&
          res.message!.toLowerCase().contains('invitation sent')) {
        getUserList();
        customSnackBar(
          title: 'Invitation send',
          message: 'Invitation send successfully',
          isSuccess: true,
        );
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
    isBusy.value = false;
  }
}
