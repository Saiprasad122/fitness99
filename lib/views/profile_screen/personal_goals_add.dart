import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalGoalsAdd extends StatelessWidget {
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
          SizedBox(height: 20),
          CustomProfileTextField(
            displayText: 'Personal Goal',
            hintText: 'Enter your personal gaol here',
          ),
          Spacer(),
          CustomBottomButton(
            text: 'Submit',
            onTap: () => Get.toNamed(Routes.CannotDoAdd),
          ),
        ],
      ),
    );
  }
}
