import 'package:fitness_99/controllers/chat_screen_controller/activity_controller.dart/display_activity_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import 'componenet/activity_widget.dart';

class ActivityScreen extends StatelessWidget {
  final int group_id;
  ActivityScreen({Key? key, required this.group_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayActivityController(group_id: group_id));
    return Scaffold(
        // backgroundColor: Colors.black12,
        body: Shimmer.fromColors(
      child: ListView(
        children: [],
      ),
      baseColor: AppColors.greyLight,
      highlightColor: AppColors.greyVeryLight,
    )
        // body: ListView(
        //   physics: BouncingScrollPhysics(),
        //   children: [
        //     ActivityWidget(),
        //     ActivityWidget(),
        //     ActivityWidget(),
        //     ActivityWidget(),
        //     ActivityWidget(),
        //     ActivityWidget(),
        //   ],
        // ),
        );
  }
}
