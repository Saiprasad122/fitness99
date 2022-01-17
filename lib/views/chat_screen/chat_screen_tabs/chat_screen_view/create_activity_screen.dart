import 'package:fitness_99/controllers/chat_screen_controller/create_activity_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:fitness_99/views/profile_screen/widget/week_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateActivityScreen extends StatelessWidget {
  final controller = Get.put(CreateActivityController());
  CreateActivityScreen({Key? key, required this.group_id}) : super(key: key);
  final int group_id;

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
                          displayText: 'Activity Title',
                          hintText: 'Enter Activity Title',
                          textEditingController: controller.titleTED,
                          errText: controller.titleErrText.value,
                          onChanged: (text) => controller.onChangedTitle(text),
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Activity Description',
                          hintText: 'Enter Activity Description',
                          textEditingController: controller.descriptionTED,
                          errText: controller.descriptionErrText.value,
                          onChanged: (text) =>
                              controller.onChangedDescription(text),
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Activity Location',
                          hintText: 'Enter your Location',
                          textEditingController: controller.locationTED,
                          errText: controller.locationErrText.value,
                          onChanged: (text) =>
                              controller.onChangedLocation(text),
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Notes',
                          hintText: 'Enter your Notes',
                          textEditingController: controller.notesTED,
                          errText: controller.notesErrText.value,
                          onChanged: (text) => controller.onChangedNotes(text),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'Select Day',
                          style: TextStyles.sgproBold.f24,
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                controller.selectedDay.value,
                                style: TextStyles.sgproRegular.f24.copyWith(
                                    color: controller.selectDayColor.value),
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
                        const SizedBox(height: 20),
                        SizedBox(
                          width: AppSizedBoxConfigs.screenWidth - 10,
                          child: OutlinedButton(
                            onPressed: () async =>
                                controller.fromTimePicked(context),
                            child: Text(
                              'Choose From Time',
                              style: TextStyles.sgproRegular.f22,
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(controller.fromTime.value,
                            style: TextStyles.sgproMedium.f22),
                        const SizedBox(height: 5),
                        Text(
                          controller.fromTimeErrText.value,
                          style: TextStyles.sgproRegular.f18
                              .copyWith(color: Colors.red[700]),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: AppSizedBoxConfigs.screenWidth - 10,
                          child: OutlinedButton(
                            onPressed: () async {
                              controller.toTimePicked(context);
                            },
                            child: Text(
                              'Choose To Time',
                              style: TextStyles.sgproRegular.f22,
                            ),
                            style: OutlinedButton.styleFrom(
                              side: BorderSide(color: Colors.lightBlue),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(controller.toTime.value,
                            style: TextStyles.sgproMedium.f22),
                        const SizedBox(height: 5),
                        Text(
                          controller.fromTimeErrText.value,
                          style: TextStyles.sgproRegular.f18
                              .copyWith(color: Colors.red[700]),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
                CustomBottomButton(
                  text: 'CREATE ACTIVITY',
                  onTap: () => controller.createActivity(group_id.toString()),
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
