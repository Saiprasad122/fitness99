import 'package:fitness_99/controllers/chat_screen_controller/chat_list_controller.dart';
import 'package:fitness_99/global/router/views.export.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_chat_tile.dart';
import 'package:fitness_99/global/widgets/custom_search_field.dart';
import 'package:fitness_99/global/widgets/custom_list_group_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatListScreen extends StatelessWidget {
  final controller = Get.put(ChatListController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Chats',
          style: TextStyles.sgproBold.f34.black,
        ),
      ),
      body: SafeArea(
        child: Container(
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
                                onTap: () => Get.to(
                                  ChatScreen(controller.groupList[i].id,
                                      controller.groupList[i].group_name),
                                ),
                              ),
                            ),
                          )
                        : Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.asset(
                                  'assets/gifs/group-chat.gif',
                                  height: AppSizedBoxConfigs.screenHeight * 0.5,
                                ),
                                Text(
                                  'Your chat list is empty',
                                  style: TextStyles.sgproMedium.f20,
                                ),
                              ],
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
