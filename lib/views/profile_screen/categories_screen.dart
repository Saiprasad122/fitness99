import 'package:fitness_99/controllers/profile_screen/categories_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:fitness_99/global/widgets/custom_progress_indicator.dart';
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
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: Container(
                                    height:
                                        AppSizedBoxConfigs.screenHeight * 0.8,
                                    width: AppSizedBoxConfigs.screenWidth,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: TextField(
                                            style: TextStyles.sgproRegular.f20,
                                            decoration: InputDecoration(
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.transparent),
                                              ),
                                              prefixIcon: Icon(
                                                Icons.search,
                                                color: Colors.black,
                                              ),
                                              hintText: 'Search',
                                              hintStyle:
                                                  TextStyles.sgproRegular.f20,
                                            ),
                                            cursorColor: Colors.grey[400],
                                          ),
                                        ),
                                        const SizedBox(height: 5),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            'Category Names',
                                            style: TextStyles.sgproMedium.f26,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ListView.separated(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 15),
                                          shrinkWrap: true,
                                          separatorBuilder: (context, i) =>
                                              const SizedBox(height: 5),
                                          itemCount: controller
                                              .categoriesApiList.length,
                                          itemBuilder: (context, i) => InkWell(
                                            onTap: () =>
                                                controller.changeVisibility(i),
                                            child: GetBuilder<
                                                CategoriesController>(
                                              builder: (controller) => Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .symmetric(vertical: 3),
                                                    child: Text(
                                                      controller
                                                          .categoriesApiList[i]
                                                          .categoryName,
                                                      style: TextStyles
                                                          .sgproRegular.f24,
                                                    ),
                                                  ),
                                                  Obx(
                                                    () => Visibility(
                                                      visible: controller
                                                          .categoriesApiList[i]
                                                          .isTicked,
                                                      child: Image.asset(
                                                        'assets/images/tabbar/tick.png',
                                                        width: 15,
                                                        height: 15,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: Get.back,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Divider(
                                                  color:
                                                      AppColors.secondaryColor,
                                                  height: 1,
                                                  thickness: 1),
                                              Center(
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(vertical: 15),
                                                  child: Text(
                                                    'Done',
                                                    style: TextStyles
                                                        .sgproMedium.f22
                                                        .copyWith(
                                                            color: AppColors
                                                                .secondaryColor),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      controller.categoriesApiList.isNotEmpty
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
                                        controller.categoriesApiList.length,
                                    itemBuilder: (context, i) => controller
                                            .categoriesApiList[i].isTicked
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
                                                    .categoriesApiList[i]
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
