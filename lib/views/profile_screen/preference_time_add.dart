import 'package:fitness_99/controllers/profile_screen/preference_time_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'widget/week_dialog_box.dart';

class PreferenceTimeAdd extends StatelessWidget {
  final controller = Get.put(PreferenceTimeController());
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
      body: Stack(
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
                          style: TextStyles.sgproRegular.f20,
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
                // Obx(
                //   () => DropdownButton(
                //     value: controller.dropdownValue.value,
                //     icon: const Icon(Icons.arrow_drop_down),
                //     iconSize: 20,
                //     onChanged: (String? newValue) {
                //       controller.onChangeDropdownValue(newValue!);
                //     },
                //     items: controller.days
                //         .map<DropdownMenuItem<String>>((String value) {
                //       return DropdownMenuItem(
                //         child: Center(
                //           child: Text(
                //             value,
                //             style: TextStyles.sgproRegular.f20,
                //           ),
                //         ),
                //         value: value,
                //       );
                //     }).toList(),
                //   ),
                // ),
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
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomButton(
              text: 'Add',
              onTap: () => Get.back(),
            ),
          )
        ],
      ),
    );
  }
}
