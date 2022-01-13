import 'package:fitness_99/controllers/search_screen/search_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_chat_tile.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:fitness_99/global/widgets/custom_search_field.dart';
import 'package:fitness_99/global/widgets/custom_group_list_shimmer.dart';
import 'package:flutter/cupertino.dart';
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomSearchFeild(),
                    const SizedBox(height: 15),
                    controller.isLoading.value
                        ? CustomListGroupShimmer()
                        : controller.groupList.isNotEmpty
                            ? Expanded(
                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.groupList.length,
                                  itemBuilder: (context, i) => CustomChatTile(
                                    groupName:
                                        controller.groupList[i].group_name,
                                    groupGoal: controller.groupList[i].goal,
                                    groupImage:
                                        controller.groupList[i].group_image,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: Text(
                                            'Join Group',
                                            style: TextStyles.sgproRegular.f18,
                                          ),
                                          content: Text(
                                            'Are you sure you want to join?',
                                            style: TextStyles.sgproRegular.f16,
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Get.back();
                                                controller.joinGroup(
                                                    controller.groupList[i].id);
                                              },
                                              child: Text(
                                                'Yes',
                                                style:
                                                    TextStyles.sgproRegular.f16,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () => Get.back(),
                                              child: Text(
                                                'No',
                                                style:
                                                    TextStyles.sgproRegular.f16,
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              )
                            : Expanded(
                                child: Center(
                                  child: Text(
                                    'No Groups Found',
                                    style: TextStyles.sgproMedium.f32,
                                  ),
                                ),
                              ),
                  ],
                ),
              ),
              controller.isBusy.value ? CustomProgressIndicator() : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
