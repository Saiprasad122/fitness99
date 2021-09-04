import 'package:fitness_99/controllers/profile_screen/categories_controller.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
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
      body: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 40),
            child: Column(
              children: [
                SizedBox(height: 30),
                GestureDetector(
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
                            height: AppSizedBoxConfigs.screenHeight - 30,
                            width: AppSizedBoxConfigs.screenWidth,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(5),
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
                                      hintStyle: TextStyles.sgproRegular.f20,
                                    ),
                                    cursorColor: Colors.grey[400],
                                  ),
                                ),
                                SizedBox(height: 5),
                                Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    'Category Names',
                                    style: TextStyles.sgproMedium.f20,
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: 15),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: controller.categoriesName.length,
                                    itemBuilder: (context, i) =>
                                        GestureDetector(
                                      onTap: () =>
                                          controller.changeVisibility(i),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 3),
                                                child: Text(
                                                  controller.categoriesName[i]
                                                      .categoryName,
                                                  style: TextStyles
                                                      .sgproRegular.f20,
                                                ),
                                              ),
                                              Visibility(
                                                visible: controller
                                                    .categoriesName[i].isTicked,
                                                child: Image.asset(
                                                  'assets/images/tabbar/tick.png',
                                                  width: 15,
                                                  height: 15,
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 2),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                Spacer(),
                                Center(
                                  child: GestureDetector(
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 15),
                                      child: Text(
                                        'Done',
                                        style: TextStyles.sgproMedium.f20
                                            .copyWith(color: Colors.amber[700]),
                                      ),
                                    ),
                                    onTap: () => Get.back(),
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
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomBottomButton(
              text: 'Update',
              onTap: () => Get.back(),
            ),
          )
        ],
      ),
    );
  }
}
