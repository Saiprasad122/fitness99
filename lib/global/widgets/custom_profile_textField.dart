import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomProfileTextField extends StatelessWidget {
  final String displayText;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final String? hintText;
  final IconData? iconData;
  final String errText;
  final Key? key;
  final FocusNode? focusNode;
  final bool isObscureText;
  final String obscuringText;
  final int? maxLength;
  final List<TextInputFormatter>? textInputFormatter;
  final Function(String)? onSubmitted;
  final Function(String)? onChanged;

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
    this.maxLength,
    this.textInputFormatter,
    this.onSubmitted,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayText,
              style: TextStyles.sgproMedium.f22.greyMid,
            ),
            TextField(
              key: key,
              focusNode: focusNode,
              onChanged: onChanged,
              onSubmitted: onSubmitted,
              obscureText: isObscureText,
              obscuringCharacter: obscuringText,
              style: TextStyles.sgproRegular.f20,
              controller: textEditingController,
              maxLength: maxLength,
              inputFormatters: textInputFormatter,
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
                  TextStyles.sgproRegular.f18.copyWith(color: Colors.red[700]),
            )
          ],
        ),
      );
}
