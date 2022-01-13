import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/cando_cannotdo_goal/cando_cannotdo_goal.response.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class CannotDoController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final isLoading = true.obs;
  final isError = true.obs;
  final isNewCannotDoAdding = false.obs;
  final errorTextForTextField = ''.obs;
  final TextEditingController cannotDoTED = TextEditingController();
  final List<GetCanDoCannotDoGoals> cannotDo = [];
  @override
  void onInit() {
    super.onInit();
    getCannotDos();
  }

  void getCannotDos() async {
    isLoading.value = true;
    isError.value = false;
    try {
      final res = await apiService.getCannotDos(userId: userModel.getid());
      if (res.data != null) {
        cannotDo.addAll(res.data!);
      }
    } on DioError catch (e) {
      print(e);
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void onRefresh() {
    cannotDo.clear();
    getCannotDos();
  }

  void addCannotDo() async {
    if (validatecannotDo(cannotDoTED.text.trim())) {
      isNewCannotDoAdding.value = true;
      errorTextForTextField.value = '';

      try {
        final res = await apiService.createCannotDo(
            createCannotDoRequest: {'cannot_do': cannotDoTED.text.trim()},
            userId: userModel.getid());
        if (res.status == 200 ||
            (res.message?.toLowerCase().contains('success') ?? false)) {
          customSnackBar(
            title: 'Success',
            message: 'Cannot Do has been added successfullt',
            isSuccess: true,
          );
          cannotDoTED.clear();
          onRefresh();
        } else {
          customSnackBar(
            title: 'Failed',
            message: 'Adding Cannot Do failed due to some error',
            isSuccess: false,
          );
        }
      } on DioError catch (e) {
        print(e);
      } finally {
        isNewCannotDoAdding.value = false;
      }
    }
  }

  void deleteItem(int id) async {
    try {
      final res = await apiService.deleteCannotDo(cannotDoId: id);
      if (res.status == 200 ||
          (res.message?.toLowerCase().contains('success') ?? false)) {
        customSnackBar(
          title: 'Success',
          message: 'Cannot Do has been deleted successfullt',
          isSuccess: true,
        );
        onRefresh();
      } else {
        customSnackBar(
          title: 'Failed',
          message: 'Deleting Cannot Do failed due to some error',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  bool validatecannotDo(String cannotDo) {
    if (cannotDo.isEmpty) {
      errorTextForTextField.value = 'Cannot Do cannot be empty';
      return false;
    }
    return true;
  }
}
