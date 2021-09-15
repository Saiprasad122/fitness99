import 'package:get/get.dart';

class ChatScreenController extends GetxController {
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
