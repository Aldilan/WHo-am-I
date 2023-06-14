import 'package:flutter/material.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:get/get.dart';
import 'package:who_am_i/globals/colors.dart';
import 'package:who_am_i/modules/form/form_page.dart';
import 'package:who_am_i/modules/history/history_page.dart';
import 'package:who_am_i/modules/home/home_page.dart';

class IndexPage extends StatefulWidget {
  IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;
  final List<IconData> _icons = [
    Icons.home,
    Icons.history,
  ];
  final List<Widget> _pages = [HomePage(), HistoryPage()];
  late PageController _pageController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PageView(
          controller: _pageController,
          children: _pages,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          splashColor: Colors.white,
          onPressed: () {
            Get.to(FormPage());
          },
          child: Icon(
            Icons.add,
            size: 30,
            weight: 10,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: AnimatedBottomNavigationBar(
          shadow: BoxShadow(
              offset: Offset(0, 1),
              blurRadius: 50,
              spreadRadius: 0.5,
              color: MyColors.shadow),
          activeColor: Colors.purple[800],
          splashColor: Colors.purple,
          notchSmoothness: NotchSmoothness.softEdge,
          icons: _icons,
          gapLocation: GapLocation.center,
          activeIndex: _currentIndex,
          leftCornerRadius: 30,
          rightCornerRadius: 30,
          iconSize: 30,
          height: 70,
          inactiveColor: Colors.grey,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
            _pageController.animateToPage(index,
                duration: Duration(milliseconds: 300), curve: Curves.ease);
          },
        ));
  }
}
