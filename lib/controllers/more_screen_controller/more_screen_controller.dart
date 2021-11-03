import 'package:fitness_99/controllers/chat_screen_controller/chat_list_controller.dart';
import 'package:fitness_99/controllers/group_screen_controller/group_screen_controller.dart';
import 'package:fitness_99/controllers/profile_screen/profile_view_controller.dart';
import 'package:fitness_99/controllers/search_screen/search_screen_controller.dart';
import 'package:fitness_99/core/services/data_model.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive/hive.dart';

class MoreOptionsScreenController extends GetxController {
  void logout() async {
    await Hive.box<UserLocalDataModel>('user_data').clear();
    Get.delete<GroupScreenController>();
    Get.delete<ChatListController>();
    Get.delete<ProfileViewController>();
    Get.delete<SearchScreenController>();
    Get.delete<MoreOptionsScreenController>();
    Get.offNamedUntil(Routes.OnBoardScreen, (route) => false);
  }
}
