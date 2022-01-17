import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/activity_view/componenet/activity_class.dart';
import 'package:flutter/material.dart';

class ActivityWidget extends StatelessWidget {
  final ActivityClass activityClass;
  const ActivityWidget({
    Key? key,
    required this.activityClass,
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
                    activityClass.title,
                    style: TextStyles.sgproMedium.f24,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    activityClass.description,
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
                        activityClass.location,
                        style: TextStyles.sgproBold.f22
                            .copyWith(color: AppColors.secondaryColor),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'From: ${activityClass.fromTime} To: ${activityClass.toTime}',
                        style: TextStyles.sgproBold.f20,
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
                    text: activityClass.notes,
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
