import 'package:fitness_99/controllers/profile_screen/edit_profile_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomDialoagBox extends StatelessWidget {
  final EditProfileController controller;
  CustomDialoagBox({required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            child: Text(
              'Open Camera',
              style: TextStyles.sgproRegular.f20,
            ),
            onTap: () => controller.pickImageFromCamera(),
          ),
          const SizedBox(height: 20),
          InkWell(
            child: Text(
              'Open Gallery',
              style: TextStyles.sgproRegular.f20,
            ),
            onTap: () => controller.pickImageFromGallery(),
          ),
        ],
      ),
    );
    ;
  }
}
