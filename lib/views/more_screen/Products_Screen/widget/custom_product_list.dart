import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomProductList extends StatelessWidget {
  final String title, subtitle, imgName;
  final void Function() onTap;
  const CustomProductList(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.imgName,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.DetailedProductScreen),
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        height: 70,
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: Image.asset(
                  'assets/images/product_screen/$imgName',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
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
                        Text(
                          "10.99\$",
                          style: TextStyles.sgproBold,
                        ),
                      ],
                    ),
                  ),
                  const Divider(
                    height: 1,
                    thickness: 1,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
