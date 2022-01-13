import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fitness_99/controllers/chat_screen_controller/mssg_type_enum.dart';
import 'package:fitness_99/core/services/download_and_upload_service.dart';
import 'package:fitness_99/core/services/get_directories.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/video_chat_component_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreenController extends GetxController {
  TextEditingController chatTED = TextEditingController();
  final uploadImageService = Get.find<DownloadAndUploadService>();
  final directoryService = Get.find<DirectoriesService>();
  final instance = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> chatList = [];
  final chatListStream =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  final userModel = Get.find<UserModelService>();
  final List<Map<String, dynamic>> demoList = [];
  final scrollController = ScrollController();
  late int group_id;
  final filePath = ''.obs;
  final List<String> imagesOfGroup = [];
  final List<String> filesOfGroup = [];
  final List<String> videosOfGroup = [];
  final picker = ImagePicker();
  final extension = ''.obs;

  void initializeChat(int group_id) {
    imagesOfGroup.clear();
    filesOfGroup.clear();
    videosOfGroup.clear();
    this.group_id = group_id;
    imagesOfGroup
        .addAll(directoryService.getImagesOfGroup(group_id.toString()));
    filesOfGroup.addAll(directoryService.getFilesOfGroup(group_id.toString()));
    videosOfGroup
        .addAll(directoryService.getVideosOfGroup(group_id.toString()));
  }

  Future<String?> getLocalImagePathFromDownloads(String url) async {
    final name = await uploadImageService.getFileNameFromDownloadUrl(url);

    final fileName = imagesOfGroup
        .firstWhere((element) => element.contains(name), orElse: () {
      return '';
    });
    return fileName.isEmpty
        ? null
        : directoryService.getImagesPath(group_id.toString()) + fileName;
  }

  Future<File?> getLocalImageFromDownloads(String url) async {
    final filePath = await getLocalImagePathFromDownloads(url);

    if (filePath != null) {
      try {
        final file = File(filePath + '.jpg');
        return file;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<String?> getLocalVideoPathFromDownloads(String url) async {
    final name = await uploadImageService.getFileNameFromDownloadUrl(url);
    final videoName = videosOfGroup
        .firstWhere((element) => element.contains(name), orElse: () {
      return '';
    });
    return videoName.isEmpty
        ? null
        : directoryService.getVideosPath(group_id.toString()) + videoName;
  }

  Future<File?> getLocalVideoFromDownloads(String url) async {
    String? videoPath = await getLocalVideoPathFromDownloads(url);

    if (videoPath != null) {
      print('The total file path is $videoPath');
      try {
        videoPath = videoPath.replaceAll("'", '');
        final videoFile = File(videoPath);
        print('THe real path is ${videoFile.path}');
        return videoFile;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<File?> getLocalVideoThumbNailFromDownloads(String url) async {
    String? videoPath = await getLocalVideoPathFromDownloads(url);

    if (videoPath != null) {
      print('The total file path is $videoPath');
      try {
        videoPath = videoPath.replaceAll("'", '');
        final videoFile = File(videoPath);
        print('THe real path is ${videoFile.path}');
        return videoFile;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  Future<String?> getLocalFilePathFromDownloads(String url) async {
    final name = await uploadImageService.getFileNameFromDownloadUrl(url);
    final fileName = filesOfGroup
        .firstWhere((element) => element.contains(name), orElse: () {
      return '';
    });
    return fileName.isEmpty
        ? null
        : directoryService.getFilesPath(group_id.toString()) + fileName;
  }

  Future<File?> getLocalFileFromDownloads(String url, String extension) async {
    String? filePath = await getLocalFilePathFromDownloads(url);

    if (filePath != null) {
      print('The total file path is $filePath');
      try {
        filePath = filePath.replaceAll("'", '');
        final file = File(filePath + '.$extension');
        print('THe real path is ${file.path}');
        return file;
      } catch (e) {
        return null;
      }
    } else {
      return null;
    }
  }

  void downloadImage(String url,
      {void Function(double progressPercent, String? imageFilePath)?
          progressListener,
      void Function(File localFile)? onDoneListener}) async {
    await uploadImageService.downloadImageFromFirebase(
      url,
      group_id,
      progressListener,
      onDoneListener,
    );
  }

  void downloadVideo(String url, String? extension,
      {void Function(double progressPercent, String? videoFilePath)?
          progressListener,
      void Function(File localVideoFile, File localThumbnailFile)?
          onDoneListener}) async {
    await uploadImageService.downloadVideoFromFirebase(
      url,
      group_id,
      extension ?? 'mp4',
      progressListener,
      onDoneListener,
    );
  }

  void downloadFile(String url, String extension,
      {void Function(double progressPercent, String? FilePath)?
          progressListener,
      void Function(File localFile)? onDoneListener}) async {
    await uploadImageService.downloadFileFromFirebase(
      url,
      extension,
      group_id,
      progressListener,
      onDoneListener,
    );
  }

  void addData({
    String messageType = MessageType.text,
    String? extension,
    String? fileName,
    String? thumbnailUrl,
    double? sizeInKB,
  }) {
    if (chatTED.text.isNotEmpty || filePath.value.isNotEmpty) {
      final data = {
        'id': userModel.getid().toString(),
        'messageType': messageType,
        'time': DateTime.now(),
        'imageURl': userModel.getProfilePicture(),
      };
      if (chatTED.text.isNotEmpty) {
        data.addAll({'message': chatTED.text});
      }
      if (fileName != null) {
        data.addAll({'fileName': fileName});
      }
      if (extension != null) {
        data.addAll({'extension': extension});
      }
      if (filePath.value.isNotEmpty) {
        data.addAll({'url': filePath.value});
      }
      if (sizeInKB != null) {
        data.addAll({'sizeInKB': sizeInKB});
      }
      if (thumbnailUrl != null) {
        data.addAll({'thumbnailUrl': thumbnailUrl});
      }

      instance
          .collection('groups')
          .doc(group_id.toString())
          .collection('chats')
          .add(data)
          .then((value) {
        chatTED.clear();
        filePath.value = '';
      });
    }
  }

  Future<void> uploadImage() async {
    Get.back();
    final fileName =
        'image-$group_id-${DateTime.now().millisecondsSinceEpoch}-${filePath.value.substring(
      filePath.value.lastIndexOf('/') + 1,
      filePath.value.lastIndexOf('.'),
    )}';
    final file = File(filePath.value);
    final double sizeInKB = file.readAsBytesSync().lengthInBytes / 1024;
    String? path = await uploadImageService.uploadImageToFirebase(
        group_id, file, (progressPercent) {},
        directFileName: fileName);
    if (path?.isNotEmpty ?? false) {
      filePath.value = path!;
      initializeChat(group_id);

      addData(
          messageType: MessageType.image,
          fileName: fileName,
          extension: 'jpg',
          sizeInKB: sizeInKB);
    } else {
      print('error');
    }
  }

  Future<void> uploadVideo() async {
    Get.back();
    final fileName =
        'video-$group_id-${DateTime.now().millisecondsSinceEpoch}-${filePath.value.substring(
      filePath.value.lastIndexOf('/') + 1,
      filePath.value.lastIndexOf('.'),
    )}';
    final thumbnailFileName = '${fileName}_thumbnail';
    final file = File(filePath.value);
    final indexOfLastDot = file.path.lastIndexOf('.');
    extension.value = file.path.substring(indexOfLastDot + 1);
    final double sizeInKB = file.readAsBytesSync().lengthInBytes / 1024;
    List<String>? path = await uploadImageService.uploadVideoToFirebase(
      group_id,
      file,
      extension.value,
      (progressPercent) {},
      directFileName: fileName,
      directThumnailFileName: thumbnailFileName,
    );
    if (path?.isNotEmpty ?? false) {
      filePath.value = path![0];
      initializeChat(group_id);
      addData(
        messageType: MessageType.video,
        fileName: fileName,
        extension: extension.value,
        sizeInKB: sizeInKB,
        thumbnailUrl: path[1],
      );
    } else {
      print('error');
    }
  }

  Future<void> uploadDocument() async {
    Get.back();
    final file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'zip', 'wps', 'ppt', 'pptx', 'doc'],
    );
    if (file != null) {
      filePath.value = file.files[0].path!;
      final indexOfLastDot = file.files[0].path!.lastIndexOf('.');
      extension.value = file.files[0].path!.substring(indexOfLastDot + 1);
      final fileName =
          'files-$group_id-${DateTime.now().millisecondsSinceEpoch}-${filePath.value.substring(
        filePath.value.lastIndexOf('/') + 1,
        filePath.value.lastIndexOf('.'),
      )}';
      final uploadingFile = File(filePath.value);
      final double sizeInKB =
          uploadingFile.readAsBytesSync().lengthInBytes / 1024;
      String? path = await uploadImageService.uploadFilesToFirebase(
        group_id,
        uploadingFile,
        extension.value,
        (progressPercent) {},
        directFileName: fileName,
      );
      initializeChat(group_id);
      filePath.value = path!;
      addData(
        messageType: MessageType.document,
        extension: extension.value,
        fileName: fileName,
        sizeInKB: sizeInKB,
      );
    }
  }

  getImage(ImageSource source) async {
    final file = await picker.pickImage(source: source);
    if (file != null) {
      print('THe real path is ${file.path}');
      filePath.value = file.path;
      Get.toNamed(Routes.ImageChatComponent);
    } else {
      filePath.value = '';
    }
  }

  getVideo() async {
    Get.back();
    final file = await picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      filePath.value = file.path;
      Get.to(
        () => VideoSendFullScreenComponent(
          file: File(filePath.value),
          url: filePath.value,
        ),
      );
    } else {
      filePath.value = '';
    }
  }

  @override
  void dispose() {
    chatListStream.close();
    super.dispose();
  }
}
