import 'package:fitness_99/controllers/profile_screen/pending_invitation_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/profile_screen/widget/dismissable_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingInvitationScreen extends StatelessWidget {
  PendingInvitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PendingInvitationController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Invitations',
          style: TextStyles.sgproBold.f26.black,
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
        () => Stack(
          children: [
            controller.pendingInvitesList.isEmpty && !controller.isBusy.value
                ? Center(
                    child: Text(
                      'No Invitaitions',
                      style: TextStyles.sgproMedium.f24,
                    ),
                  )
                : ListView.builder(
                    itemCount: controller.pendingInvitesList.length,
                    itemBuilder: (context, i) => DismissableUserViewWidget(
                      title: controller.pendingInvitesList[i].userName ?? '',
                      groupName:
                          controller.pendingInvitesList[i].group?.group_name,
                      wantsToJoinGroup: false,
                      avatarUrl:
                          controller.pendingInvitesList[i].group?.group_image ??
                              '',
                      onRejectTap: (dismiss) async {
                        await controller.rejectGroupInvitation(
                            controller.pendingInvitesList[i].group!.id);
                        await dismiss();
                        controller.removeUserWithId(
                            controller.pendingInvitesList[i].group!.id);
                      },
                      onAcceptTap: (dismiss) async {
                        await controller.acceptGroupInvitation(
                            controller.pendingInvitesList[i].group!.id);

                        await dismiss();
                        controller.removeUserWithId(
                            controller.pendingInvitesList[i].group!.id);
                      },
                      onTap: () {},
                    ),
                  ),
            controller.isBusy.value
                ? const Center(child: CircularProgressIndicator())
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
