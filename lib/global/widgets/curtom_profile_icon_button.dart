import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomProfileIconButtom extends StatelessWidget {
  const CustomProfileIconButtom({Key? key, required this.profileName})
      : super(key: key);
  final String profileName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {},
              child: CircleAvatar(
                radius: 35,
                child: Image.asset(
                  'assets/images/placeholders/user.png',
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(profileName, style: TextStyles.sgproBold.f24),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
