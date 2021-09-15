import 'package:fitness_99/core/services/needed_utils.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileViewController extends GetxController {
  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;
  final email = ''.obs;
  final userName = ''.obs;
  final mobileNumber = ''.obs;
  @override
  Future<void> onInit() async {
    _prefs = Get.find<NeededVariables>().sharedPreferences;
    email.value = _prefs!.getString('email')!;
    userName.value = _prefs!.getString('user_name')!;
    mobileNumber.value = _prefs!.getString('mobile_number')!;
    super.onInit();
  }

  void done() {}
}
