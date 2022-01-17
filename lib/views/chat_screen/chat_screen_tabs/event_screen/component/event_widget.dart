import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/event_screen/event_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'event_class.dart';

class EventWidget extends StatelessWidget {
  final String title, description, location, date, time;
  const EventWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.location,
    required this.date,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => EventDetailScreen(
            eventClass: EventClass(
              title: title,
              description: description,
              location: location,
              date: date,
              time: time,
            ),
          )),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(10),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyles.sgproBold.f24,
              ),
              const SizedBox(height: 10),
              Text(
                description,
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
                        location,
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
                        '${date} ${time}',
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
    );
  }
}
