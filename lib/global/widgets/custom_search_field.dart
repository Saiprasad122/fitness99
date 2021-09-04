import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomSearchFeild extends StatelessWidget {
  final Function(String?)? onChanged;
  final Function(String?)? onSubmitted;

  CustomSearchFeild({
    this.onChanged,
    this.onSubmitted,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextField(
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          style: TextStyles.sgproRegular.f20,
          maxLines: 1,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.zero,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25),
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            prefixIcon: Icon(
              Icons.search_rounded,
              color: Colors.amber[800],
            ),
            hintText: 'Search',
            hintStyle: TextStyles.sgproRegular.f20.greyLight,
          ),
        ),
      );
}
