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
    final controller = Get.put(GroupVideosListController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Group Videos',
          style: TextStyles.sgproBold.f26.black,
        ),
        leading: Hero(
          tag: 'back_button',
          child: Material(
            color: Colors.transparent,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              ),
            ),
          ),
        ),
      ),
      body: controller.VideosList.length.isGreaterThan(0)
          ? GridView.builder(
              physics: BouncingScrollPhysics(),
              itemCount: controller.VideosList.length,
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
              itemBuilder: (context, i) {
                return InkWell(
                  onTap: () {
                    Get.to(() => FullScreenVideoComponent(
                          url: controller.VideosList[i],
                          file: File(
                            controller.VideosList[i],
                          ),
                        ));
                  },
                  child: Hero(
                    tag: controller.VideosList[i],
                    child: Image.file(
                      File(controller.VideosThumbnailList[i]),
                      filterQuality: FilterQuality.medium,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No VIdeos',
                style: TextStyles.sgproMedium.f26,
              ),
            ),
    );
  }
}
