import 'dart:io';

import 'package:fitness_99/global/router/views.export.dart';
import 'package:path_provider/path_provider.dart';

class DirectoriesService extends GetxController {
  Future<Directory> getDownloadDirectoryForimagesOfGroup(int groupId) async {
    final dir = await getApplicationDocumentsDirectory();
    return Directory(dir.path + "assets/$groupId/images/");
  }

  Future<Directory> getDownloadDirectoryForvideosOfGroup(int groupId) async {
    final dir = await getApplicationDocumentsDirectory();
    return Directory(dir.path + "assets/$groupId/videos/");
  }

  Future<Directory> getDownloadDirectoryForfilesOfGroup(int groupId) async {
    final dir = await getApplicationDocumentsDirectory();
    return Directory(dir.path + "assets/$groupId/files/");
  }
}
