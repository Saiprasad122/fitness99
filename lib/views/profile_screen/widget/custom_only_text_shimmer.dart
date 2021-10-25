import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:flutter/material.dart';

class CustomOnlyTextShimmer extends StatelessWidget {
  const CustomOnlyTextShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: Colors.red,
          ),
          child: SizedBox(
            height: 15,
            width: AppSizedBoxConfigs.screenWidth * 0.6,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Divider(thickness: 0.5, color: Colors.grey)
      ],
    );
  }
}
