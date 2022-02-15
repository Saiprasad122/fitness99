import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/models/loginReposnseRequest/login_response.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnotherProfileView extends StatelessWidget {
  AnotherProfileView({Key? key, required this.user}) : super(key: key);
  final User user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: SizedBox.expand(
                  child: ClipOval(
                    child: user.profilePicture?.contains('N/A') ?? true
                        ? Image.asset('assets/images/placeholders/user.png')
                        : CachedNetworkImage(
                            imageUrl: user.profilePicture!,
                            placeholder: (context, s) =>
                                CircularProgressIndicator(),
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.fitWidth,
                            errorWidget: (context, value, error) => Image.asset(
                                'assets/images/placeholders/user.png'),
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                user.userName,
                style: TextStyles.sgproMedium.f26,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    user.number == null ||
                            user.number == 'N/A' ||
                            user.number != 0
                        ? 'Phone number not provided'
                        : user.number!,
                    style: TextStyles.sgproRegular.greyMid.f22,
                  )
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(width: 10),
                  Text(
                    user.email,
                    style: TextStyles.sgproRegular.greyMid.f22,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              Text(user.groupCount.toString(),
                  style: TextStyles.sgproMedium.f26),
              Text(
                'No of Groups',
                style: TextStyles.sgproRegular.f26.greyMid,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Divider(
                  thickness: 1,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ListTile(
                      leading: Image.asset(
                        'assets/images/tabbar/target.png',
                        height: 48,
                        width: 48,
                      ),
                      title: Text(
                        'Personal Goals',
                        style: TextStyles.sgproRegular.f26,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/images/tabbar/dos&donts.png',
                        height: 48,
                        width: 48,
                      ),
                      title: Text(
                        'Can do',
                        style: TextStyles.sgproRegular.f26,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/images/tabbar/dos&donts.png',
                        height: 48,
                        width: 48,
                      ),
                      title: Text(
                        'Cannot do',
                        style: TextStyles.sgproRegular.f26,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                    ListTile(
                      leading: Image.asset(
                        'assets/images/tabbar/timer.png',
                        height: 48,
                        width: 48,
                      ),
                      title: Text(
                        'Preference Time',
                        style: TextStyles.sgproRegular.f26,
                      ),
                    ),
                    Divider(
                      thickness: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    ));
  }
}
