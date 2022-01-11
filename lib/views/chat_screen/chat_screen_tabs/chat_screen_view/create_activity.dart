import 'package:fitness_99/controllers/chat_screen_controller/create_activity_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateActiviryScreen extends StatelessWidget {
  final controller = Get.put(CreateActivityController());
  CreateActiviryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Create Activity',
          style: TextStyles.sgproMedium.f26.black,
        ),
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    const SizedBox(height: 15),
                    CustomProfileTextField(
                      displayText: 'Activity Title',
                      hintText: 'Enter Activity Title',
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextField(
                      displayText: 'Activity Description',
                      hintText: 'Enter Activity Description',
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextField(
                      displayText: 'Activity Location',
                      hintText: 'Enter your Location',
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextField(
                      displayText: 'Notes',
                      hintText: 'Enter your Notes',
                    ),
                    const SizedBox(height: 20),
                    Text('Select Day', style: TextStyles.sgproBold.f30),
                  ],
                ),
              )),
              CustomBottomButton(
                text: 'CREATE',
                onTap: () {},
              )
            ],
          ),
          controller.isBusy.value
              ? CustomProgressIndicator()
              : const SizedBox(),
        ],
      ),
    );
  }
}
