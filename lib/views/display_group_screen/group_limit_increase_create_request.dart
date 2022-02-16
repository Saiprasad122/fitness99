import 'package:fitness_99/controllers/group_screen_controller/group_limit_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupLimitIncreaseCreateRequest extends StatelessWidget {
  final controller = Get.put(GroupLimitController());
  GroupLimitIncreaseCreateRequest({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Create Requests',
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
        () => Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Comment',
                    hintText: 'Enter your comment here',
                    textEditingController: controller.commentTED,
                    errText: controller.commentErrTxt.value,
                  ),
                  const SizedBox(height: 10),
                  CustomProfileTextField(
                    displayText: 'Limit',
                    hintText: '10',
                    textEditingController: controller.limitnumTED,
                    errText: controller.limitNumErrTxt.value,
                  ),
                ],
              ),
            ),
            CustomBottomButton(text: 'SUBMIT', onTap: controller.submitRequest)
          ],
        ),
      ),
    );
  }
}
