import 'package:cached_network_image/cached_network_image.dart';
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
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: Colors.white,
          child: SizedBox.expand(
            child: ClipOval(
                child: CachedNetworkImage(
              imageUrl: groupImage,
              placeholder: (context, s) => CircularProgressIndicator(),
              filterQuality: FilterQuality.high,
              fit: BoxFit.contain,
              errorWidget: (context, value, error) =>
                  Image.asset('assets/images/placeholders/user.png'),
            )),
          ),
        ),
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
