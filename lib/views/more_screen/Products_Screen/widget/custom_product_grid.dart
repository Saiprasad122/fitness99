import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductGrid extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imgName;
  final void Function() onTap;
  const CustomProductGrid({
    required this.title,
    required this.subtitle,
    required this.imgName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DetailedProductScreen),
      child: Column(
        children: [
          Container(
            width: 130,
            height: 110,
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: Image.asset(
                'assets/images/product_screen/$imgName',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            title,
            style: TextStyles.sgproMedium.f20,
          ),
          Text(
            subtitle,
            style: TextStyles.sgproRegular.greyMid,
          )
        ],
      ),
    );
  }
}
