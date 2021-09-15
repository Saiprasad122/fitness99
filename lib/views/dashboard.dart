import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen.dart';
import 'package:fitness_99/views/more_screen/more_options_screen.dart';
import 'package:fitness_99/views/profile_screen/profile_view.dart';
import 'package:fitness_99/views/search_screen/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'display_group_screen/display_group_screen.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key? key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView>
    with SingleTickerProviderStateMixin {
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
    return Scaffold(
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          ChatScreenView(),
          SearchScreenView(),
          DisplayGroupScreen(),
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
              'assets/svgs/chat_screen/user-group.svg',
              width: 23,
              height: 23,
              color: Colors.black,
            ),
            label: 'Groups',
            activeIcon: SvgPicture.asset(
              'assets/svgs/chat_screen/user-group.svg',
              width: 23,
              height: 23,
              color: Colors.amber[700],
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
              color: Colors.amber[700],
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
              color: Colors.amber[700],
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
              color: Colors.amber[700],
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
    );
  }
}
