import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/core/services/get_directories.dart';
import 'package:get/get.dart';

class GroupFilesListController extends GetxController {
  final List<String> FilesList = [];
  final chatScreenController = Get.find<ChatScreenController>();
  final directoriesService = Get.find<DirectoriesService>();
  final chatController = Get.find<ChatScreenController>();
  @override
  void onInit() async {
    super.onInit();
    FilesList.addAll(directoriesService
        .getFullFileNamesOfGroup(chatController.group_id.toString())
        .map((e) =>
            directoriesService
                .getFilesPath(chatController.group_id.toString()) +
            e));
  }
}
