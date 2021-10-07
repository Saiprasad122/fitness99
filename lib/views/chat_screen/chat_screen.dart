import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: AppColors.secondaryColor,
            tabs: [
              Tab(
                icon: Icon(
                  Icons.car_rental,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.car_rental,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.car_rental,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.car_rental,
                  color: Colors.black,
                ),
              ),
              Tab(
                icon: Icon(
                  Icons.more,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Demo Group Name',
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
        body: Center(
          child: Text('Chat Screen'),
        ),
      ),
    );
  }
}
