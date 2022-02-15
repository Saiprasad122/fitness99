import 'package:fitness_99/global/utils/fontsAndSizes.dart';
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
          Dismissible(
            key: UniqueKey(),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  CircleAvatar(
                      radius: 35,
                      child:
                          Image.asset('assets/images/placeholders/user.png')),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Vinay', style: TextStyles.sgproMedium.f22),
                      RichText(
                        text: TextSpan(
                          text: 'Invite to join',
                          children: [
                            TextSpan(
                              text: ' Be a sprites ',
                              style: TextStyles.sgproMedium.f22,
                            ),
                            TextSpan(
                                text: 'group',
                                style: TextStyles.sgproRegular.f22.black)
                          ],
                          style: TextStyles.sgproRegular.f22.black,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
