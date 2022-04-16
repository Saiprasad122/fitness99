import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/profile_screen/categories_controller.dart';
import '../../../global/utils/dimensions.dart';
import '../../../global/utils/fontsAndSizes.dart';

class CategoryScreenDialog extends StatelessWidget {
  final controller = Get.find<CategoriesController>();
  CategoryScreenDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: EdgeInsets.zero,
      content: Container(
        height: AppSizedBoxConfigs.screenHeight * 0.8,
        width: AppSizedBoxConfigs.screenWidth,
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(5),
                ),
                child: TextField(
                  controller: controller.searchCategoryTED,
                  onChanged: (v) => controller.searchCatgoryMethod(v),
                  style: TextStyles.sgproRegular.f20,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    hintText: 'Search',
                    hintStyle: TextStyles.sgproRegular.f20,
                  ),
                  cursorColor: Colors.grey[400],
                ),
              ),
              const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Category Names',
                  style: TextStyles.sgproMedium.f26,
                ),
              ),
              const SizedBox(height: 10),
              controller.searchedCategoriesList.isNotEmpty
                  ? ListView.separated(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      shrinkWrap: true,
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 5),
                      itemCount: controller.searchedCategoriesList.length,
                      itemBuilder: (context, i) => InkWell(
                        onTap: () => controller.changeVisibility(i),
                        child: GetBuilder<CategoriesController>(
                          builder: (controller) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: Text(
                                  controller
                                      .searchedCategoriesList[i].categoryName,
                                  style: TextStyles.sgproRegular.f24,
                                ),
                              ),
                              Obx(
                                () => Visibility(
                                  visible: controller
                                      .searchedCategoriesList[i].isTicked,
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
                    )
                  : controller.categoriesApiList.isNotEmpty
                      ? ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          shrinkWrap: true,
                          separatorBuilder: (context, i) =>
                              const SizedBox(height: 5),
                          itemCount: controller.categoriesApiList.length,
                          itemBuilder: (context, i) => InkWell(
                            onTap: () => controller.changeVisibility(i),
                            child: GetBuilder<CategoriesController>(
                              builder: (controller) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 3),
                                    child: Text(
                                      controller
                                          .categoriesApiList[i].categoryName,
                                      style: TextStyles.sgproRegular.f24,
                                    ),
                                  ),
                                  Obx(
                                    () => Visibility(
                                      visible: controller
                                          .categoriesApiList[i].isTicked,
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
                        )
                      : Expanded(
                          child: Center(
                            child: Text(
                              controller.textToShow.value,
                              style: TextStyles.sgproMedium.f20,
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
                        color: AppColors.secondaryColor,
                        height: 1,
                        thickness: 1),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Text(
                          'Done',
                          style: TextStyles.sgproMedium.f22
                              .copyWith(color: AppColors.secondaryColor),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
