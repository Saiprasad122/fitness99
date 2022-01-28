import 'package:fitness_99/controllers/chat_screen_controller/create_event_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateEventScreen extends StatelessWidget {
  final int group_id;
  final controller = Get.put(CreateEventController());
  CreateEventScreen({Key? key, required this.group_id}) : super(key: key);

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
                          onChanged: (text) => controller.onChangedTitle(text),
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Event Description',
                          hintText: 'Enter Event Description',
                          textEditingController: controller.descriptionTED,
                          errText: controller.descriptionErrText.value,
                          onChanged: (text) =>
                              controller.onChangedDescription(text),
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Event Locatin',
                          hintText: 'Enter your location',
                          textEditingController: controller.locationTED,
                          errText: controller.locationErrText.value,
                          onChanged: (text) =>
                              controller.onChangedLocation(text),
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Maximum members',
                          hintText: '25',
                          textEditingController: controller.membersTED,
                          errText: controller.membersErrText.value,
                          onChanged: (text) => controller.onChangedMember(text),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          width: double.infinity,
                          child: OutlinedButton(
                            onPressed: () async =>
                                await controller.selectDate(context),
                            child: Text(
                              'Choose Date and Time',
                              style: TextStyles.sgproRegular.f24,
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),
                        Text(
                          '${controller.selectedDate} ${controller.selectedTime.value}',
                          style: TextStyles.sgproMedium.f22,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          controller.selectDateTimeErrText.value,
                          style: TextStyles.sgproRegular.f18
                              .copyWith(color: Colors.red[700]),
                        )
                      ],
                    ),
                  ),
                ),
                CustomBottomButton(
                  text: 'CREATE EVENT',
                  onTap: () => controller.createEvent(group_id.toString()),
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
