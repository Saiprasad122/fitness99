import 'package:dio/dio.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/cando_cannotdo_goal/cando_cannotdo_goal.response.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PersonalGoalsController extends GetxController {
  final apiService = Get.find<ApiService>();
  final userModel = Get.find<UserModelService>();
  final isLoading = true.obs;
  final isError = true.obs;
  final isNewGoalAdding = false.obs;
  final TextEditingController goalTED = TextEditingController();
  final errorTextForTextField = ''.obs;
  final List<GetCanDoCannotDoGoals> goals = [];
  @override
  void onInit() {
    super.onInit();
    getGoals();
    print(userModel.id);
  }

  void getGoals() async {
    isLoading.value = true;
    isError.value = false;
    try {
      final res = await apiService.getGoals(userId: userModel.getid());
      if (res.data != null) {
        goals.addAll(res.data!);
      }
      // isLoading = false.obs;
    } on DioError catch (e) {
      print(e);
      isError.value = true;
    } finally {
      isLoading.value = false;
    }
  }

  void onRefresh() {
    goals.clear();
    getGoals();
  }

  void addGoal() async {
    if (validateGoal(goalTED.text.trim())) {
      isNewGoalAdding.value = true;
      errorTextForTextField.value = '';

      try {
        final res = await apiService.createGoal(
            createGoalRequest: {'goal': goalTED.text.trim()},
            userId: userModel.getid());
        if (res.status == 200 ||
            (res.message?.toLowerCase().contains('success') ?? false)) {
          customSnackBar(
            title: 'Success',
            message: 'Goal has been added successfully',
            isSuccess: true,
          );
          onRefresh();
          goalTED.clear();
          Get.back();
        } else {
          customSnackBar(
            title: 'Failed',
            message: 'Adding goal failed due to some error',
            isSuccess: false,
          );
        }
      } on DioError catch (e) {
        print(e);
      } finally {
        isNewGoalAdding.value = false;
      }
    }
  }

  void deleteItem(int id) async {
    try {
      final res = await apiService.deleteGoal(goalId: id);
      if (res.status == 200 ||
          (res.message?.toLowerCase().contains('success') ?? false)) {
        customSnackBar(
          title: 'Success',
          message: 'Goal has been deleted successfully',
          isSuccess: true,
        );
        onRefresh();
      } else {
        customSnackBar(
          title: 'Failed',
          message: 'Deleting goal failed due to some error',
          isSuccess: false,
        );
      }
    } on DioError catch (e) {
      print(e);
    }
  }

  bool validateGoal(String goal) {
    if (goal.isEmpty) {
      errorTextForTextField.value = 'Goal cannot be empty';
      return false;
    }
    return true;
  }
}
