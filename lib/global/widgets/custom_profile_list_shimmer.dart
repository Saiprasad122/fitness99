import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomProfileListShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.greyLight,
      highlightColor: AppColors.greyVeryLight,
      child: ListView.builder(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        itemCount: 10,
        itemBuilder: (context, i) {
          return Padding(
            padding: const EdgeInsets.all(10),
            child: ListTile(
              contentPadding: const EdgeInsets.all(0),
              leading: const CircleAvatar(
                radius: 40,
                child: const SizedBox(),
              ),
              title: Container(
                height: 20,
                width: 20,
                color: Colors.white,
              ),
            ),
          );
        },
      ),
    );
  }
}
