import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MoreOptionsWidget extends StatelessWidget {
  final String svgSrc, text;
  final void Function()? onTap;
  const MoreOptionsWidget(
      {required this.svgSrc, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.fromLTRB(10, 5, 0, 0),
        height: 40,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgSrc,
              width: 25,
              height: 25,
              color: AppColors.secondaryColor,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    heightFactor: 1.5,
                    widthFactor: 1,
                    child: Text(
                      text,
                      style: TextStyles.sgproRegular.f20,
                    ),
                  ),
                  const Spacer(),
                  const Divider(
                    height: 1,
                    color: Colors.grey,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
