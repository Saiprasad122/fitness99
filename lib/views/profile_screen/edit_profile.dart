import 'package:fitness_99/controllers/profile_screen/edit_profile_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_detail_textfield.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final controller = Get.put(EditProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Create Profile', style: TextStyles.sgproBold.f26.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new),
          onPressed: () => Get.back(),
          color: Colors.black,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(height: 10),
            Center(
              child: CircleAvatar(
                radius: 50,
                foregroundImage:
                    AssetImage('assets/images/placeholders/user.png'),
              ),
            ),
            SizedBox(height: 20),
            CustomProfileTextField(
              displayText: 'Profile Name',
              hintText: 'john',
              errText: controller.nameErr.value,
              textEditingController: controller.nameTED,
            ),
            SizedBox(height: 20),
            CustomProfileTextField(
              displayText: 'Email',
              hintText: 'john@gmail.com',
              textInputType: TextInputType.emailAddress,
              errText: controller.emailErr.value,
              textEditingController: controller.emailTED,
            ),
            SizedBox(height: 20),
            CustomProfileTextField(
              displayText: 'Profile Name',
              hintText: '9876XXXXXX',
              textInputType: TextInputType.number,
              errText: controller.numberErr.value,
              textEditingController: controller.numberTED,
            ),
            Spacer(),
            GestureDetector(
              child: Container(
                height: 50,
                color: Colors.lightBlueAccent,
                child: Center(
                  child: Text(
                    'SUBMIT',
                    style: TextStyles.sgproMedium.f20.white,
                  ),
                ),
              ),
              onTap: controller.submit,
            ),
          ],
        ),
      ),
    );
  }
}
