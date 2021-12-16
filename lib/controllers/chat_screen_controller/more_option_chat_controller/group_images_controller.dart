import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:get/get.dart';

class GroupImagesListController extends GetxController {
  List<String> imagesList = [];
  final chatScreenController = Get.find<ChatScreenController>();

  @override
  void onInit() async {
    final doc = await FirebaseFirestore.instance
        .collection('groups')
        .doc(chatScreenController.group_id.toString())
        .collection('chats')
        .orderBy('time', descending: true)
        .get();
    doc.docs.forEach((element) {
      print('THe element is-------${element.data()}');
    });

    super.onInit();
  }
}
