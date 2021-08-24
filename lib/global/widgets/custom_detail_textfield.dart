import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomDetailsTextField extends StatelessWidget {
  final String displayText;
  final TextEditingController? textEditingController;
  final TextInputType? textInputType;
  final String? hintText;
  final IconData? iconData;
  final String? Function(String?)? validator;
  final errText;
  final Key? key;
  final FocusNode? focusNode;
  final bool isObscureText;
  final String obscuringText;

  CustomDetailsTextField({
    required this.displayText,
    required this.iconData,
    required this.hintText,
    this.textEditingController,
    this.textInputType,
    this.validator,
    this.errText = '',
    this.key,
    this.focusNode,
    this.isObscureText = false,
    this.obscuringText = '*',
    // ignore: empty_constructor_bodies
  }) {}

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Text(
              displayText,
              style: TextStyles.sgproLight.f20.greyMid,
            ),
          ),
          TextFormField(
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
              prefixIcon: Icon(
                iconData,
                color: Colors.blue,
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            validator: validator,
          ),
          const SizedBox(height: 2),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Text(
              errText,
              style:
                  TextStyles.sgproRegular.f16.copyWith(color: Colors.red[700]),
            ),
          )
        ],
      );
}
