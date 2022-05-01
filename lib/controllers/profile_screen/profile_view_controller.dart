import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:get/get.dart';

class ProfileViewController extends GetxController {
  final userName = ''.obs;
  final mobileNumber = 'N/A'.obs;
  final email = ''.obs;
  final profilePicture = ''.obs;
  final userModel = Get.find<UserModelService>();

  @override
  void onInit() {
    userName.value = userModel.getUserName();
    mobileNumber.value = userModel.getMobileNumber();
    email.value = userModel.getEmail();
    profilePicture.value = userModel.getProfilePicture();
    super.onInit();
  }
}
