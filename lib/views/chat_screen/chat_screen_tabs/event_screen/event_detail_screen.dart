import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/curtom_profile_icon_button.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'component/event_class.dart';

class EventDetailScreen extends StatelessWidget {
  final EventClass eventClass;
  const EventDetailScreen({Key? key, required this.eventClass})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Event Details',
          style: TextStyles.sgproBold.f26.black,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      eventClass.title,
                      style: TextStyles.sgproBold.f26,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      eventClass.description,
                      style: TextStyles.sgproRegular.f20.greyMid,
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              color: Colors.amber[800],
                            ),
                            const SizedBox(width: 5),
                            Text(
                              eventClass.location,
                              style: TextStyles.sgproBold.f20
                                  .copyWith(color: Colors.amber[800]),
                            )
                          ],
                        ),
                        Container(
                          height: 40,
                          width: 2,
                          color: Colors.black,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.amber[800],
                            ),
                            const SizedBox(width: 5),
                            Text(
                              '${eventClass.date} ${eventClass.time}',
                              style: TextStyles.sgproBold.f20,
                            )
                          ],
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Divider(
                      color: Colors.black,
                      thickness: 1,
                      height: 1,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Checkin Users',
                      style: TextStyles.sgproBold.f26,
                    ),
                    const SizedBox(height: 20),
                    CustomProfileIconButtom(profileName: 'Venkat'),
                    CustomProfileIconButtom(profileName: 'Venkat'),
                    CustomProfileIconButtom(profileName: 'Venkat'),
                    CustomProfileIconButtom(profileName: 'Venkat'),
                    CustomProfileIconButtom(profileName: 'Venkat'),
                    CustomProfileIconButtom(profileName: 'Venkat'),
                    CustomProfileIconButtom(profileName: 'Venkat'),
                    CustomProfileIconButtom(profileName: 'Venkat'),
                  ],
                ),
              ),
            ),
          ),
          CustomBottomButton(
            text: 'Check in',
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text(
                      'Success',
                      style: TextStyles.sgproMedium.f24,
                    ),
                    content: Text(
                      'Checked In Successfully!',
                      style: TextStyles.sgproMedium.f24,
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Get.back(),
                        child: Text(
                          'OK',
                          style: TextStyles.sgproRegular.f20.black,
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          )
        ],
      ),
    );
  }
}
