import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomActivityListShimmer extends StatelessWidget {
  const CustomActivityListShimmer({Key? key}) : super(key: key);

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
            margin: const EdgeInsets.all(10),
            elevation: 5,
            color: Colors.grey.withOpacity(0.5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 20,
                        width: AppSizedBoxConfigs.screenWidth * 0.22,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Container(
                        height: 10,
                        width: AppSizedBoxConfigs.screenWidth * 0.3,
                        color: Colors.white,
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: AppSizedBoxConfigs.screenHeight * 0.4,
                        height: 20,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.black,
                  height: 1,
                  thickness: 1,
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 20,
                    width: AppSizedBoxConfigs.screenWidth * 0.3,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
