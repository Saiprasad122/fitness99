import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/controllers/chat_screen_controller/more_option_chat_controller/group_images_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupImagesList extends StatelessWidget {
  GroupImagesList({Key? key}) : super(key: key);
  final controller = Get.put(GroupImagesListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Group Images',
          style: TextStyles.sgproBold.f26.black,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: controller.imagesList.length.isGreaterThan(0)
          ? GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: controller.imagesList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, i) {
                return CachedNetworkImage(imageUrl: controller.imagesList[i]);
              },
            )
          : Center(
              child: Text(
                'No Images',
                style: TextStyles.sgproMedium.f26,
              ),
            ),
    );
  }
}
