import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/profile_screen/components/redirect_list.component.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 30,
                  foregroundImage:
                      AssetImage('assets/images/placeholders/user.png'),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  'Atish Manala',
                  style: TextStyles.sgproBold.black.f22,
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                  ),
                  color: Colors.amber[800],
                ),
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.phone,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    '9912471412',
                    style: TextStyles.sgproRegular.greyMid.f18,
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.email,
                    color: Colors.amber[800],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    'atishchandramanala@gmail.com',
                    style: TextStyles.sgproRegular.greyMid.f18,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Divider(
              height: 2,
              color: AppColors.greyDark,
              thickness: 0.8,
            ),
            Container(
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '1',
                        style: TextStyles.sgproMedium.black.f16,
                      ),
                      Text(
                        'No of Groups',
                        style: TextStyles.sgproRegular.greyMid.f16,
                      ),
                    ],
                  ),
                  VerticalDivider(
                    color: Colors.black,
                    thickness: 0.8,
                    width: 2,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '0',
                        style: TextStyles.sgproMedium.black.f16,
                      ),
                      Text(
                        'Pending Invitations',
                        style: TextStyles.sgproRegular.greyMid.f16,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              height: 2,
              color: AppColors.greyMid,
              thickness: 0.8,
            ),
            const SizedBox(
              height: 10,
            ),
            RedirectListComponent(
                imageUrl: 'assets/images/tabbar/target.png',
                title: 'Personal Goals'),
            RedirectListComponent(
                imageUrl: 'assets/images/tabbar/dos&donts.png',
                title: 'Can do'),
            RedirectListComponent(
                imageUrl: 'assets/images/tabbar/dos&donts.png',
                title: 'Cannot do'),
            RedirectListComponent(
                imageUrl: 'assets/images/tabbar/categories.png',
                title: 'Categories'),
            RedirectListComponent(
                imageUrl: 'assets/images/tabbar/timer.png',
                title: 'Preference Time'),
          ],
        ),
      ),
    );
  }
}
