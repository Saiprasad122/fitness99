import 'package:fitness_99/controllers/profile_screen/add_preference_time_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/week_dialog_box.dart';

class AddPreferenceTime extends StatelessWidget {
  final controller = Get.put(AddPreferenceTimeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Availability',
          style: TextStyles.sgproBold.f26.black,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(
        () => Stack(
          children: [
            Center(
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Text(
                    'Select Day',
                    style: TextStyles.sgproMedium.f26,
                  ),
                  const SizedBox(height: 20),
                  InkWell(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Obx(
                          () => Text(
                            controller.selectedDay.value,
                            style: TextStyles.sgproRegular.f20.copyWith(
                                color: controller.selectDayColor.value),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Icon(Icons.arrow_drop_down)
                      ],
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            WeekDialoagBox(controller: controller),
                      );
                    },
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: AppSizedBoxConfigs.screenWidth - 10,
                    child: OutlinedButton(
                      onPressed: () async {
                        controller.fromTimePicked(context);
                      },
                      child: Text(
                        'Choose from time',
                        style: TextStyles.sgproRegular.f22,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.lightBlue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Obx(
                      () => Text(
                        controller.fromTime.value.toString(),
                        style: TextStyles.sgproMedium.f20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(controller.fromTimeErrText.value,
                      style: TextStyles.sgproMedium.f18
                          .copyWith(color: AppColors.error)),
                  SizedBox(
                    width: AppSizedBoxConfigs.screenWidth - 10,
                    child: OutlinedButton(
                      onPressed: () async {
                        controller.toTimePicked(context);
                      },
                      child: Text(
                        'Choose to time',
                        style: TextStyles.sgproRegular.f22,
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.lightBlue),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Obx(
                      () => Text(
                        controller.toTime.value.toString(),
                        style: TextStyles.sgproMedium.f20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(controller.toTimeErrText.value,
                      style: TextStyles.sgproMedium.f18
                          .copyWith(color: AppColors.error)),
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomBottomButton(
                text: 'Add',
                onTap: controller.addPreference,
              ),
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
