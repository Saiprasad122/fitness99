import 'package:fitness_99/controllers/chat_screen_controller/event_details_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/curtom_profile_icon_button.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';

import 'component/event_class.dart';

class EventDetailScreen extends StatelessWidget {
  final EventClass eventClass;
  EventDetailScreen({Key? key, required this.eventClass}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(EventDetailsController(event_id: eventClass.event_id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Event Details',
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
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventClass.title,
                          style: TextStyles.sgproBold.f26,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          eventClass.description,
                          style: TextStyles.sgproRegular.f20.greyMid,
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on,
                                  color: Colors.amber[800],
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  eventClass.location,
                                  style: TextStyles.sgproBold.f20
                                      .copyWith(color: Colors.amber[800]),
                                )
                              ],
                            ),
                            Container(
                              height: 40,
                              width: 2,
                              color: Colors.black,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today_outlined,
                                  color: Colors.amber[800],
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '${eventClass.date} ${eventClass.time}',
                                  style: TextStyles.sgproBold.f20,
                                )
                              ],
                            )
                          ],
                        ),
                        const SizedBox(height: 10),
                        Divider(
                          color: Colors.black,
                          thickness: 1,
                          height: 1,
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Checked In Users',
                          style: TextStyles.sgproBold.f26,
                        ),
                        const SizedBox(height: 20),
                        controller.userList.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: controller.userList.length,
                                  itemBuilder: (context, i) {
                                    return CustomProfileIconButtom(
                                        userData: controller.userList[i]);
                                  },
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: Text(
                                    'No User are Checked In',
                                    style: TextStyles.sgproMedium.f20,
                                  ),
                                ),
                              )
                      ],
                    ),
                  ),
                ),
                CustomBottomButton(
                  text: controller.isCheckedIn.value ? 'Check Out' : 'Check In',
                  onTap: () {
                    controller.isCheckedIn.value
                        ? controller.checkOutUser()
                        : controller.checkInUser();
                  },
                ),
              ],
            ),
            controller.isBusy.value
                ? const CustomProgressIndicator()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
