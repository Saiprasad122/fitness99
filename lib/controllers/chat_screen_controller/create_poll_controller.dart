import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreatePollController extends GetxController {
  final questionTED = TextEditingController();
  final optionControllerList = <TextEditingController>[
    TextEditingController(),
    TextEditingController(),
  ].obs;
  final questionErrText = ''.obs;
  final optionErrText = ''.obs;
  final isOptionListValid = true.obs;

  void removeElement(int index) {
    optionControllerList.removeAt(index);
  }

  void addElement() {
    if (optionControllerList.length < 4) {
      optionControllerList.add(TextEditingController());
    } else {
      Fluttertoast.showToast(msg: 'Only four options can be added');
    }
  }

  bool validateQuestionTED() {
    if (questionTED.text.isEmpty) {
      questionErrText.value = 'Enter question';
      return false;
    } else {
      questionErrText.value = '';
      return true;
    }
  }

  bool validateOptions() {
    for (int i = 0; i < optionControllerList.length; i++) {
      if (optionControllerList[i].text.isEmpty) {
        isOptionListValid.value = false;
        optionErrText.value = 'Enter all options';
        break;
      } else {
        optionErrText.value = '';
        isOptionListValid.value = true;
      }
    }
    return isOptionListValid.value;
  }

  void onSubmit() {
    validateQuestionTED();
    validateOptions();
    if (validateQuestionTED() && validateOptions()) {
      if (optionControllerList.length < 2) {
        customSnackBar(
          title: 'Two Options Complusory',
          message: 'Add atlest two options',
          isSuccess: false,
        );
      }
      print('All right');
    } else {
      print('No alrigh');
    }
  }
}
