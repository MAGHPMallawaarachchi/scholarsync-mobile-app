import 'package:flutter/material.dart';

import '../views/pages/calendar/calendar_page.dart';
import '../views/pages/home/home_page.dart';
import '../views/pages/my_profile/my_profile_page.dart';
import '../views/pages/notifications/notifications_page.dart';

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String? tabItem;

  const TabNavigator({super.key, this.navigatorKey, this.tabItem});

  @override
  Widget build(BuildContext context) {
    Widget child = const HomePage();

    if (tabItem == 'home') {
      child = const HomePage();
    } else if (tabItem == 'calendar') {
      child = const CalendarPage();
    } else if (tabItem == 'add') {
      child = Container();
    } else if (tabItem == 'notifications') {
      child = const NotificationsPage();
    } else if (tabItem == 'my_profile') {
      child = const MyProfilePage();
    }

    // return Container(
    //   child: child,
    // );

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (context) => child);
      },
    );
  }
}