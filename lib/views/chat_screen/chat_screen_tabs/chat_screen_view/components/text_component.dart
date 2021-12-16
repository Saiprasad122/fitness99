import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextComponent extends StatelessWidget {
  final String text;
  final DateTime dateTime;
  TextComponent({Key? key, required this.text, required this.dateTime})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Align(
        alignment: (Alignment.topLeft),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: (Colors.blue[200]),
          ),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                text,
                // snapshot.data!.docs[index]
                //     ['message'],
                style: TextStyle(fontSize: 15),
              ),
              Text(
                DateFormat.jm().format(dateTime),
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
        ),
      ),
    );
  }
}
