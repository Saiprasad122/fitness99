import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/core/services/get_directories.dart';
import 'package:get/get.dart';

class GroupVideosListController extends GetxController {
  final List<String> VideosList = [];
  final List<String> VideosThumbnailList = [];
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
    final files =
        directoriesService.getVideosOfGroup(chatController.group_id.toString());
    files.forEach((element) {
      if (!element.contains('thumbnail')) {
        VideosList.add(directoriesService
                .getVideosPath(chatController.group_id.toString()) +
            element);
        final videoNameExtention = element.split('.');
        VideosThumbnailList.add(directoriesService
                .getVideosPath(chatController.group_id.toString()) +
            videoNameExtention[0] +
            '_thumbnail' +
            '.jpg');
      }
    });
    print(VideosList);
  }
}
