import 'package:fitness_99/controllers/search_screen/search_screen_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../global/utils/fontsAndSizes.dart';
import '../../global/widgets/custom_chat_tile.dart';
import '../../global/widgets/custom_group_list_shimmer.dart';
import '../../global/widgets/custom_search_field.dart';

class GlobalGroupsListTab extends StatelessWidget {
  final SearchScreenController controller;
  const GlobalGroupsListTab({Key? key, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomSearchFeild(
            textEditingController: controller.searchGroupsTED,
            onChanged: (text) =>
                controller.onChangedGroupListSearchTextField(text),
          ),
          const SizedBox(height: 15),
          controller.isGroupLoading.value
              ? CustomListGroupShimmer()
              : controller.searchedGroupList.isNotEmpty
                  ? Expanded(
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: controller.searchedGroupList.length,
                        itemBuilder: (context, i) => CustomChatTile(
                          groupName: controller.searchedGroupList[i].group_name,
                          groupGoal: controller.searchedGroupList[i].goal,
                          groupImage:
                              controller.searchedGroupList[i].group_image,
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(
                                  'Send Invitation',
                                  style: TextStyles.sgproRegular.f18,
                                ),
                                content: Text(
                                  'Do you want to send inivaition?',
                                  style: TextStyles.sgproRegular.f16,
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.joinGroup(
                                          controller.searchedGroupList[i].id);
                                    },
                                    child: Text(
                                      'Yes',
                                      style: TextStyles.sgproRegular.f16,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () => Get.back(),
                                    child: Text(
                                      'No',
                                      style: TextStyles.sgproRegular.f16,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    )
                  : controller.groupList.isNotEmpty
                      ? Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.groupList.length,
                            itemBuilder: (context, i) => CustomChatTile(
                              groupName: controller.groupList[i].group_name,
                              groupGoal: controller.groupList[i].goal,
                              groupImage: controller.groupList[i].group_image,
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: Text(
                                      'Send Invitation',
                                      style: TextStyles.sgproRegular.f18,
                                    ),
                                    content: Text(
                                      'Do you want to send inivaition?',
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
                                          style: TextStyles.sgproRegular.f16,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () => Get.back(),
                                        child: Text(
                                          'No',
                                          style: TextStyles.sgproRegular.f16,
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
                              controller.textToShowGroups.value,
                              style: TextStyles.sgproMedium.f32,
                            ),
                          ),
                        ),
        ],
      ),
    );
  }
}
