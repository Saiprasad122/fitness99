import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PollChatComponent extends StatefulWidget {
  const PollChatComponent({
    Key? key,
    required this.firebaseId,
    this.fromOther = false,
  }) : super(key: key);
  final String firebaseId;
  final bool fromOther;
  @override
  State<PollChatComponent> createState() => _PollChatComponentState();
}

class _PollChatComponentState extends State<PollChatComponent> {
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
                  color: Colors.blue[200]
                  // color: fromOther ? Colors.grey[200] : AppColors.secondaryColor,
                  ),
              padding: EdgeInsets.all(10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: widget.fromOther
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text('Working on POLL'.trim(),
                      style: TextStyles.sgproRegular.f16.black),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          DateFormat.jm().format(
            DateTime.now(),
          ),
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
