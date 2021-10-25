import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/cando_cannotdo_goal/cando_cannotdo_goal.response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CanDoController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  RxBool isLoading = true.obs;
  RxBool isError = true.obs;
  RxBool isNewCanDoAdding = false.obs;
  final TextEditingController canDoTED = TextEditingController();
  RxString errorTextForTextField = ''.obs;

  final List<GetCanDoCannotDoGoals> canDos = [];
  @override
  void onInit() {
    super.onInit();
    getcanDos();
  }

  void getcanDos() async {
    isLoading.value = true;
    isError.value = false;
    try {
      final res = await apiService.getCanDos(userId: userModel.getid());
      if (res.data != null) {
        canDos.addAll(res.data!);
      }
    } on DioError catch (e) {
      print(e);
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void onRefresh() {
    canDos.clear();
    getcanDos();
  }

  void addCanDo() async {
    if (validatecanDo(canDoTED.text.trim())) {
      isNewCanDoAdding.value = true;
      errorTextForTextField.value = '';

      try {
        final res = await apiService.createCanDo(
            createCanDoRequest: {'can_do': canDoTED.text.trim()},
            userId: userModel.getid());
        if (res.status == 200 ||
            (res.message?.toLowerCase().contains('success') ?? false)) {
          customSnackBar(
              'Success', 'Can Do has been added successfullt', 'success');
          onRefresh();
          canDoTED.clear();
        } else {
          customSnackBar(
              'Failed', 'Adding Can Do failed due to some error', 'fail');
        }
      } on DioError catch (e) {
        print(e);
      } finally {
        isNewCanDoAdding.value = false;
      }
    }
  }

  void deleteItem(int id) async {
    try {
      final res = await apiService.deleteCanDo(canDoId: id);
      if (res.status == 200 ||
          (res.message?.toLowerCase().contains('success') ?? false)) {
        customSnackBar(
            'Success', 'Can Do has been deleted successfullt', 'success');
        onRefresh();
      } else {
        customSnackBar(
            'Failed', 'Deleting Can Do failed due to some error', 'fail');
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  bool validatecanDo(String canDo) {
    if (canDo.isEmpty) {
      errorTextForTextField.value = 'Can Do cannot be empty';
      return false;
    }
    return true;
  }
}
