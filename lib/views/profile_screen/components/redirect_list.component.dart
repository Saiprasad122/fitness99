import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class RedirectListComponent extends StatelessWidget {
  const RedirectListComponent(
      {Key? key, required this.imageUrl, required this.title})
      : super(key: key);
  final String imageUrl;
  final String title;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: 70,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                  vertical: 10.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      imageUrl,
                      height: 28,
                      width: 28,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Text(
                      title,
                      style: TextStyles.sgproRegular.f18.black,
                    ),
                    const Spacer(),
                    Icon(
                      Icons.arrow_right,
                      size: 28,
                      color: Colors.amber[800],
                    ),
                  ],
                ),
              ),
            ),
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
