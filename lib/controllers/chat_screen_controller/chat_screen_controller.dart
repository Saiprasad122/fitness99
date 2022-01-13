import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fitness_99/controllers/chat_screen_controller/mssg_type_enum.dart';
import 'package:fitness_99/core/services/download_and_upload_service.dart';
import 'package:fitness_99/core/services/get_directories.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/app_pages.dart';
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
  final picker = ImagePicker();
  final extension = ''.obs;

  void initializeChat(int group_id) {
    imagesOfGroup.clear();
    filesOfGroup.clear();
    this.group_id = group_id;
    imagesOfGroup
        .addAll(directoryService.getImagesOfGroup(group_id.toString()));
    filesOfGroup.addAll(directoryService.getFilesOfGroup(group_id.toString()));
    print(imagesOfGroup);
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
          extension: '.jpg',
          sizeInKB: sizeInKB);
    } else {
      print('error');
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
      Get.toNamed(Routes.VideoChatComponent);
    } else {
      filePath.value = '';
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

  @override
  void dispose() {
    chatListStream.close();
    super.dispose();
  }
}
