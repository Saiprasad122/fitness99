import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/global/widgets/custom_search_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class DisplayGroupScreen extends StatelessWidget {
  const DisplayGroupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'My Groups',
                    style: TextStyles.sgproBold.f34,
                  ),
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/svgs/chat_screen/add.svg',
                      width: 20,
                      height: 20,
                      color: AppColors.secondaryColor,
                    ),
                    onPressed: () => Get.toNamed(Routes.CreateGroupScreen),
                  )
                ],
              ),
              const SizedBox(height: 15),
              CustomSearchFeild(),
            ],
          ),
        ),
      ),
    );
  }
}
