import 'package:fitness_99/global/router/app_pages.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class GroupLimitIncrease extends StatelessWidget {
  const GroupLimitIncrease({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Your Requests',
          style: TextStyles.sgproMedium.f26.black,
        ),
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.black,
          ),
        ),
        actions: [
          IconButton(
            padding: const EdgeInsets.only(right: 40),
            icon: SvgPicture.asset(
              'assets/svgs/chat_screen/add.svg',
              width: 20,
              height: 20,
              color: AppColors.secondaryColor,
            ),
            onPressed: () => Get.toNamed(Routes.GroupLimitCreateRequest),
          ),
        ],
      ),
      body: ListView.separated(
        physics: BouncingScrollPhysics(),
        separatorBuilder: (context, i) => const Divider(
          height: 1,
          thickness: 1,
          color: Colors.black26,
        ),
        itemBuilder: (context, i) => ListTile(
          title: Text('demo rquest ${i + 1}'),
          subtitle: Text(DateFormat('dd-MM-yyyy,hh:mm').format(DateTime.now())),
        ),
        itemCount: 12,
      ),
    );
  }
}
