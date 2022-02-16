import 'package:fitness_99/controllers/chat_screen_controller/group_user_request_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/profile_screen/widget/dismissable_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../another_profile_view.dart';

class GroupUserRequestScreen extends StatefulWidget {
  final int group_id;
  GroupUserRequestScreen({Key? key, required this.group_id}) : super(key: key);

  @override
  State<GroupUserRequestScreen> createState() => _GroupUserRequestScreenState();
}

class _GroupUserRequestScreenState extends State<GroupUserRequestScreen> {
  @override
  Widget build(BuildContext context) {
    final controller =
        Get.put(GroupUserRequestController(group_id: widget.group_id));
    return Obx(
      () => Stack(
        children: [
          controller.userList.isEmpty && controller.isBusy.value
              ? Center(
                  child: Text(
                    'No Invitaitions',
                    style: TextStyles.sgproMedium.f24,
                  ),
                )
              : ListView.builder(
                  itemCount: controller.userList.length,
                  itemBuilder: (context, i) => DismissableUserViewWidget(
                    title: controller.userList[i].userName,
                    wantsToJoinGroup: true,
                    avatarUrl: controller.userList[i].profilePicture ?? '',
                    onRejectTap: (dismiss) async {
                      await controller
                          .rejectUser(controller.userList[i].id.toString());
                      await dismiss();
                      // controller.removeUserAtIndex(i);
                    },
                    onAcceptTap: (dismiss) async {
                      await controller
                          .acceptUser(controller.userList[i].id.toString());

                      await dismiss();
                      // controller.removeUserAtIndex(i);
                    },
                    onTap: () => Get.to(
                      () => AnotherProfileView(
                        user: controller.userList[i],
                      ),
                    ),
                  ),
                  // itemBuilder: (context, i) => Slidable(
                  //   key: UniqueKey(),
                  //   child: Padding(
                  //     padding: const EdgeInsets.all(10),
                  //     child: Row(
                  //       children: [
                  //         CircleAvatar(
                  //           radius: 35,
                  //           child: Image.asset(
                  //               'assets/images/placeholders/user.png'),
                  //         ),
                  //         const SizedBox(width: 10),
                  //         Column(
                  //           crossAxisAlignment: CrossAxisAlignment.start,
                  //           children: [
                  //             Text(controller.userList[i].user_name,
                  //                 style: TextStyles.sgproMedium.f22),
                  //             RichText(
                  //               text: TextSpan(
                  //                 text: controller.userList[i].user_name,
                  //                 children: [
                  //                   TextSpan(
                  //                     text: ' want to join this group ',
                  //                     style: TextStyles.sgproRegular.f22,
                  //                   ),
                  //                 ],
                  //                 style: TextStyles.sgproMedium.f22.black,
                  //               ),
                  //             )
                  //           ],
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  //   startActionPane: ActionPane(
                  //     motion: StretchMotion(),
                  //     children: [
                  //       SlidableAction(
                  //         onPressed: (context) {},
                  //         icon: Icons.check,
                  //         backgroundColor: Colors.green,
                  //       ),
                  //       SlidableAction(
                  //         onPressed: (context) {},
                  //         icon: Icons.close,
                  //         backgroundColor: Colors.red,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ),
          controller.isBusy.value
              ? const Center(child: CircularProgressIndicator())
              : const SizedBox(),
        ],
      ),
    );
  }
}
