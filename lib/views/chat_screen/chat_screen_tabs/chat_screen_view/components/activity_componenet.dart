import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivityComponent extends StatelessWidget {
  final String message;
  final DateTime dateTime;
  final bool fromOther;
  const ActivityComponent({
    Key? key,
    required this.message,
    required this.dateTime,
    required this.fromOther,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {},
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Align(
                alignment: (Alignment.topLeft),
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 200,
                    minWidth: 10,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.blue[200]
                      // color: fromOther ? Colors.grey[200] : AppColors.secondaryColor,
                      ),
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: fromOther
                        ? CrossAxisAlignment.start
                        : CrossAxisAlignment.end,
                    children: [
                      Text(message, style: TextStyles.sgproRegular.f16.black),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              DateFormat.jm().format(dateTime),
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
                color: Colors.black38,
              ),
            )
          ],
        ));
  }
}
