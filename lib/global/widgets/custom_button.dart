import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final Color? color;
  late final TextStyle? textStyle;

  CustomButton({
    required this.text,
    required this.onTap,
    required this.color,
    TextStyle? style,
  }) {
    this.textStyle = style ?? TextStyles.sgproMedium.f20.white;
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onTap,
        child: Text(
          text,
          style: TextStyles.sgproMedium.f20.white,
        ),
        style: ElevatedButton.styleFrom(
          primary: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }
}
