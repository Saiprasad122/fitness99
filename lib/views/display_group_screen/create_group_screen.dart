import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_profile_textField.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateGroupScreen extends StatelessWidget {
  const CreateGroupScreen({Key? key}) : super(key: key);

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
                  ),
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Gaol',
                    hintText: 'Sore Today, Strong Tomorrow',
                  ),
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Zip Code',
                    hintText: '850001',
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Maximum members',
                    hintText: '25',
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 20),
                  CustomProfileTextField(
                    displayText: 'Comments',
                    hintText: 'Enter your comments',
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
