import 'package:fitness_99/controllers/chat_screen_controller/display_activity_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_activity_list_shimmer.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/activity_view/componenet/activity_class.dart';
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
        () => controller.isBusy.value
            ? CustomActivityListShimmer()
            : controller.activityList.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) => ActivityWidget(
                      activityClass: ActivityClass(
                        title: controller.activityList[i].title,
                        description: controller.activityList[i].description,
                        location: controller.activityList[i].location,
                        fromTime: controller.activityList[i].from_time,
                        toTime: controller.activityList[i].to_time,
                        notes: controller.activityList[i].note,
                      ),
                    ),
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
                  ),
      ),
    );
  }
}
