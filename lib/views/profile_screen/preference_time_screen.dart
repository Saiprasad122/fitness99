import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/views/profile_screen/widget/availability_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PreferenceTimeScreen extends StatelessWidget {
  const PreferenceTimeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Preference Time',
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
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Center(
                child: Column(
                  children: [
                    const SizedBox(height: 30),
                    AvailabiltyComponent(day: 'Sunday'),
                    const SizedBox(height: 30),
                    AvailabiltyComponent(day: 'Monday'),
                    const SizedBox(height: 30),
                    AvailabiltyComponent(day: 'Tuesday'),
                    const SizedBox(height: 30),
                    AvailabiltyComponent(day: 'Wednesday'),
                    const SizedBox(height: 30),
                    AvailabiltyComponent(day: 'Thursday'),
                    const SizedBox(height: 30),
                    AvailabiltyComponent(day: 'Friday'),
                    const SizedBox(height: 30),
                    AvailabiltyComponent(day: 'Saturday'),
                    const SizedBox(height: 10)
                  ],
                ),
              ),
            ),
          ),
          CustomBottomButton(
            text: 'Add your availability',
            onTap: () => Get.toNamed(Routes.PreferenceTimeAdd),
          )
        ],
      ),
    );
  }
}
