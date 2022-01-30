import 'package:fitness_99/controllers/dashboard_controller.dart';
import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_list_screen.dart';
import 'package:fitness_99/views/more_screen/more_options_screen.dart';
import 'package:fitness_99/views/profile_screen/profile_view.dart';
import 'package:fitness_99/views/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'display_group_screen/display_my_group_screen.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
  final controller = Get.put(DashBoardController());
  late final TabController _tabController;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_tabController.index == 0) {
          showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Exit'),
                content: Text('Do you want to exit'),
                actions: [
                  TextButton(
                    onPressed: SystemNavigator.pop,
                    child: Text(
                      'Yes',
                      style: TextStyles.sgproRegular.f20.black,
                    ),
                  ),
                  TextButton(
                    onPressed: Get.back,
                    child: Text(
                      'No',
                      style: TextStyles.sgproRegular.f20.black,
                    ),
                  ),
                ],
              );
            },
          );
          return true;
        } else {
          setState(() {
            _tabController.animateTo(0);
          });
          return false;
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: TabBarView(
          physics: NeverScrollableScrollPhysics(),
          children: [
            ChatListScreen(),
            SearchScreenView(),
            DisplayMyGroup(),
            ProfileView(),
            MoreOptionsScreen()
          ],
          controller: _tabController,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _tabController.index,
          elevation: 6,
          onTap: (index) {
            setState(() {
              _tabController.animateTo(index);
            });
          },
          fixedColor: Colors.amber[800],
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedLabelStyle: TextStyles.sgproBold.f20.black,
          selectedLabelStyle:
              TextStyles.sgproBold.f20.copyWith(color: Colors.amber[800]),
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/chat_screen/group_icon.svg',
                width: 23,
                height: 23,
                color: Colors.black,
              ),
              label: 'Groups',
              activeIcon: SvgPicture.asset(
                'assets/svgs/chat_screen/group_icon.svg',
                width: 23,
                height: 23,
                color: AppColors.secondaryColor,
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/chat_screen/search-icon.svg',
                width: 23,
                height: 23,
                color: Colors.black,
              ),
              label: 'Search',
              activeIcon: SvgPicture.asset(
                'assets/svgs/chat_screen/search-icon.svg',
                width: 23,
                height: 23,
                color: AppColors.secondaryColor,
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/chat_screen/add.svg',
                width: 23,
                height: 23,
                color: Colors.black,
              ),
              label: 'Create',
              activeIcon: SvgPicture.asset(
                'assets/svgs/chat_screen/add.svg',
                width: 23,
                height: 23,
                color: AppColors.secondaryColor,
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/svgs/chat_screen/man-user.svg',
                width: 23,
                height: 23,
                color: Colors.black,
              ),
              label: 'Profile',
              activeIcon: SvgPicture.asset(
                'assets/svgs/chat_screen/man-user.svg',
                width: 23,
                height: 23,
                color: AppColors.secondaryColor,
              ),
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.more,
                color: Colors.black,
              ),
              label: 'More',
              activeIcon: Icon(
                Icons.more,
                color: Colors.amber[800],
              ),
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
