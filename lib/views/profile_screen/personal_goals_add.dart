import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
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
          SizedBox(height: 20),
          CustomProfileTextField(
            displayText: 'Personal Goal',
            hintText: 'Enter your personal gaol here',
          ),
          Spacer(),
          GestureDetector(
            child: Container(
              height: 50,
              color: Colors.lightBlueAccent,
              child: Center(
                child: Text(
                  'AddNew',
                  style: TextStyles.sgproMedium.f20.white,
                ),
              ),
            ),
            onTap: () => Get.toNamed(Routes.PersonalGoalsAdd),
          ),
        ],
      ),
    );
  }
}
