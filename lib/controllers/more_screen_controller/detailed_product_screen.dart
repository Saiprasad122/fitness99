import 'package:get/get.dart';

class DetailedProductController extends GetxController {
  final noOfItems = 0.obs;

  void addCount() => noOfItems.value++;
  void subCount() {
    if (noOfItems.value > 0) {
      noOfItems.value--;
    }
  }
}
