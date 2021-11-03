import 'package:fitness_99/controllers/group_screen_controller/group_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroupScreen extends StatelessWidget {
  final controller = Get.find<GroupScreenController>();
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Center(
                    child: CircleAvatar(
                      backgroundImage:
                          AssetImage('assets/images/search_screen/fitness.png'),
                      radius: 50,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Group Name',
                    hintText: 'Stronger than yesterday',
                    textEditingController: controller.groupNameTED,
                  ),
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Gaol',
                    hintText: 'Sore Today, Strong Tomorrow',
                    textEditingController: controller.goalTED,
                  ),
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Location',
                    hintText: 'Mumbai',
                    textEditingController: controller.locationTED,
                  ),
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Maximum members',
                    hintText: '25',
                    textInputType: TextInputType.number,
                    textEditingController: controller.maxMembersTED,
                  ),
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Comments',
                    hintText: 'Enter your comments',
                    textEditingController: controller.commentsTED,
                  ),
                ],
              ),
            ),
          ),
          CustomBottomButton(
            text: 'Submit',
            onTap: () => Get.back(),
          )
        ],
      ),
    );
  }
}
