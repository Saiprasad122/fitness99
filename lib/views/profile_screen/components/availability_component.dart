import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class AvailabiltyComponent extends StatelessWidget {
  final day;
  const AvailabiltyComponent({Key? key, required this.day}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          day,
          style: TextStyles.sgproBold.f22,
        ),
        SizedBox(height: 10),
        Text(
          'Not Available',
          style: TextStyles.sgproRegular.f20.copyWith(color: Colors.amber[700]),
        ),
      ],
    );
  }
}
