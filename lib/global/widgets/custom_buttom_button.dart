import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomBottomButton extends StatelessWidget {
  final String text;
  final void Function() onTap;
  final bool isLoading;
  CustomBottomButton(
      {required this.text, required this.onTap, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: 50,
        color: AppColors.secondaryColor,
        child: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : Text(
                  text,
                  style: TextStyles.sgproMedium.f24.white,
                ),
        ),
      ),
      onTap: onTap,
    );
  }
}
