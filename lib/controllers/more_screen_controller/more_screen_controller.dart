import 'package:fitness_99/core/services/data_model.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class MoreOptionsScreenController extends GetxController {
  void logout() async {
    await Hive.box<DataModel>('user_data').clear();
    Get.offNamedUntil(Routes.OnBoardScreen, (route) => false);
  }
}
