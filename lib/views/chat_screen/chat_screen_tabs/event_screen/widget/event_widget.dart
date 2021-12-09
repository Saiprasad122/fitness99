import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/event_screen/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EventWidget extends StatelessWidget {
  const EventWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => EventDetailScreen()),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Test event',
                  style: TextStyles.sgproBold.f24,
                ),
                const SizedBox(height: 10),
                Text(
                  'Test description',
                  style: TextStyles.sgproRegular.f20.greyMid,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: Colors.amber[800],
                        ),
                        const SizedBox(width: 5),
                        Text(
                          'New York',
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
                          '23 Dec-2020 10:30 PM',
                          style: TextStyles.sgproBold.f20,
                        )
                      ],
                    )
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
