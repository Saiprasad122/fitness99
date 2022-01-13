import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/activity_view/display_activity_screen.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/chat_screen_view/chat_screen_view.dart';
import 'package:fitness_99/views/chat_screen/chat_screen_tabs/event_screen/display_event_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'chat_screen_tabs/more_options_chat_screen/more_options_chat_screen.dart';

class ChatScreen extends StatelessWidget {
  final int group_id;
  final String group_name;
  const ChatScreen(this.group_id, this.group_name);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          bottom: TabBar(
            indicatorColor: AppColors.secondaryColor,
            indicatorWeight: 3,
            tabs: [
              Tab(
                icon: SvgPicture.asset(
                  'assets/svgs/chat_screen/chat_icon.svg',
                  color: Colors.black,
                  width: 25,
                  height: 25,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/svgs/chat_screen/calendar_event_icon.svg',
                  color: Colors.black,
                  width: 25,
                  height: 25,
                ),
              ),
              Tab(
                icon: SvgPicture.asset(
                  'assets/svgs/chat_screen/add_friend_icon.svg',
                  color: Colors.black,
                  width: 25,
                  height: 25,
                ),
              ),
              Tab(
                icon: Image.asset(
                  'assets/images/chat_screen/activity.png',
                  color: Colors.black,
                  width: 25,
                  height: 25,
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
            group_name,
            style: TextStyles.sgproBold.f26.black,
          ),
          leading: Hero(
            tag: 'back_button',
            child: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ),
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ChatScreenView(group_id),
            DisplayEventScreen(),
            Text('data'),
            ActivityScreen(group_id: group_id),
            MoreOptions(group_id),
          ],
        ),
      ),
    );
  }
}
