import 'package:fitness_99/controllers/more_screen_controller/product_screen_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_search_field.dart';
import 'package:fitness_99/views/more_screen/Products_Screen/widget/grid_product_view.dart';
import 'package:fitness_99/views/more_screen/Products_Screen/widget/list_product_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductScreen extends StatelessWidget {
  final controller = Get.put(ProductScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Obx(
              () => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CustomSearchFeild(),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Products',
                        style: TextStyles.sgproMedium.f26,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () => controller.setSelectedIndex(0),
                            icon: SvgPicture.asset(
                              'assets/svgs/product_screen/list_view_icon.svg',
                              width: 20,
                              height: 20,
                              color: controller.selectedIndex.value == 0
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          ),
                          IconButton(
                            onPressed: () => controller.setSelectedIndex(1),
                            icon: SvgPicture.asset(
                              'assets/svgs/product_screen/grid_view_icon.svg',
                              height: 20,
                              width: 20,
                              color: controller.selectedIndex.value == 1
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  controller.selectedIndex.value == 0
                      ? ListProductsView()
                      : GridProductsView()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
