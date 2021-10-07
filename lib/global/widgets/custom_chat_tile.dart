import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';

class CustomChatTile extends StatelessWidget {
  final String groupName, groupGoal, groupImage;
  final void Function() onTap;
  const CustomChatTile({
    required this.groupName,
    required this.groupGoal,
    required this.groupImage,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
          if (states.contains(MaterialState.pressed)) return Colors.grey;
          return Colors.grey;
        }),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.zero),
      ),
      onPressed: onTap,
      child: ListTile(
        leading: groupImage.contains('')
            ? Image.asset('assets/images/search_screen/fitness.png')
            : Image.network(groupImage),
        title: Text(
          groupName,
          style: TextStyles.sgproRegular.f18,
        ),
        subtitle: Text(
          groupGoal,
          style: TextStyles.sgproRegular.f18.greyMid,
        ),
      ),
    );
  }
}
