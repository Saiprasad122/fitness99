import 'dart:async';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/data_model.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class SplashViewController extends GetxController {
  final userModel = Get.find<UserModelService>();

  @override
  void onInit() {
    Timer(
      Duration(seconds: 1),
      () async {
        if (userModel.getEmail() != "N/A") {
          try {
            final apiService = Get.find<ApiService>();

            final res = await apiService.getProfileData(
              user_id: userModel.getid(),
            );
            if (res.message?.toLowerCase() == 'success') {
              UserLocalDataModel userLocalDataModel = UserLocalDataModel(
                id: userModel.getid(),
                userName: res.data!.user.user_name,
                email: res.data!.user.email,
                mobileNumber: res.data!.user.number ?? 'N/A',
                numbesrOfGroups: res.data!.user.group_count,
                profilePicture: res.data!.user.profile_picture ?? '',
                pendingInvitation: res.data!.pending_invitation,
              );
              await Hive.box<UserLocalDataModel>('user_data')
                  .put('data', userLocalDataModel);
            }
            print('THe shared pref is ${userModel.getEmail()}');

            Get.offNamed(Routes.DashboardScreen);
          } on DioError catch (e) {
            log('Error: $e', error: e);
            Get.offNamed(Routes.DashboardScreen);
          }
        } else {
          Get.offNamed(Routes.OnBoardScreen);
        }
      },
    );
    super.onInit();
  }
}
