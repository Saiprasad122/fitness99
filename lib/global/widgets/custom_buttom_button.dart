import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomBottomButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  CustomBottomButton({
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        color: Colors.amber[700],
        child: Center(
          child: Text(
            text,
            style: TextStyles.sgproMedium.f24.white,
          ),
        ),
      ),
      onTap: onTap,
    );
  }
}
