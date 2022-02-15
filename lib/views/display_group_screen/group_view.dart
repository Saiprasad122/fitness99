import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/global/router/app_pages.dart';
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
            onPressed: Get.back,
            color: Colors.black,
          ),
        ),
        body: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: displayGroups.group_image.contains('uploads')
                  ? displayGroups.group_image
                  : 'https://dev.99fitnessfriends.com/uploads${displayGroups.group_image}',
              placeholder: (context, s) => CircularProgressIndicator(),
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              width: AppSizedBoxConfigs.screenWidth,
              errorWidget: (context, value, error) =>
                  Image.asset('assets/images/placeholders/user.png'),
            ),
            DraggableScrollableSheet(
              initialChildSize: 0.6,
              minChildSize: 0.6,
              maxChildSize: 0.6,
              builder: (context, scrollController) {
                return ClipRRect(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    color: Colors.white,
                    width: AppSizedBoxConfigs.screenWidth,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        RedirectListComponent(
                          imageUrl: 'assets/images/tabbar/categories.png',
                          title: 'Group Categories',
                          iconData: Icons.keyboard_arrow_right_outlined,
                          onTap: () =>
                              Get.toNamed(Routes.MyGroupCategoriesScreen),
                          backgroundColor: Colors.white,
                        ),
                        RedirectListComponent(
                          imageUrl: 'assets/images/group_screen/add_friend.png',
                          title: 'Invite Members',
                          iconData: Icons.keyboard_arrow_right_outlined,
                          onTap: () => Get.toNamed(Routes.InviteMembersScreen),
                          backgroundColor: Colors.white,
                        ),
                        RedirectListComponent(
                          imageUrl:
                              'assets/images/group_screen/group_limit_increase.png',
                          title: 'Group limit increase',
                          iconData: Icons.keyboard_arrow_right_outlined,
                          onTap: () => Get.toNamed(Routes.GroupLimitIncrease),
                          backgroundColor: Colors.white,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        )
        // Column(
        //   children: [
        //     Expanded(
        //       flex: 3,
        //       child: CachedNetworkImage(
        //         imageUrl: displayGroups.group_image.contains('uploads')
        //             ? displayGroups.group_image
        //             : 'https://dev.99fitnessfriends.com/uploads${displayGroups.group_image}',
        //         placeholder: (context, s) => CircularProgressIndicator(),
        //         filterQuality: FilterQuality.high,
        //         fit: BoxFit.cover,
        //         width: AppSizedBoxConfigs.screenWidth,
        //         errorWidget: (context, value, error) =>
        //             Image.asset('assets/images/placeholders/user.png'),
        //       ),
        //     ),
        //     Expanded(
        //       flex: 4,
        //       child: Padding(
        //         padding: const EdgeInsets.symmetric(horizontal: 20),
        //         child: Column(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           children: [
        //             RedirectListComponent(
        //               imageUrl: 'assets/images/tabbar/categories.png',
        //               title: 'Group Categories',
        //               iconData: Icons.keyboard_arrow_right_outlined,
        //               backgroundColor: Colors.white,
        //             ),
        //             RedirectListComponent(
        //               imageUrl: 'assets/images/group_screen/add_friend.png',
        //               title: 'Invite Members',
        //               iconData: Icons.keyboard_arrow_right_outlined,
        //               backgroundColor: Colors.white,
        //             ),
        //             RedirectListComponent(
        //               imageUrl:
        //                   'assets/images/group_screen/group_limit_increase.png',
        //               title: 'Group limit increase',
        //               iconData: Icons.keyboard_arrow_right_outlined,
        //               backgroundColor: Colors.white,
        //             ),
        //           ],
        //         ),
        //       ),
        //     )
        //   ],
        // ),
        );
  }
}
