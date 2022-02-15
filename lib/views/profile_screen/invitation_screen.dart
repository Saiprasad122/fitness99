import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/profile_screen/widget/dismissable_user_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PendingInvitationScreen extends StatelessWidget {
  PendingInvitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: ListView(
        children: [
          DismissableUserViewWidget(
            title: 'Vinay',
            groupName: 'Be a sprites',
          )
        ],
      ),
    );
  }
}
