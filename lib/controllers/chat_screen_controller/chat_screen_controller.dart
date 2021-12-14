import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/controllers/chat_screen_controller/mssg_type_enum.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatScreenController extends GetxController {
  TextEditingController chatTED = TextEditingController();
  final instance = FirebaseFirestore.instance;
  final List<Map<String, dynamic>> chatList = [];
  final chatListStream =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  final userModel = Get.find<UserModelService>();
  final List<Map<String, dynamic>> demoList = [];
  final scrollController = ScrollController();

  void addData({
    required String mssg,
    required int groupId,
    String url = '',
    MessageType messageType = MessageType.text,
  }) {
    MessageType messageType = MessageType.text;

    instance
        .collection('groups')
        .doc(groupId.toString())
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

  @override
  void dispose() {
    chatListStream.close();
    super.dispose();
  }
}
