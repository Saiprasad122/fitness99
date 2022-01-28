import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/global/utils/dimensions.dart';
import 'package:fitness_99/models/display_group_reponse.dart';
import 'package:fitness_99/views/profile_screen/widget/redirect_list.component.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GroupView extends StatelessWidget {
  final DisplayGroups displayGroups;
  const GroupView({Key? key, required this.displayGroups}) : super(key: key);

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
          CachedNetworkImage(
            height: AppSizedBoxConfigs.screenHeight * 0.4,
            imageUrl: displayGroups.group_image.contains('uploads')
                ? displayGroups.group_image
                : 'https://dev.99fitnessfriends.com/uploads${displayGroups.group_image}',
            placeholder: (context, s) => CircularProgressIndicator(),
            filterQuality: FilterQuality.high,
            fit: BoxFit.fill,
            errorWidget: (context, value, error) =>
                Image.asset('assets/images/placeholders/user.png'),
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
