import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomProfileTextField extends StatelessWidget {
  final String displayText;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final String? hintText;
  final IconData? iconData;
  final errText;
  final Key? key;
  final FocusNode? focusNode;
  final bool isObscureText;
  final String obscuringText;

  CustomProfileTextField({
    required this.displayText,
    required this.hintText,
    this.iconData,
    this.textEditingController,
    this.textInputType,
    this.errText = '',
    this.key,
    this.focusNode,
    this.isObscureText = false,
    this.obscuringText = '*',
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayText,
              style: TextStyles.sgproMedium.f20.greyMid,
            ),
            TextField(
              key: key,
              focusNode: focusNode,
              obscureText: isObscureText,
              obscuringCharacter: obscuringText,
              style: TextStyles.sgproRegular.f20,
              controller: textEditingController,
              keyboardType: textInputType,
              autofocus: false,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyles.sgproRegular.f20.greyMid,
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              errText,
              style:
                  TextStyles.sgproRegular.f16.copyWith(color: Colors.red[700]),
            )
          ],
        ),
      );
}
