import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/core/services/user_model_service.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnotherProfileView extends StatelessWidget {
  AnotherProfileView({Key? key}) : super(key: key);
  final userModel = Get.find<UserModelService>();

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
                    child: userModel.getProfilePicture().contains('N/A')
                        ? Image.asset('assets/images/placeholders/user.png')
                        : CachedNetworkImage(
                            imageUrl: userModel.getProfilePicture(),
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
                'Saiprasad',
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
                    userModel.getMobileNumber() == 'N/A'
                        ? 'Please update your phone number'
                        : userModel.getMobileNumber(),
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
                    userModel.getEmail(),
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
              Text('2', style: TextStyles.sgproMedium.f26),
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
