import 'dart:developer';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:fitness_99/core/services/get_directories.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:media_info/media_info.dart';
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

  Future<List<File>?> downloadVideoFromFirebase(
      String downloadUrl,
      int groupId,
      String extension,
      void Function(double progressPercent, String? videoFilePath)?
          progressListener,
      void Function(File localVideoFile, File localThumbnailFile)?
          onDoneListener) async {
    try {
      final directories = Get.find<DirectoriesService>();
      final ref = FirebaseStorage.instance.refFromURL(downloadUrl);
      final String name = await ref.name;

      final File tempFile = File(
          '${directories.getVideosPath(groupId.toString())}$name.$extension');
      final File tempThumbnailFile = File(
          '${directories.getVideosPath(groupId.toString())}${name}_thumbnail.$extension');
      if (tempFile.existsSync()) {
        await tempFile.delete();
      }
      await tempFile.create(recursive: true);
      if (tempThumbnailFile.existsSync()) {
        await tempThumbnailFile.delete();
      }
      await tempThumbnailFile.create(recursive: true);
      final downloadTask = ref.writeToFile(tempFile);
      final thumbnailDownloadTask = ref.writeToFile(tempThumbnailFile);

      downloadTask.onError((e, s) {
        log('Error while download', error: e, stackTrace: s);
        throw NullThrownError();
      });
      downloadTask.asStream().listen((event) {
        progressListener?.call(
            (event.bytesTransferred / event.totalBytes) * 100,
            '${directories.getVideosPath(groupId.toString())}$name.mp4');
      });
      await Future.wait([downloadTask, thumbnailDownloadTask]);
      onDoneListener?.call(tempFile, tempThumbnailFile);
      return [tempFile, tempThumbnailFile];
    } catch (e) {
      return null;
    }
  }

  Future<String> getFileNameFromDownloadUrl(String downloadUrl) async {
    final ref = FirebaseStorage.instance.refFromURL(downloadUrl);
    return (await ref.name);
  }

  Future<String?> uploadImageToFirebase(int groupId, File file,
      Function(double progressPercent)? progressListener,
      {String? directFileName}) async {
    try {
      final fileName = directFileName ??
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

  Future<String> createThumbnail(String sorucePath, String target) async {
    await MediaInfo().generateThumbnail(sorucePath, target, 512, 512);
    return target;
  }

  Future<List<String>?> uploadVideoToFirebase(int groupId, File file,
      String extension, Function(double progressPercent)? progressListener,
      {String? directFileName, String? directThumnailFileName}) async {
    try {
      final fileName = directFileName ??
          'video-$groupId-${DateTime.now().millisecondsSinceEpoch}';
      final thumbnailFileName = directThumnailFileName ??
          'video-$groupId-${DateTime.now().millisecondsSinceEpoch}' +
              '_thumbnail';

      final File tempFile = File(
          directoryService.getVideosPath(groupId.toString()) +
              fileName +
              '.$extension');

      if (tempFile.existsSync()) {
        await tempFile.delete();
      }
      await tempFile.create(recursive: true);
      final thumbnailFilePath = await createThumbnail(
          file.path,
          directoryService.getVideosPath(groupId.toString()) +
              thumbnailFileName +
              '.jpg');

      final newFile = await directoryService.moveFile(
          file,
          directoryService.getVideosPath(groupId.toString()) +
              fileName +
              '.$extension');
      final _firebaseStorage = FirebaseStorage.instance;
      final uploadRef = _firebaseStorage.ref(fileName);
      final upload = uploadRef.putFile(newFile);
      upload.snapshotEvents.listen((event) {
        progressListener
            ?.call((event.bytesTransferred / event.totalBytes) * 100);
      });
      final thumbnailUploadRef = _firebaseStorage.ref(thumbnailFileName);
      final thumbnailUpload =
          thumbnailUploadRef.putFile(File(thumbnailFilePath));
      await Future.wait([upload, thumbnailUpload]);
      final uploadRefDownLoadUrl = await uploadRef.getDownloadURL();
      final thumbnailUploadRefDownLoadUrl =
          await thumbnailUploadRef.getDownloadURL();

      return [uploadRefDownLoadUrl, thumbnailUploadRefDownLoadUrl];
    } catch (e) {
      print('The error is $e');
      return null;
    }
  }

  Future<String?> uploadFilesToFirebase(int groupId, File file,
      String extension, Function(double progressPercent)? progressListener,
      {String? directFileName}) async {
    try {
      final fileName = directFileName ??
          'files-$groupId-${DateTime.now().millisecondsSinceEpoch}-${file.path.substring(
            file.path.lastIndexOf('/') + 1,
            file.path.lastIndexOf('.'),
          )}';

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

  Future<File?> downloadFileFromFirebase(
      String downloadUrl,
      String extention,
      int groupId,
      void Function(double progressPercent, String? filePath)? progressListener,
      void Function(File localFile)? onDoneListener) async {
    try {
      final directories = Get.find<DirectoriesService>();
      final ref = FirebaseStorage.instance.refFromURL(downloadUrl);
      final String name = await ref.name;

      final File tempFile = File(
          '${directories.getFilesPath(groupId.toString())}$name.$extention');
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
            '${directories.getFilesPath(groupId.toString())}$name.$extention');
      });
      await downloadTask;
      onDoneListener?.call(tempFile);
      return tempFile;
    } catch (e) {
      return null;
    }
  }
}
