import 'dart:io';

import 'package:fitness_99/controllers/group_screen_controller/create_group_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:fitness_99/views/profile_screen/widget/image_dialog_box.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroupScreen extends StatelessWidget {
  final controller = Get.put(CreateGroupController());
  CreateGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Create Group',
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 15),
                        Center(
                          child: GestureDetector(
                            onTap: () => showDialog(
                              context: context,
                              builder: (context) {
                                return ImagePickerDialoagBox(
                                    controller: controller);
                              },
                            ),
                            child: CircleAvatar(
                              radius: 50,
                              child: ClipOval(
                                child: controller.image.value == ''
                                    ? Image.asset(
                                        'assets/images/search_screen/fitness.png')
                                    : Image.file(
                                        File(controller.image.value),
                                      ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Group Name',
                          hintText: 'Stronger than yesterday',
                          textEditingController: controller.groupNameTED,
                          errText: controller.groupNameErr.value,
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Gaol',
                          hintText: 'Sore Today, Strong Tomorrow',
                          textEditingController: controller.goalTED,
                          errText: controller.goalErr.value,
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Location',
                          hintText: 'Mumbai',
                          textEditingController: controller.locationTED,
                          errText: controller.locationErr.value,
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Maximum members',
                          hintText: '25',
                          textInputType: TextInputType.number,
                          errText: controller.maxMembersErr.value,
                          textEditingController: controller.maxMembersTED,
                        ),
                        const SizedBox(height: 20),
                        CustomProfileTextField(
                          displayText: 'Comments',
                          hintText: 'Enter your comments',
                          textEditingController: controller.commentsTED,
                          errText: controller.commentsErr.value,
                        ),
                      ],
                    ),
                  ),
                ),
                CustomBottomButton(
                  text: 'Submit',
                  onTap: () => controller.createGroup(),
                )
              ],
            ),
            controller.isBusy.value ? CustomProgressIndicator() : SizedBox(),
          ],
        ),
      ),
    );
  }
}
