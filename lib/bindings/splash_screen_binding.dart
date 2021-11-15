import 'package:fitness_99/controllers/auth_screen_controller/splashscreen_controller.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:get/get.dart';

class SplashScreenBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<SplashViewController>(SplashViewController());
    Get.put<ApiService>(ApiService.create());
  }
}
