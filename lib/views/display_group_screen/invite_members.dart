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
            : Column(
                children: [
                  ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, i) => ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: SizedBox.expand(
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: controller
                                            .userList[i].profile_picture
                                            .toString()
                                            .contains('uploads')
                                        ? '${controller.userList[i].profile_picture}'
                                        : 'https://dev.99fitnessfriends.com/uploads/${controller.userList[i].profile_picture}',
                                    placeholder: (context, s) =>
                                        CircularProgressIndicator(),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, value, error) =>
                                        Image.asset(
                                            'assets/images/placeholders/user.png'),
                                  ),
                                ),
                              ),
                            ),
                            title: Text(controller.userList[i].user_name),
                            trailing: IconButton(
                                onPressed: () => controller.sendRequest(
                                    group_id: group_id,
                                    user_id: controller.userList[i].id),
                                icon: Icon(Icons.add)),
                          ),
                      itemCount: controller.userList.length),
                  ListView.separated(
                      shrinkWrap: true,
                      padding: const EdgeInsets.all(10),
                      separatorBuilder: (context, i) =>
                          const SizedBox(height: 15),
                      itemBuilder: (context, i) => ListTile(
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.white,
                              child: SizedBox.expand(
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl: controller
                                            .pendingUserList[i].profile_picture
                                            .toString()
                                            .contains('uploads')
                                        ? '${controller.pendingUserList[i].profile_picture}'
                                        : 'https://dev.99fitnessfriends.com/uploads/${controller.pendingUserList[i].profile_picture}',
                                    placeholder: (context, s) =>
                                        CircularProgressIndicator(),
                                    filterQuality: FilterQuality.high,
                                    fit: BoxFit.cover,
                                    errorWidget: (context, value, error) =>
                                        Image.asset(
                                            'assets/images/placeholders/user.png'),
                                  ),
                                ),
                              ),
                            ),
                            title:
                                Text(controller.pendingUserList[i].user_name),
                            trailing: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(Icons.pending_outlined),
                            ),
                          ),
                      itemCount: controller.pendingUserList.length),
                ],
              ),
      ),
    );
  }
}
