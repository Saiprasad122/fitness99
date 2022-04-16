import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/add&viewCategories/add_categories_request.dart';
import 'package:fitness_99/views/profile_screen/widget/category_class.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesController extends GetxController {
  final isBusy = false.obs;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final tempCategoriesList = <CategoryClass>[].obs;
  final categoriesApiList = <CategoryClass>[
    CategoryClass(categoryName: 'Cricket', isTicked: false),
    CategoryClass(categoryName: 'Jogging', isTicked: false),
    CategoryClass(categoryName: 'Running', isTicked: false),
    CategoryClass(categoryName: 'Dancing', isTicked: false),
    CategoryClass(categoryName: 'Swimming', isTicked: false),
    CategoryClass(categoryName: 'Skipping', isTicked: false),
  ].obs;
  final searchedCategoriesList = <CategoryClass>[].obs;
  final searchCategoryTED = TextEditingController();
  final textToShow = ''.obs;

  @override
  void onInit() {
    getCategories();
    tempCategoriesList.addAll(categoriesApiList);
    print("The length of temp list is ${tempCategoriesList.length}");
    super.onInit();
  }

  void changeVisibility(int i) {
    categoriesApiList[i].isTicked = !(categoriesApiList[i].isTicked);
    update();
  }

  void searchCatgoryMethod(String text) {
    if (text.isNotEmpty) {
      searchedCategoriesList.clear();
      tempCategoriesList.forEach(
        (element) {
          searchedCategoriesList.addIf(
              element.categoryName.toLowerCase().startsWith(text.toLowerCase()),
              element);
          if (searchedCategoriesList.isEmpty) {
            textToShow.value = 'No Groups were found';
            categoriesApiList.clear();
          }
        },
      );
    } else if (text.isEmpty) {
      categoriesApiList.clear();
      categoriesApiList.addAll(tempCategoriesList);
      searchedCategoriesList.clear();
    }

    print("The length of searched is ${searchedCategoriesList.length}");
    print("The length of category list is ${categoriesApiList.length}");
  }

  void updateCategoryList() async {
    isBusy.value = true;
    var finalCategoryList = '';
    categoriesApiList.forEach((element) {
      if (element.isTicked) {
        finalCategoryList = '${finalCategoryList + element.categoryName},';
      }
    });
    if (categoriesApiList.isNotEmpty) {
      try {
        AddCategoriesRequest body = AddCategoriesRequest(
            categories: finalCategoryList,
            user_id: userModel.getid().toString());

        final response = await apiService.addCategories(body);
        if (response.message!.toLowerCase().contains('success')) {
          Get.back();
          customSnackBar(
            title: 'Categories Updated',
            message: 'Catgories Updated Successfully',
            isSuccess: true,
          );
        }
      } on DioError catch (e) {
        if (e.response!.statusCode == 400 &&
            e.response!.data['categories']
                .toString()
                .toLowerCase()
                .contains('categories field is required')) {
          customSnackBar(
            title: 'No categories selected!',
            message: 'Please select any categories and update',
            isSuccess: false,
          );
        } else {
          print(e);
          customSnackBar(
            title: 'Error!',
            message: 'Please try again later',
            isSuccess: false,
          );
        }
      }
    }
    isBusy.value = false;
  }

  void getCategories() async {
    isBusy.value = true;
    try {
      final response =
          await apiService.getCategories(user_id: userModel.getid());
      if (response.data != null) {
        final categoriesList =
            response.data!.categories.toLowerCase().split(',').toList();
        for (int i = 0; i < categoriesApiList.length; i++) {
          if (categoriesList
              .contains(categoriesApiList[i].categoryName.toLowerCase())) {
            categoriesApiList[i].isTicked = true;
          }
        }
      } else {
        customSnackBar(
          title: 'Error!',
          message: 'Please try again later',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      print(e);
      customSnackBar(
        title: 'Error!',
        message: 'Please try again later',
        isSuccess: false,
      );
    }
    isBusy.value = false;
  }
}
