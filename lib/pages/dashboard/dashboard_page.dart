import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_app/common/icon/gradientIcon.dart';

import 'package:getx_app/pages/bus/bus_page.dart';
import 'package:getx_app/pages/calendar/calendar_page.dart';
import 'package:getx_app/pages/dailyMenu/dailyMenu_page.dart';
import 'package:getx_app/pages/more/more_page.dart';
import 'package:getx_app/pages/notice/notice_page.dart';

import 'dashboard_controller.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DashboardController>(
      builder: (controller) {
        return Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.cover)),
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SafeArea(
              child: IndexedStack(
                index: controller.tabIndex,
                children: [
                  BusPage(),
                  DailyMenuPage(),
                  NoticePage(),
                  CalendarPage(),
                  MorePage(),
                ],
              ),
            ),
            bottomNavigationBar: _getBtmNavBar(controller),
          ),
        );
      },
    );
  }

  _bottomNavigationBarItem({Widget icon, String label}) {
    return BottomNavigationBarItem(
      icon: Container(
        margin: EdgeInsets.only(right: 3, bottom: 8),
        child: icon,
      ),
      activeIcon: Container(
          margin: EdgeInsets.only(right: 3, bottom: 8),
          // child: Container(
          //   decoration: BoxDecoration(boxShadow: [
          //     BoxShadow(
          //       color: Color(0xFFB4D5F1).withOpacity(0.5),
          //       spreadRadius: 1,
          //       blurRadius: 5,
          //       offset: Offset(0, 3),
          //     )
          //   ]),
          child: Stack(
            children: <Widget>[
              Transform.translate(
                offset: Offset(0, 3),
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaY: 5, sigmaX: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.transparent,
                        width: 0,
                      ),
                    ),
                    child: Opacity(
                      opacity: 0.5,
                      child: ColorFiltered(
                        colorFilter: ColorFilter.mode(
                            Color(0xFFB4D5F1), BlendMode.srcATop),
                        child: icon,
                      ),
                    ),
                  ),
                ),
              ),
              GradientIcon(
                icon,
                LinearGradient(
                    colors: <Color>[
                      Color(0xFF1E7AFF).withOpacity(0.8),
                      Color(0xFF009DF5).withOpacity(0.8),
                    ],
                    begin: const FractionalOffset(0.0, 0.0),
                    end: const FractionalOffset(1.0, 1.0),
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp),
              ),
            ],
          )),
      label: label,
    );
  }

  ClipRRect _getBtmNavBar(controller) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(10),
        topRight: Radius.circular(10),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 10,
          sigmaY: 10,
        ),
        child: BottomNavigationBar(
          unselectedItemColor: Color(0xFF939393),
          selectedItemColor: Color(0xFF1E7AFF),
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          selectedFontSize: 10,
          unselectedFontSize: 10,
          selectedLabelStyle: TextStyle(),
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white.withOpacity(0.8),
          elevation: 0,
          items: [
            _bottomNavigationBarItem(
              icon: ImageIcon(
                  AssetImage('assets/images/bottomNavigationIcon/bus.png'),
                  size: 24),
              label: '버스',
            ),
            _bottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                  'assets/images/bottomNavigationIcon/fork.knife.png')),
              label: '식단',
            ),
            _bottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                  'assets/images/bottomNavigationIcon/megaphone.fill.png')),
              label: '공지사항',
            ),
            _bottomNavigationBarItem(
              icon: ImageIcon(AssetImage(
                  'assets/images/bottomNavigationIcon/calendar.png')),
              label: '학사일정',
            ),
            _bottomNavigationBarItem(
              icon: Icon(
                CupertinoIcons.ellipsis,
                size: 28,
              ),
              label: '더보기',
            ),
          ],
        ),
      ),
    );
  }
}
