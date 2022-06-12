import 'dart:io';

import 'package:fitness_99/controllers/chat_screen_controller/chat_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageChatComponent extends StatelessWidget {
  final controller = Get.find<ChatScreenController>();

  ImageChatComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {
                  controller.filePath.value = '';
                  Get.back();
                },
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              ),
              IconButton(
                  onPressed: () async {
                    final file = await controller.imageCropper.cropImage(
                      sourcePath: controller.filePath.value,
                      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
                      maxHeight: 300,
                      maxWidth: 300,
                      uiSettings: [AndroidUiSettings(hideBottomControls: true)],
                    );
                    if (file != null) {
                      controller.filePath.value = file.path;
                    }
                  },
                  icon: Icon(
                    Icons.crop,
                    color: Colors.black,
                  ))
            ],
          ),
          Expanded(
            child: Obx(
              () => Image.file(
                File(controller.filePath.value),
                fit: BoxFit.fitWidth,
                filterQuality: FilterQuality.high,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            alignment: Alignment.bottomCenter,
            height: 60,
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(width: 1),
              ),
            ),
            padding: const EdgeInsets.all(15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: controller.chatTED,
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      hintStyle: TextStyles.sgproRegular.f20,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                InkWell(
                  onTap: controller.uploadImage,
                  child: SvgPicture.asset(
                    'assets/svgs/chat_screen/send_icon.svg',
                    color: AppColors.secondaryColor,
                    width: 25,
                    height: 25,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ));
  }
}
