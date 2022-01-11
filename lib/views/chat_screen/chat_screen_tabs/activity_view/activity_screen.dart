import 'package:fitness_99/controllers/chat_screen_controller/activity_controller.dart/activity_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActivityScreen extends StatelessWidget {
  ActivityScreen({Key? key}) : super(key: key);
  final controller = Get.put(ActivityController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Test title',
                style: TextStyles.sgproMedium.f26,
              ),
              Text(
                'Test decription',
                style: TextStyles.sgproMedium.f18.greyMid,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.location_on,
                    color: AppColors.secondaryColor,
                    size: 28,
                  ),
                  Text(
                    'Test location',
                    style: TextStyles.sgproBold.f24
                        .copyWith(color: AppColors.secondaryColor),
                  ),
                  Text(
                    'From: 08:30:00 To: 10:30:00',
                    style: TextStyles.sgproBold.f18,
                  ),
                ],
              ),
              Divider(
                color: Colors.grey,
                height: 1,
                thickness: 1,
              ),
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Note : ', style: TextStyles.sgproBold.f18.black),
                  TextSpan(
                    text: 'Test Notes',
                    style: TextStyles.sgproMedium.f18.greyMid,
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}
