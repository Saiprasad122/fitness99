import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/core/services/get_directories.dart';
import 'package:get/get.dart';

class GroupVideoListController extends GetxController {
  final List<VideoModel> videoList = [];
  final chatScreenController = Get.find<ChatScreenController>();
  final directoriesService = Get.find<DirectoriesService>();
  final chatController = Get.find<ChatScreenController>();
  @override
  void onInit() async {
    super.onInit();
    videoList.addAll(directoriesService
        .getVideosWithoutThumbnailsOfGroup(chatController.group_id.toString())
        .map((e) {
      String videoFileUrl =
          directoriesService.getVideosPath(chatController.group_id.toString()) +
              e;
      String extension = (directoriesService
                  .getVideosPath(chatController.group_id.toString()) +
              e)
          .substring((directoriesService
                          .getVideosPath(chatController.group_id.toString()) +
                      e)
                  .lastIndexOf('.') +
              1);
      String videoThumbnailFileUrl = (directoriesService
                      .getVideosPath(chatController.group_id.toString()) +
                  e)
              .substring(
                  0,
                  (directoriesService.getVideosPath(
                              chatController.group_id.toString()) +
                          e)
                      .lastIndexOf('.')) +
          '_thumbnail' +
          '.jpg';

      return VideoModel(videoFileUrl, videoThumbnailFileUrl, extension);
    }));
  }
}

class VideoModel {
  final String videoUrl;
  final String videoThumbnailUrl;
  final String extension;

  VideoModel(this.videoUrl, this.videoThumbnailUrl, this.extension);
}
