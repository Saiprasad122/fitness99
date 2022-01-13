import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class ActivityWidget extends StatelessWidget {
  final String title, desciription, location, notes, fromTime, toTime;
  const ActivityWidget({
    Key? key,
    required this.title,
    required this.desciription,
    required this.location,
    required this.notes,
    required this.fromTime,
    required this.toTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
                    title,
                    style: TextStyles.sgproMedium.f24,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    desciription,
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
                        location,
                        style: TextStyles.sgproBold.f22
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'From: ${fromTime} To: ${toTime}',
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
                    text: notes,
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
