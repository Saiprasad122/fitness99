import 'dart:developer';
import 'dart:io';

import 'package:fitness_99/global/router/views.export.dart';
import 'package:path_provider/path_provider.dart';

class DirectoriesService extends GetxController {
  late final Directory _dir;

  void initFolder() async {
    _dir = await getApplicationDocumentsDirectory();
  }

  Directory getDownloadDirectoryForimagesOfGroup(int groupId) {
    return Directory(getImagesPath(groupId.toString()));
  }

  Directory getDownloadDirectoryForvideosOfGroup(int groupId) {
    return Directory(getVideosPath(groupId.toString()));
  }

  Directory getDownloadDirectoryForfilesOfGroup(int groupId) {
    return Directory(getFilesPath(groupId.toString()));
  }

  String getImagesPath(String groupId) =>
      _dir.path + "/assets/$groupId/images/";
  String getVideosPath(String groupId) =>
      _dir.path + "/assets/$groupId/videos/";

  String getFilesPath(String groupId) => _dir.path + "/assets/$groupId/files/";

  List<String> getImagesOfGroup(String groupId) {
    final List<String> images = [];

    try {
      final imagesDirectory = Directory(getImagesPath(groupId));

      final _imagesFile =
          imagesDirectory.listSync(followLinks: false, recursive: true);
      _imagesFile.forEach((img) {
        String imgString = img.path.substring(
            img.path.lastIndexOf('/') + 1, img.path.lastIndexOf('.'));
        images.add(imgString);
      });
    } catch (e) {
      log('Error', error: e, name: 'Directory');
    } finally {
      return images;
    }
  }

  List<String> getVideosOfGroup(String groupId) {
    final List<String> videos = [];

    try {
      final videosDirectory = Directory(getVideosPath(groupId));

      final _videosFile =
          videosDirectory.listSync(followLinks: false, recursive: true);
      _videosFile.forEach((vid) {
        final vidPath = vid.path;
        String vidString =
            vidPath.substring(vidPath.lastIndexOf('/') + 1, vidPath.length);
        videos.add(vidString);
      });
    } catch (e) {
      log('Error', error: e, name: 'Directory');
    } finally {
      return videos;
    }
  }

  List<String> getFilesOfGroup(String groupId) {
    final List<String> files = [];
    try {
      final filesDirectory = Directory(getFilesPath(groupId));

      final _filesFile =
          filesDirectory.listSync(followLinks: false, recursive: true);
      _filesFile.forEach((file) {
        String fileString = file.path.substring(file.path.lastIndexOf('/') + 1);
        files.add(fileString);
      });
    } catch (e) {
      log('Error', error: e, name: 'Directory');
    } finally {
      return files;
    }
  }

  Future<File> moveFile(File sourceFile, String newPath) async {
    try {
      /// prefer using rename as it is probably faster
      /// if same directory path
      return await sourceFile.rename(newPath);
    } catch (e) {
      /// if rename fails, copy the source file
      final newFile = await sourceFile.copy(newPath);
      return newFile;
    }
  }
}
