import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:scholarsync/views/pages/calendar/calendar_page.dart';
import 'package:scholarsync/views/pages/club_profile/club_profile_page.dart';
import 'package:scholarsync/views/pages/my_profile/my_profile_page.dart';
import 'package:scholarsync/views/pages/notifications/notifications_page.dart';
import '../views/pages/home/home_page.dart';
import '../views/pages/home/kuppi_page.dart';

final GoRouter router = GoRouter(
  debugLogDiagnostics: true,
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: 'kuppi',
          builder: (BuildContext context, GoRouterState state) {
            return const KuppiPage();
          },
        ),
        GoRoute(
          path: 'calendar',
          builder: (BuildContext context, GoRouterState state) {
            return const CalendarPage();
          },
        ),
        GoRoute(
          path: 'notifications',
          builder: (BuildContext context, GoRouterState state) {
            return const NotificationsPage();
          },
        ),
        GoRoute(
          path: 'my-profile',
          builder: (BuildContext context, GoRouterState state) {
            return const MyProfilePage();
          },
        ),
        GoRoute(
          path: 'club-profile',
          builder: (BuildContext context, GoRouterState state) {
            return const ClubProfilePage();
          },
        ),
      ],
    ),
  ],
);
