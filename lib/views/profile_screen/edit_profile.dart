import 'package:fitness_99/controllers/profile_screen/edit_profile_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
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
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    Center(
                      child: GestureDetector(
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.white,
                          child: SizedBox.expand(
                            child: ClipOval(
                              child: controller.img.value.path.isEmpty
                                  ? Image.asset(
                                      'assets/images/onboard_img/fflogo.png')
                                  : Image.file(
                                      controller.img.value,
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                          ),
                        ),
                        onTap: controller.pickImage,
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextField(
                      displayText: 'Profile Name',
                      hintText: 'john',
                      errText: controller.nameErr.value,
                      textEditingController: controller.nameTED,
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextField(
                      displayText: 'Email',
                      hintText: 'john@gmail.com',
                      textInputType: TextInputType.emailAddress,
                      errText: controller.emailErr.value,
                      textEditingController: controller.emailTED,
                    ),
                    const SizedBox(height: 20),
                    CustomProfileTextField(
                      displayText: 'Mobile Number',
                      hintText: '9876XXXXXX',
                      textInputType: TextInputType.number,
                      errText: controller.numberErr.value,
                      textInputFormatter: [controller.numberTextInputFormatter],
                      textEditingController: controller.numberTED,
                    ),
                  ],
                ),
              ),
            ),
            CustomBottomButton(text: 'Submit', onTap: controller.submit)
          ],
        ),
      ),
    );
  }
}
