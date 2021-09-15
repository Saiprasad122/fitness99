import 'package:fitness_99/core/services/needed_utils.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoreScreenController extends GetxController {
  SharedPreferences? _prefs;
  SharedPreferences? get prefs => _prefs;
  final userName = ''.obs;

  @override
  void onInit() {
    _prefs = Get.find<NeededVariables>().sharedPreferences;
    userName.value = Get.find<UserModelService>().getUserName();
    // userName.value = prefs!.getString('user_name')!;
    super.onInit();
  }
}
