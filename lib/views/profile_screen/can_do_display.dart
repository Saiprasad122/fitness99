import 'package:fitness_99/controllers/profile_screen/can_do_screen_controller.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_list_shimmer.dart';
import 'package:fitness_99/views/profile_screen/widget/custom_only_text_shimmer.dart';
import 'package:fitness_99/views/profile_screen/widget/only_text_custom_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CanDoDisplay extends StatelessWidget {
  final user_id;
  final bool isUser;
  CanDoDisplay({required this.user_id, this.isUser = true});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CanDoController(user_id: user_id));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Can Do Details',
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
      body: Obx(() {
        return controller.isLoading.value
            ? ListShimmerWidget(child: CustomOnlyTextShimmer())
            : Column(
                children: [
                  Expanded(
                    child: controller.canDos.isNotEmpty
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.canDos.length,
                            itemBuilder: (context, i) {
                              return CustomOnlyTextWidget(
                                text: controller.canDos[i].content,
                                onDelete: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text('Delete?'),
                                        content: Text(
                                            'Are you sure you want to delete this?'),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              controller.deleteItem(
                                                  controller.canDos[i].id);
                                              Get.back();
                                            },
                                            child: Text(
                                              'Yes',
                                              style: TextStyles
                                                  .sgproRegular.f20.black,
                                            ),
                                          ),
                                          TextButton(
                                            onPressed: () => Get.back(),
                                            child: Text(
                                              'No',
                                              style: TextStyles
                                                  .sgproRegular.f20.black,
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              );
                            },
                          )
                        : Center(
                            child: Text('No Can Do\'s to Display'),
                          ),
                  ),
                  isUser
                      ? CustomBottomButton(
                          text: 'AddNew',
                          onTap: () => Get.toNamed(Routes.CanDoAdd),
                        )
                      : const SizedBox(),
                ],
              );
      }),
    );
  }
}
