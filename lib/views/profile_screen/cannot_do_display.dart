import 'package:fitness_99/controllers/profile_screen/cannot_do_screen_controller.dart';
import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_list_shimmer.dart';
import 'package:fitness_99/views/profile_screen/widget/custom_only_text_shimmer.dart';
import 'package:fitness_99/views/profile_screen/widget/only_text_custom_component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CannnotDoDisplay extends StatelessWidget {
  CannnotDoDisplay({Key? key}) : super(key: key);
  final controller = Get.put(CannotDoController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Cannot Do Details',
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
      body: Obx(() {
        return controller.isLoading.value
            ? ListShimmerWidget(child: CustomOnlyTextShimmer())
            : Column(
                children: [
                  Expanded(
                    child: controller.cannotDo.length > 0
                        ? ListView.builder(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            physics: BouncingScrollPhysics(),
                            itemCount: controller.cannotDo.length,
                            itemBuilder: (context, i) {
                              return CustomOnlyTextWidget(
                                text: controller.cannotDo[i].content,
                                onDelete: () {
                                  controller
                                      .deleteItem(controller.cannotDo[i].id);
                                },
                              );
                            },
                          )
                        : Center(
                            child: Text('No Cannot Do\'s to Display'),
                          ),
                  ),
                  CustomBottomButton(
                    text: 'Add New',
                    onTap: () => Get.toNamed(Routes.CannotDoAdd),
                  )
                ],
              );
      }),
    );
  }
}
