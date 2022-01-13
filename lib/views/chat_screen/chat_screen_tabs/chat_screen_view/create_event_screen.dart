import 'package:fitness_99/controllers/chat_screen_controller/create_event_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateEventScreen extends StatelessWidget {
  final controller = Get.put(CreateEventController());
  CreateEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Create Event',
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
      body: Obx(
        () => Stack(
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
                          displayText: 'Event Title',
                          hintText: 'Enter Event Title',
                          textEditingController: controller.titleTED,
                          errText: controller.titleErrText.value,
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                            displayText: 'Event Description',
                            hintText: 'Enter Event Description',
                            textEditingController: controller.descriptionTED,
                            errText: controller.descriptionErrText.value),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Event Locatin',
                          hintText: 'Enter your location',
                          textEditingController: controller.locationTED,
                          errText: controller.locationErrText.value,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async {
                              await controller.selectDate(context);
                            },
                            child: Text(
                              'Choose Date and Time',
                              style: TextStyles.sgproRegular.f24,
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Date and Time',
                          style: TextStyles.sgproBold.f24,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          '${controller.selectedDate} ${controller.selectedTime.value}',
                          style: TextStyles.sgproMedium.f22,
                        )
                      ],
                    ),
                  ),
                ),
                CustomBottomButton(
                  text: 'CREATE EVENT',
                  onTap: () {},
                )
              ],
            ),
            controller.isBusy.value
                ? CustomProgressIndicator()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
