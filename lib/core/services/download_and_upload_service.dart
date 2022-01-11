import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_99/core/services/get_directories.dart';
import 'package:fitness_99/global/router/views.export.dart';
// import 'package:http/http.dart' as http;

class DownloadAndUploadService extends GetxController {
  final directoryService = Get.find<DirectoriesService>();
  Future<File?> downloadImageFromFirebase(
      String downloadUrl,
      int groupId,
      void Function(double progressPercent, String? imageFilePath)?
          progressListener,
      void Function(File localFile)? onDoneListener) async {
    try {
      final directories = Get.find<DirectoriesService>();
      final ref = FirebaseStorage.instance.refFromURL(downloadUrl);
      // final String url = await ref.getDownloadURL();
      final String name = await ref.name;

      // final http.Response downloadData = await http.get(
      //   Uri.parse(url),
      // );

      final File tempFile =
          File('${directories.getImagesPath(groupId.toString())}$name.jpg');
      if (tempFile.existsSync()) {
        await tempFile.delete();
      }
      await tempFile.create(recursive: true);
      final downloadTask = ref.writeToFile(tempFile);
      downloadTask.onError((e, s) {
        log('Error while download', error: e, stackTrace: s);
        throw NullThrownError();
      });
      downloadTask.asStream().listen((event) {
        progressListener?.call(
            (event.bytesTransferred / event.totalBytes) * 100,
            '${directories.getImagesPath(groupId.toString())}$name.jpg');
      });
      await downloadTask;
      onDoneListener?.call(tempFile);
      return tempFile;
    } catch (e) {
      return null;
    }
  }

  Future<String> getFileNameFromDownloadUrl(String downloadUrl) async {
    final ref = FirebaseStorage.instance.refFromURL(downloadUrl);
    return (await ref.name);
  }

  Future<String?> uploadImageToFirebase(int groupId, File file,
      Function(double progressPercent)? progressListener) async {
    try {
      final fileName =
          'image-$groupId-${DateTime.now().millisecondsSinceEpoch}';

      final File tempFile = File(
          directoryService.getImagesPath(groupId.toString()) +
              fileName +
              '.jpg');
      if (tempFile.existsSync()) {
        await tempFile.delete();
      }
      await tempFile.create(recursive: true);
      final newFile = await directoryService.moveFile(
          file,
          directoryService.getImagesPath(groupId.toString()) +
              fileName +
              '.jpg');
      final _firebaseStorage = FirebaseStorage.instance;
      final uploadRef = _firebaseStorage.ref(fileName);
      final upload = uploadRef.putFile(newFile);
      upload.snapshotEvents.listen((event) {
        progressListener
            ?.call((event.bytesTransferred / event.totalBytes) * 100);
      });
      await upload;
      return await uploadRef.getDownloadURL();
    } catch (e) {
      print('The error is $e');
      return null;
    }
  }

  Future<String?> uploadFilesToFirebase(
      int groupId,
      File file,
      String extension,
      Function(double progressPercent)? progressListener) async {
    try {
      final fileName =
          'files-$groupId-${DateTime.now().millisecondsSinceEpoch}';

      final File tempFile = File(
          directoryService.getFilesPath(groupId.toString()) +
              fileName +
              '.$extension');
      if (tempFile.existsSync()) {
        await tempFile.delete();
      }
      await tempFile.create(recursive: true);
      final newFile = await directoryService.moveFile(
          file,
          directoryService.getFilesPath(groupId.toString()) +
              fileName +
              '.$extension');
      final _firebaseStorage = FirebaseStorage.instance;
      final uploadRef = _firebaseStorage.ref(fileName);
      final upload = uploadRef.putFile(newFile);
      upload.snapshotEvents.listen((event) {
        progressListener
            ?.call((event.bytesTransferred / event.totalBytes) * 100);
      });
      await upload;
      return await uploadRef.getDownloadURL();
    } catch (e) {
      print('The error is $e');
      return null;
    }
  }
}
