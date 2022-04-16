import 'package:fitness_99/controllers/profile_screen/categories_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
import 'package:fitness_99/views/profile_screen/widget/category_screnn_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoriesScreen extends StatelessWidget {
  final controller = Get.put(CategoriesController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Select Categories',
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
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: GestureDetector(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Select category name...',
                                style: TextStyles.sgproRegular.f24,
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                                size: 30,
                              ),
                            ],
                          ),
                          onTap: () => showDialog(
                            context: context,
                            builder: (context) => CategoryScreenDialog(),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      controller.tempCategoriesList.isNotEmpty
                          ? Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: GetBuilder<CategoriesController>(
                                builder: (controller) => Container(
                                  height: 50,
                                  child: ListView.separated(
                                    padding: const EdgeInsets.all(0),
                                    separatorBuilder: (context, i) =>
                                        const SizedBox(width: 10),
                                    physics: BouncingScrollPhysics(),
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.tempCategoriesList.length,
                                    itemBuilder: (context, i) => controller
                                            .tempCategoriesList[i].isTicked
                                        ? Container(
                                            width: 100,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                width: 1,
                                                color: AppColors.secondaryColor,
                                              ),
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Text(controller
                                                    .tempCategoriesList[i]
                                                    .categoryName),
                                                InkWell(
                                                  onTap: () => controller
                                                      .changeVisibility(i),
                                                  child: Icon(Icons.close),
                                                )
                                              ],
                                            ),
                                          )
                                        : const SizedBox(),
                                  ),
                                ),
                              ),
                            )
                          : Expanded(
                              child: Center(
                                child: Text('No Data'),
                              ),
                            ),
                      const SizedBox(width: 20)
                    ],
                  ),
                ),
                CustomBottomButton(
                  text: 'Update',
                  onTap: controller.updateCategoryList,
                ),
              ],
            ),
            controller.isBusy.value
                ? CustomProgressIndicator()
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
