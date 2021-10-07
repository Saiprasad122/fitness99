import 'package:fitness_99/views/profile_screen/widget/category_class.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final categoriesName = [
    CategoryClassModel(categoryName: 'Swimming', isTicked: false),
    CategoryClassModel(categoryName: 'Dancing', isTicked: false),
    CategoryClassModel(categoryName: 'Jogging', isTicked: false)
  ];

  void changeVisibility(int i) {
    if (!categoriesName[i].isTicked) {
      categoriesName[i].isTicked = true;
      print(categoriesName[i].isTicked);
    } else {
      categoriesName[i].isTicked = false;
      print(categoriesName[i].isTicked);
    }
  }
}
