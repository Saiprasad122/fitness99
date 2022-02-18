import 'package:fitness_99/controllers/profile_screen/view_preferences_controller.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:fitness_99/views/profile_screen/widget/availability_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewPreferencesScreen extends StatelessWidget {
  ViewPreferencesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PreferenceController());
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
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 50),
                Expanded(
                  child: ListView(
                    children: [
                      AvailabiltyComponent(
                        day: 'Sunday',
                        dayPreferenceList: controller.sundayPreferenceList,
                      ),
                      const SizedBox(height: 20),
                      AvailabiltyComponent(
                          day: 'Monday',
                          dayPreferenceList: controller.mondayPreferenceList),
                      const SizedBox(height: 20),
                      AvailabiltyComponent(
                          day: 'Tuesday',
                          dayPreferenceList: controller.tuesdayPreferenceList),
                      const SizedBox(height: 20),
                      AvailabiltyComponent(
                          day: 'Wednesday',
                          dayPreferenceList:
                              controller.wednesdayPreferenceList),
                      const SizedBox(height: 20),
                      AvailabiltyComponent(
                          day: 'Thursday',
                          dayPreferenceList: controller.thursdayPreferenceList),
                      const SizedBox(height: 20),
                      AvailabiltyComponent(
                          day: 'Friday',
                          dayPreferenceList: controller.fridayPreferenceList),
                      const SizedBox(height: 20),
                      AvailabiltyComponent(
                          day: 'Saturday',
                          dayPreferenceList: controller.saturdayPreferenceList),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
                CustomBottomButton(
                  text: 'Add your availability',
                  onTap: () => Get.toNamed(Routes.AddPreferenceTime),
                )
              ],
            ),
            controller.isBusy.value
                ? const CustomProgressIndicator()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
