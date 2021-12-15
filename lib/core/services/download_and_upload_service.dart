import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:http/http.dart' as http;

class DownloadAndUploadService extends GetxController {
  // Future<void> downloadImageFromFirebase(Reference ref) async {
  //   final String url = await ref.getDownloadURL();
  //   final String name = await ref.name;

  //   final http.Response downloadData = await http.get(
  //     Uri.parse(url),
  //   );

  //   final File tempFile = File('${systemTempDir.path}/tmp.jpg');
  //   if (tempFile.existsSync()) {
  //     await tempFile.delete();
  //   }
  //   await tempFile.create();
  //   final DownloadTask task = ref.writeToFile(tempFile);
  //   final int byteCount = task.snapshot.totalBytes;
  //   var bodyBytes = downloadData.bodyBytes;
  //   final String path = await ref.fullPath;
  // }

  Future<String?> uploadImageToFirebase(int groupId, File file,
      Function(double progressPercent)? progressListener) async {
    final fileName =
        'images/$groupId/image-$groupId-${DateTime.now().millisecondsSinceEpoch}';
    final _firebaseStorage = FirebaseStorage.instance;
    var upload =
        _firebaseStorage.ref().child(fileName).putFile(file).catchError(() {
      return null;
    });
    upload.asStream().listen((event) {
      progressListener?.call((event.bytesTransferred / event.totalBytes) * 100);
    });
    await upload;
    return fileName;
  }
}
