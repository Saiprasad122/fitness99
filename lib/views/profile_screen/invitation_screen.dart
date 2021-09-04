import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({Key? key}) : super(key: key);

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
      body: Container(),
    );
  }
}
