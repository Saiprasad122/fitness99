import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomProductList extends StatelessWidget {
  final String title, subtitle, imgName;
  const CustomProductList({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.imgName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Row(
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
              Divider(
                height: 1,
                thickness: 1,
              )
            ],
          ),
        ],
      ),
    );
  }
}
