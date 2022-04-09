import 'package:fitness_99/controllers/profile_screen/persoal_goals_screen_controller.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_list_shimmer.dart';
import 'package:fitness_99/views/profile_screen/widget/custom_only_text_shimmer.dart';
import 'package:fitness_99/views/profile_screen/widget/only_text_custom_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalGoalsDisplay extends StatelessWidget {
  final int user_id;
  final bool isUser;
  PersonalGoalsDisplay({required this.user_id, this.isUser = true});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PersonalGoalsController(user_id: user_id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Personal Goal',
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
            ? ListShimmerWidget(child: CustomOnlyTextShimmer(), count: 20)
            : Column(
                children: [
                  Expanded(
                    child: controller.goals.length > 0
                        ? ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.goals.length,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            itemBuilder: (context, i) {
                              return CustomOnlyTextWidget(
                                text: controller.goals[i].content,
                                onDelete: () {
                                  controller.deleteItem(controller.goals[i].id);
                                },
                              );
                            },
                          )
                        : Center(
                            child: Text('No Persnal Goals to Display'),
                          ),
                  ),
                  isUser
                      ? CustomBottomButton(
                          text: 'AddNew',
                          onTap: () => Get.toNamed(Routes.PersonalGoalsAdd),
                        )
                      : const SizedBox(),
                ],
              );
      }),
    );
  }
}
