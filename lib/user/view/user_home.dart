import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:eventmanagement/constants/color_constants.dart';
import 'package:eventmanagement/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/common_appbar_user.dart';
import '../../main.dart';

import '../controller/userid_controller.dart';
import 'complaint_view.dart';
import 'new_sub_home.dart';
import 'order_view.dart';
import 'usere_vent_selector_page.dart';
import 'user_view.dart';

class UserHomeView extends StatefulWidget {
  const UserHomeView({
    super.key,
  });

  @override
  State<UserHomeView> createState() => _UserHomeViewState();
}

class _UserHomeViewState extends State<UserHomeView>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController(initialPage: 1);
  List<IconData> items = [
    Icons.person,
    Icons.home_filled,
    Icons.fact_check_outlined,
    Icons.comment_bank_sharp
  ];
  var _bottomNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final controlLer = Provider.of<LoginController>(context);
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    List<Widget> pages = [
       UserCView(),
      const SubHome(),
     const OrderView(),
      const ComplaintView(),
    ];
    final userid = Provider.of<UserIdController>(context,listen: false);
    userid.getSharedValue();
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const CommonAppBarUser(
        title1: 'Event Management',
        clr: true,
      ),
      body: PageView(controller: _pageController, children: pages),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (_) => UsereventSelect()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        height: ht * .07,
        backgroundGradient: LinearGradient(colors: [
          MyColorConst().userAppbargradient2,
          MyColorConst().userAppbargradient1,
          MyColorConst().userAppbargradient3,
          MyColorConst().userAppbargradient2,
        ]),
        activeIndex: _bottomNavIndex,
        onTap: (index) {
          setState(() {
            _bottomNavIndex = index;
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            );
          });
        },
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        leftCornerRadius: 0,
        rightCornerRadius: 0,
        itemCount: items.length,
        tabBuilder: (int index, bool isActive) {
          return Icon(
            items[index],
            size: 24,
            color: MyColorConst.color2,
          );
        },
        scaleFactor: 5,
      ),
    );
  }
}
