import 'package:fitness_99/controllers/chat_screen_controller/display_activity_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_activity_list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'componenet/activity_widget.dart';

class ActivityScreen extends StatelessWidget {
  final int group_id;
  ActivityScreen({Key? key, required this.group_id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayActivityController(group_id: group_id));
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Obx(
        () => !controller.isBusy.value
            ? controller.activityList.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) => ActivityWidget(),
                    itemCount: controller.activityList.length,
                  )
                : Container(
                    width: AppSizedBoxConfigs.screenWidth,
                    child: Center(
                      child: Text(
                        'No Activity were found',
                        style: TextStyles.sgproMedium.f24,
                      ),
                    ),
                  )
            : CustomActivityListShimmer(),
      ),
    );
  }
}
