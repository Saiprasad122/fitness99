import 'package:fitness_99/controllers/chat_screen_controller/display_event_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_activity_list_shimmer.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/event_screen/widget/event_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DisplayEventScreen extends StatelessWidget {
  const DisplayEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DisplayEventController());
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Obx(
        () => !controller.isBusy.value
            ? controller.eventList.isNotEmpty
                ? ListView.builder(
                    physics: BouncingScrollPhysics(),
                    itemBuilder: (context, i) => EventWidget(),
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
                  )
            : CustomActivityListShimmer(),
      ),
    );
  }
}
