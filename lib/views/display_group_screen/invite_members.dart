import 'package:cached_network_image/cached_network_image.dart';
import 'package:fitness_99/controllers/group_screen_controller/invite_members_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_profile_list_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InviteMembersScreen extends StatelessWidget {
  final int group_id;
  const InviteMembersScreen({Key? key, required this.group_id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InviteMembersController(group_id: group_id));
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Invite Members',
          style: TextStyles.sgproMedium.f26.black,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
      body: Obx(
        () => controller.isBusy.value
            ? CustomProfileListShimmer()
            : ListView.separated(
                padding: const EdgeInsets.all(10),
                separatorBuilder: (context, i) => const SizedBox(height: 15),
                itemBuilder: (context, i) => ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: SizedBox.expand(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: controller.userList[i].profilePicture
                                  .toString()
                                  .contains('uploads')
                              ? '${controller.userList[i].profilePicture}'
                              : 'https://dev.99fitnessfriends.com/uploads/${controller.userList[i].profilePicture}',
                          placeholder: (context, s) =>
                              CircularProgressIndicator(),
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.contain,
                          errorWidget: (context, value, error) => Image.asset(
                              'assets/images/placeholders/user.png'),
                        ),
                      ),
                    ),
                  ),
                  title: Text(controller.userList[i].userName),
                ),
                itemCount: controller.userList.length,
              ),
      ),
    );
  }
}
