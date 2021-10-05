import 'package:get/get.dart';

class ProductScreenController extends GetxController {
  final selectedIndex = 1.obs;

  void setSelectedIndex(int value) {
    selectedIndex.value = value;
  }
}
