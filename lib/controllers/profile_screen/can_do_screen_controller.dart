import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/cando_cannotdo_goal/cando_cannotdo_goal.response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CanDoController extends GetxController {
  CanDoController({required this.user_id});
  final user_id;
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final isLoading = true.obs;
  final isError = true.obs;
  final isNewCanDoAdding = false.obs;
  final TextEditingController canDoTED = TextEditingController();
  final errorTextForTextField = ''.obs;

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
      final res = await apiService.getCanDos(userId: user_id);
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
            title: 'Success',
            message: 'Can Do has been added successfullt',
            isSuccess: true,
          );
          onRefresh();
          canDoTED.clear();
          Get.back();
        } else {
          customSnackBar(
            title: 'Failed',
            message: 'Adding Can Do failed due to some error',
            isSuccess: false,
          );
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
          title: 'Success',
          message: 'Can Do has been deleted successfully',
          isSuccess: true,
        );
        onRefresh();
      } else {
        customSnackBar(
          title: 'Failed',
          message: 'Deleting Can Do failed due to some error',
          isSuccess: false,
        );
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
