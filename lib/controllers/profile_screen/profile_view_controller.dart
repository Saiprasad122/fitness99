import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:get/get.dart';

class ProfileViewController extends GetxController {
  final userName = ''.obs;
  final mobileNumber = 'N/A'.obs;
  final email = ''.obs;
  final numbesrOfGroups = 0.obs;
  final pendingInvitation = 0.obs;
  final profilePicture = ''.obs;
  final userModel = Get.find<UserModelService>();

  @override
  void onInit() {
    userName.value = userModel.getUserName();
    mobileNumber.value = userModel.getMobileNumber();
    email.value = userModel.getEmail();
    numbesrOfGroups.value = userModel.getNoOfGroups();
    pendingInvitation.value = userModel.getPendingInvitation();
    profilePicture.value = userModel.getProfilePicture();
    super.onInit();
  }
}
