import 'package:fitness_99/controllers/search_screen/search_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:fitness_99/views/search_screen/globalEventListTab.dart';
import 'package:fitness_99/views/search_screen/globalGroupListTab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreenView extends StatelessWidget {
  final controller = Get.put(SearchScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'All Groups',
          style: TextStyles.sgproBold.f34.black,
        ),
      ),
      body: SafeArea(
        child: Obx(
          () => Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                child: Column(
                  children: [
                    TabBar(
                      controller: controller.tabController,
                      indicatorColor: AppColors.secondaryColor,
                      indicatorWeight: 3,
                      tabs: [
                        Tab(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Groups',
                              style: TextStyles.sgproMedium.f20.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        Tab(
                          height: 50,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Events',
                              style: TextStyles.sgproMedium.f20.black,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: TabBarView(
                        controller: controller.tabController,
                        children: [
                          GlobalGroupsListTab(controller: controller),
                          GlobalEventListTab(
                            controller: controller,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              controller.isBusy.value
                  ? const CustomProgressIndicator()
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
