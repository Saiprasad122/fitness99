import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePollView extends StatelessWidget {
  const CreatePollView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Create Poll',
          style: TextStyles.sgproMedium.f26.black,
        ),
        leading: IconButton(
          onPressed: Get.back,
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
