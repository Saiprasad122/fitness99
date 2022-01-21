import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:flutter/material.dart';

class CustomProfileIconButtom extends StatelessWidget {
  const CustomProfileIconButtom({Key? key, required this.userData})
      : super(key: key);
  final User userData;

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
                radius: 30,
                backgroundColor: Colors.white,
                child: SizedBox.expand(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: userData.profilePicture.contains('uploads')
                          ? userData.profilePicture
                          : 'https://dev.99fitnessfriends.com/uploads${userData.profilePicture}',
                      placeholder: (context, s) => CircularProgressIndicator(),
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.contain,
                      errorWidget: (context, value, error) =>
                          Image.asset('assets/images/placeholders/user.png'),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Text(userData.userName, style: TextStyles.sgproBold.f24),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
