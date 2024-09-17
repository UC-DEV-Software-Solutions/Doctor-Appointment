import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import '../constants/colours.dart';
import '../utils/globals.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController _pageController;

  void navigationTapped(int page) {
    _pageController.jumpToPage(page);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: homeScreenLayouts,
        physics: const NeverScrollableScrollPhysics(), // Prevents manual scrolling
        controller: _pageController,
        onPageChanged: onPageChanged,
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 60,
        backgroundColor: mainWhite,
        color: mainBlue, // Navigation bar background color
        items: [
          Icon(
            Icons.home,
            color: _page == 0 ? bgBlack : mainWhite,
          ),
          Icon(
            Icons.book_online,
            color: _page == 1 ? bgBlack : mainWhite,
          ),
          Icon(
            Icons.medication,
            color: _page == 2 ? bgBlack : mainWhite,
          ),
          Icon(
            Icons.person,
            color: _page == 3 ? bgBlack : mainWhite,
          ),
          // Icon(
          //   Icons.person,
          //   color: _page == 4 ? primaryColor : secondaryColor,
          // ),
        ],
        onTap: navigationTapped, // Switch page on tap
      ),
    );
  }
}
