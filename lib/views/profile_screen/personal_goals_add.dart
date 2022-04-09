import 'package:fitness_99/controllers/profile_screen/persoal_goals_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalGoalsAdd extends StatelessWidget {
  final _controller = Get.find<PersonalGoalsController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Personal Goals',
          style: TextStyles.sgproBold.f26.black,
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
              displayText: 'Personal Goal',
              hintText: 'Enter your personal goal here',
              errText: _controller.errorTextForTextField.value,
              textEditingController: _controller.goalTED,
            );
          }),
          Spacer(),
          Obx(() {
            return CustomBottomButton(
              text: 'Submit',
              onTap: _controller.addGoal,
              isLoading: _controller.isNewGoalAdding.value,
            );
          }),
        ],
      ),
    );
  }
}
