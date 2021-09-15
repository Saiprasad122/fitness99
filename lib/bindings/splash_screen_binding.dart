import 'package:fitness_99/controllers/auth_screen_controller/splashscreen_controller.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:get/get.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashViewController>(SplashViewController());
    Get.put<UserModelService>(UserModelService());
  }
}
