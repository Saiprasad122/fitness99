import 'package:fitness_99/controllers/profile_screen/preference_time_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeekDialoagBox extends StatelessWidget {
  final PreferenceTimeController controller;
  WeekDialoagBox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Container(
        width: AppSizedBoxConfigs.screenHeight * 0.8,
        height: AppSizedBoxConfigs.screenWidth * 0.65,
        child: ListView.builder(
          itemCount: controller.days.length,
          itemBuilder: (context, i) {
            return customWidget(controller.days[i], i);
          },
        ),
      ),
    );
  }

  customWidget(String text, int i) {
    return Column(
      children: [
        InkWell(
          child: Text(
            text,
            style: TextStyles.sgproRegular.f20,
          ),
          onTap: () {
            Get.back();
            controller.selectedDay.value = controller.days[i];
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
