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

  void addData({
    String messageType = MessageType.text,
    String extension = '',
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
      if (filePath.value.isNotEmpty) {
        if (messageType == MessageType.document) {
          data.addAll({'extension': extension});
        } else if (messageType == MessageType.image) {
          data.addAll({'extension': '.jpg'});
        }
        data.addAll({'url': filePath.value});
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
    String? path = await uploadImageService.uploadImageToFirebase(
        group_id,
        File(filePath.value),
        (progressPercent) =>
            print('The percent is --------- $progressPercent'));
    if (path?.isNotEmpty ?? false) {
      filePath.value = path!;
      addData(messageType: MessageType.image);
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
        final file = File(filePath);
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
      allowedExtensions: ['pdf'],
    );
    if (file != null) {
      filePath.value = file.files[0].path!;
      extension.value = file.files[0].path!.contains('pdf') ? 'pdf' : 'docx';
      String? path = await uploadImageService.uploadFilesToFirebase(
        group_id,
        File(filePath.value),
        extension.value,
        (progressPercent) => print('The percent is $progressPercent'),
      );

      filePath.value = path!;
      addData(messageType: MessageType.document, extension: extension.value);
    }
  }

  @override
  void dispose() {
    chatListStream.close();
    super.dispose();
  }
}
