import 'package:fitness_99/controllers/chat_screen_controller/poll_details_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PollDetailsScreen extends StatelessWidget {
  final controller = Get.put(PollDetailsController());
  PollDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: controller.options.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Poll Name',
            style: TextStyles.sgproMedium.f26.black,
          ),
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            ),
          ),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Text(
                'Poll question will be here?',
                style: TextStyles.sgproMedium.f24,
              ),
            ),
            TabBar(
              controller: controller.tabController,
              indicatorColor: AppColors.secondaryColor,
              indicatorWeight: 3,
              tabs: [
                ListView.builder(
                  itemCount: controller.options.length,
                  itemBuilder: (context, i) => Tab(
                    text: controller.options[i],
                  ),
                )
              ],
            ),
            TabBarView(
              controller: controller.tabController,
              children: [
                ListView.builder(
                  itemCount: controller.options.length,
                  itemBuilder: (context, i) => Container(),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
