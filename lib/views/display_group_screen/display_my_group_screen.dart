import 'package:fitness_99/controllers/group_screen_controller/display_screen_controller.dart';
import 'package:fitness_99/views/display_group_screen/group_view.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_chat_tile.dart';
import 'package:fitness_99/global/widgets/custom_search_field.dart';
import 'package:fitness_99/global/widgets/custom_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DisplayMyGroup extends StatelessWidget {
  final controller = Get.put(DisplayScreenController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'My Groups',
          style: TextStyles.sgproBold.f34.black,
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 40),
            icon: SvgPicture.asset(
              'assets/svgs/chat_screen/add.svg',
              width: 20,
              height: 20,
              color: AppColors.secondaryColor,
            ),
            onPressed: () => Get.toNamed(Routes.CreateGroupScreen),
          ),
        ],
      ),
      body: Obx(
        () => SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                CustomSearchFeild(),
                const SizedBox(height: 15),
                !controller.isLoading.value
                    ? controller.groupList.isNotEmpty
                        ? Expanded(
                            child: ListView.builder(
                              physics: BouncingScrollPhysics(),
                              itemCount: controller.groupList.length,
                              itemBuilder: (context, index) => CustomChatTile(
                                groupName:
                                    controller.groupList[index].group_name,
                                groupGoal: controller.groupList[index].goal,
                                groupImage:
                                    'https://dev.99fitnessfriends.com/uploads${controller.groupList[index].group_image}',
                                onTap: () => Get.to(GroupView()),
                              ),
                            ),
                          )
                        : Container(
                            width: AppSizedBoxConfigs.screenWidth,
                            height: AppSizedBoxConfigs.screenHeight * 0.6,
                            child: Center(
                              child: Text(
                                'Tap to on "+" to create your first group',
                                style: TextStyles.sgproMedium.f24,
                              ),
                            ),
                          )
                    : CustomShimmer()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
