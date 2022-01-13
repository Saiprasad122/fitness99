import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomListEventShimmer extends StatelessWidget {
  const CustomListEventShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.greyMid,
      highlightColor: AppColors.greyLight,
      child: ListView.separated(
        separatorBuilder: (context, i) => const SizedBox(height: 5),
        physics: BouncingScrollPhysics(),
        itemCount: 12,
        itemBuilder: (conotext, i) {
          return Card(
            color: Colors.white.withOpacity(0.4),
            margin: const EdgeInsets.all(10),
            elevation: 5,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.white,
                    height: 20,
                    width: 50,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    height: 20,
                    width: AppSizedBoxConfigs.screenWidth * 0.3,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    color: Colors.white,
                    height: 20,
                    width: AppSizedBoxConfigs.screenWidth * 0.7,
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
