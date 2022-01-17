import 'package:fitness_99/controllers/chat_screen_controller/display_event_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_list_event_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/event_widget.dart';

class DisplayEventScreen extends StatelessWidget {
  final int group_id;
  const DisplayEventScreen({Key? key, required this.group_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayEventController(group_id: group_id));

    return Scaffold(
      backgroundColor: Colors.black12,
      body: Obx(
        () => controller.isBusy.value
            ? CustomListEventShimmer()
            : controller.eventList.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) => EventWidget(
                      title: controller.eventList[i].title,
                      description: controller.eventList[i].description,
                      location: controller.eventList[i].location,
                      date: controller.eventList[i].date,
                      time: controller.eventList[i].time,
                    ),
                    itemCount: controller.eventList.length,
                  )
                : Container(
                    width: AppSizedBoxConfigs.screenWidth,
                    child: Center(
                      child: Text(
                        'No Event were found',
                        style: TextStyles.sgproMedium.f24,
                      ),
                    ),
                  ),
      ),
    );
  }
}
