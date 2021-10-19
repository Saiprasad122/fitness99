import 'package:get/get.dart';

class ChatListController extends GetxController {
  final isAnyGroups = true.obs;
  final isBusy = true.obs;
  @override
  void onInit() {
    Future.delayed(
      Duration(seconds: 3),
      () => isBusy.value = false,
    );
    super.onInit();
  }
}
