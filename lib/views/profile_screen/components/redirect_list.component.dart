import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RedirectListComponent extends StatelessWidget {
  const RedirectListComponent(
      {Key? key,
      required this.imageUrl,
      required this.title,
      this.dividerUnderTitle = false,
      this.height = 70,
      this.onTap,
      this.rightArrow = true})
      : super(key: key);
  final String imageUrl;
  final String title;
  final bool dividerUnderTitle;
  final bool rightArrow;
  final double height;
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!imageUrl.contains('svg'))
                    Image.asset(
                      imageUrl,
                      height: 28,
                      width: 28,
                    ),
                  if (imageUrl.contains('svg'))
                    SvgPicture.asset(
                      imageUrl,
                      height: 28,
                      width: 28,
                    ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              title,
                              style: TextStyles.sgproRegular.f18.black,
                            ),
                          ),
                        ),
                        if (dividerUnderTitle)
                          Divider(
                            thickness: 0.8,
                            color: AppColors.greyLight,
                            height: 2,
                            endIndent: 10,
                          ),
                      ],
                    ),
                  ),
                  if (rightArrow) ...[
                    const Spacer(),
                    Icon(
                      Icons.arrow_right,
                      size: 28,
                      color: Colors.amber[800],
                    ),
                  ],
                ],
              ),
            ),
            if (!dividerUnderTitle)
              Divider(
                indent: 10.0,
                endIndent: 10.0,
                thickness: 0.8,
                color: AppColors.greyLight,
                height: 2,
              ),
          ],
        ),
      ),
    );
  }
}
