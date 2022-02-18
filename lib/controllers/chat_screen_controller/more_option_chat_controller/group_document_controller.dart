import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/core/services/get_directories.dart';
import 'package:get/get.dart';

class GroupFilesListController extends GetxController {
  final List<String> filesList = [];
  final chatScreenController = Get.find<ChatScreenController>();
  final directoriesService = Get.find<DirectoriesService>();
  final chatController = Get.find<ChatScreenController>();
  @override
  void onInit() async {
    // final doc = await FirebaseFirestore.instance
    //     .collection('groups')
    //     .doc(chatScreenController.group_id.toString())
    //     .collection('chats')
    //     .orderBy('time', descending: true)
    //     .get();
    // doc.docs.forEach((element) {
    //   print('THe element is-------${element.data()}');
    // });

    super.onInit();
    filesList.addAll(directoriesService
        .getFilesOfGroup(chatController.group_id.toString())
        .map((e) =>
            directoriesService
                .getFilesPath(chatController.group_id.toString()) +
            e));
  }
}
