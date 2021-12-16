import 'dart:io';

import 'package:path_provider/path_provider.dart';

Future<List<String>> getImagesOfGroup(String groupId) async {
  final dir = await getApplicationDocumentsDirectory();
  final imagesDirectory = Directory(dir.path + "assets/$groupId/images/");

  List<String> images = [];
  final _imagesFile =
      imagesDirectory.listSync(followLinks: false, recursive: true);
  _imagesFile.forEach((img) {
    String imgString = img
        .toString()
        .substring(img.toString().lastIndexOf('/') + 1, img.toString().length);
    images.add(imgString);
  });
  return images;
}

Future<List<String>> getVideosOfGroup(String groupId) async {
  final dir = await getApplicationDocumentsDirectory();
  final videosDirectory = Directory(dir.path + "assets/$groupId/videos/");

  List<String> videos = [];
  final _videosFile =
      videosDirectory.listSync(followLinks: false, recursive: true);
  _videosFile.forEach((vid) {
    String vidString = vid
        .toString()
        .substring(vid.toString().lastIndexOf('/') + 1, vid.toString().length);
    videos.add(vidString);
  });
  return videos;
}

Future<List<String>> getFilesOfGroup(String groupId) async {
  final dir = await getApplicationDocumentsDirectory();
  final filesDirectory = Directory(dir.path + "assets/$groupId/files/");

  List<String> files = [];
  final _filesFile =
      filesDirectory.listSync(followLinks: false, recursive: true);
  _filesFile.forEach((vid) {
    String vidString = vid
        .toString()
        .substring(vid.toString().lastIndexOf('/') + 1, vid.toString().length);
    files.add(vidString);
  });
  return files;
}

//   Future<void> downloadFile(Reference ref) async {
//     final String url = await ref.getDownloadURL();
//     final http.Response downloadData = await http.get(url);
//     final Directory systemTempDir = Directory.systemTemp;
//     final File tempFile = File('${systemTempDir.path}/tmp.jpg');
//     if (tempFile.existsSync()) {
//       await tempFile.delete();
//     }
//     await tempFile.create();
//     final DownloadTask task = ref.writeToFile(tempFile);
//     final int byteCount = (await task.).totalByteCount;
//     var bodyBytes = downloadData.bodyBytes;
//     final String name = await ref.getName();
//     final String path = await ref.getPath();
//     print(url);
//     _scaffoldKey.currentState.showSnackBar(
//       SnackBar(
//         backgroundColor: Colors.white,
//         content: Image.memory(
//           bodyBytes,
//           fit: BoxFit.fill,
//         ),
//       ),
//     );
//   }
// }
