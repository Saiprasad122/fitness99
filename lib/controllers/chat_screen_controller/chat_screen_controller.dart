import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/controllers/chat_screen_controller/mssg_type_enum.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/image_chat_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ChatScreenController extends GetxController {
  TextEditingController chatTED = TextEditingController();
  final instance = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> chatList = [];
  final chatListStream =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  final userModel = Get.find<UserModelService>();
  final List<Map<String, dynamic>> demoList = [];
  final scrollController = ScrollController();
  late int group_id;
  final filePath = ''.obs;

  void initializeChat(int group_id) {
    this.group_id = group_id;
  }

  void addData({
    required String mssg,
    String url = '',
    MessageType messageType = MessageType.text,
  }) {
    MessageType messageType = MessageType.text;

    instance
        .collection('groups')
        .doc(group_id.toString())
        .collection('chats')
        .add({
      'id': userModel.getid().toString(),
      'message': mssg,
      'messageType': messageType.toString(),
      'time': DateTime.now(),
      'imageURl': userModel.getProfilePicture(),
      'url': url
    }).then((value) => chatTED.clear());
  }

  getImage(ImageSource source) async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: source);
    if (file != null) {
      // final img = File(file.path);
      String fileName = file.path.split('/').last;
      filePath.value = file.path;
      Get.to(ImageChatComponent());
      // final cropImage = await ImageCropper.cropImage(
      //   sourcePath: file.path,
      //   aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      //   maxHeight: 300,
      //   maxWidth: 300,
      //   androidUiSettings: AndroidUiSettings(hideBottomControls: true),
      // );
    }
  }

  @override
  void dispose() {
    chatListStream.close();
    super.dispose();
  }
}
