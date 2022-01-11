import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/views/profile_screen/widget/redirect_list.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupView extends StatelessWidget {
  const GroupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_outlined),
          onPressed: () => Get.back(),
          color: Colors.black,
        ),
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/search_screen/fitness.png',
            height: AppSizedBoxConfigs.screenHeight * 0.5,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: AppSizedBoxConfigs.screenHeight * 0.4,
                ),
                RedirectListComponent(
                  imageUrl: 'assets/images/tabbar/categories.png',
                  title: 'Group Categories',
                  iconData: Icons.keyboard_arrow_right_outlined,
                  backgroundColor: Colors.white,
                ),
                RedirectListComponent(
                  imageUrl: 'assets/images/group_screen/add_friend.png',
                  title: 'Invite Members',
                  iconData: Icons.keyboard_arrow_right_outlined,
                  backgroundColor: Colors.white,
                ),
                RedirectListComponent(
                  imageUrl:
                      'assets/images/group_screen/group_limit_increase.png',
                  title: 'Group limit increase',
                  iconData: Icons.keyboard_arrow_right_outlined,
                  backgroundColor: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
