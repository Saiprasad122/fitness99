import 'package:fitness_99/controllers/profile_screen/cannot_do_screen_controller.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CannotDoAdd extends StatelessWidget {
  const CannotDoAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = Get.find<CannotDoController>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Cannot Do',
          style: TextStyles.sgproMedium.f26.black,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Obx(() {
            return CustomProfileTextField(
              displayText: 'Cannot Do',
              hintText: 'Write here',
              errText: _controller.errorTextForTextField.value,
              textEditingController: _controller.cannotDoTED,
            );
          }),
          const Spacer(),
          Obx(() {
            return CustomBottomButton(
              text: 'Submit',
              onTap: _controller.addCannotDo,
              isLoading: _controller.isNewCannotDoAdding.value,
            );
          }),
        ],
      ),
    );
  }
}
