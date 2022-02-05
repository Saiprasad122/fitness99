import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

class PollChatComponent extends StatefulWidget {
  const PollChatComponent({
    Key? key,
    required this.firebaseId,
    this.selectedIndex,
    this.fromOther = false,
  }) : super(key: key);
  final String firebaseId;
  final bool fromOther;
  final int? selectedIndex;
  @override
  State<PollChatComponent> createState() => _PollChatComponentState();
}

class _PollChatComponentState extends State<PollChatComponent> {
  final List<String> options = [
    'option1',
    'option2',
    'option3',
    'option4',
  ];
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
              margin: EdgeInsets.only(
                right: widget.fromOther ? 32 : 0,
                left: widget.fromOther ? 0 : 32,
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
                  Text(
                      'Poll Question will be right here, it can be big as hell and this can big as hell again it will'
                          .trim(),
                      style: TextStyles.sgproBold.f20.black),
                  const SizedBox(
                    height: 15,
                  ),
                  ...List.generate(
                    options.length,
                    (index) => PollOptionComponent(
                      optionName: options[index],
                      percentage: index * 12.5,
                      other: widget.fromOther,
                      isSelected: widget.selectedIndex == index,
                    ),
                  ),
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

class PollOptionComponent extends StatefulWidget {
  const PollOptionComponent({
    Key? key,
    required this.optionName,
    this.percentage,
    this.isSelected = false,
    this.other = false,
  }) : super(key: key);
  final String optionName;
  final double? percentage;
  final bool isSelected;
  final bool other;
  @override
  State<PollOptionComponent> createState() => _PollOptionComponentState();
}

class _PollOptionComponentState extends State<PollOptionComponent> {
  final containerKey = GlobalKey();
  double? ContainerWidth;
  void getContainerWidth(_) {
    if (containerKey.currentContext != null) {
      setState(() {
        ContainerWidth = containerKey.currentContext?.size?.width;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance?.addPostFrameCallback(getContainerWidth);

    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 6,
      ),
      child: Stack(
        children: [
          Container(
            key: containerKey,
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                12,
              ),
              color: AppColors.bgOffWhite,
            ),
          ),
          if (widget.percentage != null)
            Positioned(
              left: 0,
              child: Container(
                width: (ContainerWidth ?? 0) * (widget.percentage! / 100),
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    12,
                  ),
                  color: widget.isSelected
                      ? AppColors.highlighter.withOpacity(0.6)
                      : AppColors.greyLight.withOpacity(0.6),
                ),
              ),
            ),
          Container(
            width: double.infinity,
            height: 50,
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            alignment: Alignment.centerLeft,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.optionName,
                  style: widget.isSelected
                      ? TextStyles.sgproBold.f20.greyDark
                      : TextStyles.sgproMedium.f18.greyDark,
                ),
                if (widget.percentage != null)
                  Text(
                    '${widget.percentage?.toInt().toString() ?? 'N/A'} %',
                    style: TextStyles.sgproMedium.f18.greyDark,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
