import 'package:fitness_99/controllers/chat_screen_controller/activity_controller.dart/display_activity_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'componenet/activity_widget.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({Key? key}) : super(key: key);
  final controller = Get.put(DisplayActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black12,
        body: ListView(
          physics: BouncingScrollPhysics(),
          children: [
            ActivityWidget(),
            ActivityWidget(),
            ActivityWidget(),
            ActivityWidget(),
            ActivityWidget(),
            ActivityWidget(),
          ],
        ));
  }
}
