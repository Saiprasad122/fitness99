import 'package:fitness_99/controllers/chat_screen_controller/create_poll_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreatePollView extends StatelessWidget {
  final controller = Get.put(CreatePollController());
  CreatePollView({Key? key}) : super(key: key);

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
      body: Obx(
        () => Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Question',
                      style: TextStyles.sgproMedium.f24.greyMid,
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: controller.questionTED,
                      style: TextStyles.sgproRegular.f20,
                      keyboardType: TextInputType.multiline,
                      maxLines: 5,
                      maxLength: 250,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          gapPadding: 2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: 'Enter Question here...',
                        hintStyle: TextStyles.sgproRegular.f20.greyMid,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          gapPadding: 2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      'data',
                      style: TextStyles.sgproRegular.f16.error,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
