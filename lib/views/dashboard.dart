import 'package:fitness_99/global/utils/fontsAndSizes.dart';
import 'package:fitness_99/views/chat_screen/chat_screen.dart';
import 'package:fitness_99/views/more_screen/more_options_screen.dart';
import 'package:fitness_99/views/profile_screen/profile_view.dart';
import 'package:flutter/material.dart';

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
        children: const [
          ChatScreenView(),
          ChatScreenView(),
          ChatScreenView(),
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
        unselectedLabelStyle: TextStyles.sgproBold.f16.black,
        selectedLabelStyle:
            TextStyles.sgproBold.f16.copyWith(color: Colors.amber[800]),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.groups,
              color: Colors.black,
            ),
            label: 'Groups',
            activeIcon: Icon(
              Icons.groups,
              color: Colors.amber[800],
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: Colors.black,
            ),
            label: 'Search',
            activeIcon: Icon(
              Icons.search,
              color: Colors.amber[800],
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add,
              color: Colors.black,
            ),
            label: 'Create',
            activeIcon: Icon(
              Icons.add,
              color: Colors.amber[800],
            ),
            backgroundColor: Colors.white,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: Colors.black,
            ),
            label: 'Profile',
            activeIcon: Icon(
              Icons.person_outline,
              color: Colors.amber[800],
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
