import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/controllers/chat_screen_controller/mssg_type_enum.dart';
import 'package:fitness_99/core/api/api_service.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/widgets/custom_snackbar.dart';
import 'package:fitness_99/models/create_poll_req_response/create_poll_request.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

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

  void onSubmit() async {
    validateQuestionTED();
    validateOptions();
    if (validateQuestionTED() && validateOptions()) {
      if (optionControllerList.length < 2) {
        customSnackBar(
          title: 'Two Options Complusory',
          message: 'Add atlest two options',
          isSuccess: false,
        );
      } else {
        final userModel = Get.find<UserModelService>();
        final chatController = Get.find<ChatScreenController>();

        var uuid = Uuid();
        final _randomId = uuid.v1();
        final req = CreatePollRequest(
          poll_question: questionTED.text,
          user_id: userModel.getid().toString(),
          group_id: chatController.group_id.toString(),
          option1: _getTextFromTextEditingFieldsForOptions(0),
          option2: _getTextFromTextEditingFieldsForOptions(1),
          option3: _getTextFromTextEditingFieldsForOptions(2),
          option4: _getTextFromTextEditingFieldsForOptions(3),
          firebase_id: _randomId,
        );

        final createPollResponse = await Get.find<ApiService>().createPoll(req);
        if (createPollResponse.message?.toLowerCase().contains('success') ??
            false) {
          await chatController.addData(
            messageType: MessageType.poll,
            docId: _randomId,
            message: questionTED.text,
          );
          questionTED.clear();
          for (var i = 0; i < optionControllerList.length; i++) {
            optionControllerList[i].clear();
          }
        } else {
          customSnackBar(
            title: 'Poll Not Created',
            message: 'Issue while creating poll',
            isSuccess: false,
          );
        }
      }
    } else {
      customSnackBar(
        title: 'Poll Not Created',
        message: 'Issue while creating poll',
        isSuccess: false,
      );
    }
  }

  String _getTextFromTextEditingFieldsForOptions(int index) {
    if (optionControllerList.length > index) {
      return optionControllerList[index].text;
    }
    return '';
  }
}
