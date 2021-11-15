import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:get/get.dart';

class ChatListController extends GetxController {
  final isAnyGroups = true.obs;
  final isLoading = true.obs;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final groupList = [].obs;
  final collection = FirebaseFirestore.instance.collection('chatRoom');

  @override
  void onInit() {
    getGroupData();
    super.onInit();
  }

  void getGroupData() async {
    isLoading.value = true;
    try {
      final res = await apiService.getGroups(userId: userModel.getid());

      if (res.data != null) {
        if (groupList.isNotEmpty) {
          groupList.clear();
          groupList.addAll(res.data!);
        } else {
          groupList.addAll(res.data!);
        }
        isLoading.value = false;
      }
    } on DioError catch (e) {
      if (e.response!.statusCode == 404) {
        print(e);
      } else {
        print(e);
      }
      print(e);
    } finally {
      isLoading.value = false;
    }
  }

  void addCollection() {
    // collection.doc(userModel.getEmail()).collection('groups').doc().set({});
    collection.doc(userModel.getEmail()).set({});
  }

  void addUser() {
    collection.doc(userModel.getEmail()).set({});
  }

  void getCollection() async {
    var snapshot =
        await collection.doc(userModel.getEmail()).collection('groups').get();
    snapshot.docs.forEach((element) {
      print('THe data is ${element.id}');
    });
  }

  void checkUser() async {
    var snapshot = await collection.get();
    snapshot.docs.forEach((element) {
      print(element.id);
    });
  }
}
