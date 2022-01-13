import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class ActivityWidget extends StatelessWidget {
  const ActivityWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        margin: const EdgeInsets.all(10),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Test title',
                    style: TextStyles.sgproMedium.f24,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Test decription',
                    style: TextStyles.sgproMedium.f16.greyMid,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: AppColors.secondaryColor,
                        size: 26,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Test location',
                        style: TextStyles.sgproBold.f22
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'From: 08:30:00 To: 10:30:00',
                        style: TextStyles.sgproBold.f16,
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              height: 1,
              thickness: 1,
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Note : ', style: TextStyles.sgproBold.f18.black),
                  TextSpan(
                    text: 'Test Notes',
                    style: TextStyles.sgproMedium.f18.greyMid,
                  )
                ]),
              ),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
