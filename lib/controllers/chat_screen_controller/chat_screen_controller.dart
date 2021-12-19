import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
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
  final picker = ImagePicker();

  void initializeChat(int group_id) {
    this.group_id = group_id;
    imagesOfGroup
        .addAll(directoryService.getImagesOfGroup(group_id.toString()));
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
    final file = await picker.pickVideo(source: ImageSource.gallery);
    if (file != null) {
      filePath.value = file.path;

      Get.toNamed(Routes.VideoChatComponent);
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
