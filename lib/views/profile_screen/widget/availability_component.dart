import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/models/preferences_response.dart';
import 'package:flutter/material.dart';

class AvailabiltyComponent extends StatelessWidget {
  final String day;
  final List<PreferenceResponse> dayPreferenceList;
  const AvailabiltyComponent(
      {Key? key, required this.day, required this.dayPreferenceList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(day, style: TextStyles.sgproBold.f22),
            const SizedBox(height: 10),
            dayPreferenceList.isNotEmpty
                ? ListView.separated(
                    itemCount: dayPreferenceList.length,
                    separatorBuilder: (context, i) => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(width: 5),
                        Text(
                          '||',
                          style: TextStyles.sgproMedium.f20,
                        ),
                        const SizedBox(width: 5),
                      ],
                    ),
                    itemBuilder: (context, i) => Text(
                      '${dayPreferenceList[i].from_time}-${dayPreferenceList[i].to_time}',
                      style: TextStyles.sgproMedium.f20,
                    ),
                    scrollDirection: Axis.horizontal,
                  )
                : Text('Not Available', style: TextStyles.sgproMedium.f20)
          ],
        ),
      ),
    );
  }
}
