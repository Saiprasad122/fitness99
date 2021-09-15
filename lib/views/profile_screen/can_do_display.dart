import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_buttom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CanDoDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Can Do Details',
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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                itemCount: 20,
                itemBuilder: (context, i) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Text(
                          'Workout everyday in the morning',
                          textAlign: TextAlign.left,
                          style: TextStyles.sgproRegular.f18,
                        ),
                      ),
                      Divider(thickness: 0.5, color: Colors.grey)
                    ],
                  );
                },
              ),
            ),
          ),
          CustomBottomButton(
            text: 'AddNew',
            onTap: () => Get.toNamed(Routes.CanDoAdd),
          )
        ],
      ),
    );
  }
}
