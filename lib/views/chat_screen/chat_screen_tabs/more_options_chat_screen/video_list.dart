import 'dart:io';

import 'package:fitness_99/controllers/chat_screen_controller/more_option_chat_controller/group_videos_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/components/video_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupVideosList extends StatelessWidget {
  const GroupVideosList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GroupVideoListController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Group Videos',
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
      body: controller.videoList.length.isGreaterThan(0)
          ? GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: controller.videoList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => FullScreenVideoComponent(
                        url: controller.videoList[i].videoUrl,
                        file: File(controller.videoList[i].videoUrl),
                      ),
                    );
                  },
                  child: Hero(
                    tag: controller.videoList[i].videoUrl,
                    child: Image.file(
                      File(
                        controller.videoList[i].videoThumbnailUrl,
                      ),
                      filterQuality: FilterQuality.medium,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No Videos',
                style: TextStyles.sgproMedium.f26,
              ),
            ),
    );
  }
}
