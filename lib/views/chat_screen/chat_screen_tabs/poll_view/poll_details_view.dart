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
        body: Column(
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
              tabs: controller.options.map((e) {
                return Tab(
                  child: Text(
                    e,
                    style: TextStyles.sgproMedium.f20.black,
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: TabBarView(
                controller: controller.tabController,
                children: controller.options.map((e) {
                  return ListView.separated(
                    padding: const EdgeInsets.all(10),
                    separatorBuilder: (context, i) =>
                        const SizedBox(height: 10),
                    itemCount: 10,
                    itemBuilder: (context, i) => ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.white,
                        child: SizedBox.expand(
                          child: ClipOval(
                            child: Image.asset(
                                'assets/images/placeholders/user.png'),
                          ),
                        ),
                      ),
                      title: Text(
                        'Saiprasad',
                        style: TextStyles.sgproMedium.f22,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
