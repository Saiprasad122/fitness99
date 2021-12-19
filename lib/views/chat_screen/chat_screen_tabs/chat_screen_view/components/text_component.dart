import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final DateTime dateTime;
  final bool fromOther;
  TextComponent(
      {Key? key,
      required this.text,
      required this.dateTime,
      this.fromOther = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
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
                color: (Colors.blue[200]),
              ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: fromOther
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text(
                    text.trim(),
                    // snapshot.data!.docs[index]
                    //     ['message'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black87,
                    ),
                  ),
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
    );
  }
}
