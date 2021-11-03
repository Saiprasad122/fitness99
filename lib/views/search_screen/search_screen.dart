import 'package:fitness_99/controllers/search_screen/search_screen_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_chat_tile.dart';
import 'package:fitness_99/global/widgets/custom_search_field.dart';
import 'package:fitness_99/global/widgets/custom_shimmer.dart';
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
          'My Groups',
          style: TextStyles.sgproBold.f34.black,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchFeild(),
              const SizedBox(height: 15),
              Obx(
                () => controller.isLoading.value
                    ? CustomShimmer()
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
                                onTap: () {},
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
