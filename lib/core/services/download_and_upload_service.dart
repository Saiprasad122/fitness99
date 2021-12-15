import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_99/core/services/get_directories.dart';
import 'package:fitness_99/global/router/views.export.dart';
// import 'package:http/http.dart' as http;

class DownloadAndUploadService extends GetxController {
  Future<bool> downloadImageFromFirebase(String imageName, int groupId,
      Function(double progressPercent)? progressListener) async {
    final directories = Get.find<DirectoriesService>();
    final ref = FirebaseStorage.instance.ref(imageName);
    // final String url = await ref.getDownloadURL();
    final String name = await ref.name;

    // final http.Response downloadData = await http.get(
    //   Uri.parse(url),
    // );

    final File tempFile = File(
        '${directories.getDownloadDirectoryForimagesOfGroup(groupId)}/$name.jpg');
    if (tempFile.existsSync()) {
      await tempFile.delete();
    }
    await tempFile.create();
    final downloadTask = ref.writeToFile(tempFile);
    downloadTask.catchError(() {
      return false;
    });
    downloadTask.asStream().listen((event) {
      progressListener?.call((event.bytesTransferred / event.totalBytes) * 100);
    });
    await downloadTask;
    return true;
  }

  Future<String?> uploadImageToFirebase(int groupId, File file,
      Function(double progressPercent)? progressListener) async {
    try {
      final fileName =
          'images/$groupId/image-$groupId-${DateTime.now().millisecondsSinceEpoch}';
      final _firebaseStorage = FirebaseStorage.instance;
      var upload = _firebaseStorage.ref().child(fileName).putFile(file);
      upload.snapshotEvents.listen((event) {
        progressListener
            ?.call((event.bytesTransferred / event.totalBytes) * 100);
      });
      await upload;
      return fileName;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
