import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
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
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              itemCount: 5,
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GestureDetector(
              child: Container(
                height: 50,
                color: Colors.lightBlueAccent,
                child: Center(
                  child: Text(
                    'AddNew',
                    style: TextStyles.sgproMedium.f20.white,
                  ),
                ),
              ),
              onTap: () => Get.toNamed(Routes.CanDoAdd),
            ),
          )
        ],
      ),
    );
  }
}
