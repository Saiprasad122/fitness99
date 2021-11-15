import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerDialoagBox extends StatelessWidget {
  final dynamic controller;
  ImagePickerDialoagBox({required this.controller});

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
            onTap: () {
              Get.back();
              controller.getImage(ImageSource.camera);
            },
          ),
          const SizedBox(height: 20),
          InkWell(
            child: Text(
              'Open Gallery',
              style: TextStyles.sgproRegular.f20,
            ),
            onTap: () {
              Get.back();
              controller.getImage(ImageSource.gallery);
            },
          ),
        ],
      ),
    );
  }
}
