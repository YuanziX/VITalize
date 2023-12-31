import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:vitalize/app/core/routes/go_route_config.dart';
import 'package:vitalize/app/core/utils/hive_user_box_utils.dart';
import 'package:vitalize/app/core/widgets/scaffold_with_appbar.dart';
import 'package:vitalize/app/core/widgets/scaffold_with_navbar.dart';
import 'package:vitalize/app/pages/attendance_page/sub_page/attendance_detail_page.dart';
import 'package:vitalize/data/models/attendance.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

const _root = '/home';

String get initialLocation {
  if (isTrue(firstLaunch)) {
    return loginPageConfig.name;
  } else {
    return homePageConfig.name;
  }
}

final routes = GoRouter(
  initialLocation: '$_root/$initialLocation',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => child,
      routes: [
        GoRoute(
          name: homePageConfig.name,
          path: '$_root/${homePageConfig.name}',
          pageBuilder: (context, state) =>
              NoTransitionPage(child: ScaffoldWithNavbar(page: homePageConfig)),
        ),
        GoRoute(
          name: attendancePageConfig.name,
          path: '$_root/${attendancePageConfig.name}',
          pageBuilder: (context, state) => NoTransitionPage(
              child: ScaffoldWithNavbar(page: attendancePageConfig)),
        ),
        GoRoute(
          name: marksPageConfig.name,
          path: '$_root/${marksPageConfig.name}',
          pageBuilder: (context, state) => NoTransitionPage(
              child: ScaffoldWithNavbar(page: marksPageConfig)),
        ),
        GoRoute(
          name: othersPageConfig.name,
          path: '$_root/${othersPageConfig.name}',
          pageBuilder: (context, state) => NoTransitionPage(
              child: ScaffoldWithNavbar(page: othersPageConfig)),
        ),
      ],
    ),
    GoRoute(
        name: attendanceDetailPageConfig.name,
        path: '$_root/${attendanceDetailPageConfig.name}',
        builder: (context, state) {
          Attendance attendance = state.extra as Attendance;
          return ScaffoldWithAppbar(
            page: attendanceDetailPageConfig,
            title: attendance.name,
            child: AttendanceDetailPage(attendance: attendance),
          );
        }),
    GoRoute(
      name: examSchedulePageConfig.name,
      path: '$_root/${examSchedulePageConfig.name}',
      builder: (context, state) => ScaffoldWithAppbar(
        page: examSchedulePageConfig,
        title: 'Exam Schedule',
      ),
    ),
    GoRoute(
      name: profilePageConfig.name,
      path: '$_root/${profilePageConfig.name}',
      builder: (context, state) => ScaffoldWithAppbar(page: profilePageConfig),
    ),
    GoRoute(
      name: timetablePageConfig.name,
      path: '$_root/${timetablePageConfig.name}',
      builder: (context, state) =>
          ScaffoldWithAppbar(page: timetablePageConfig),
    ),
    GoRoute(
      name: settingsPageConfig.name,
      path: '$_root/${settingsPageConfig.name}',
      builder: (context, state) => ScaffoldWithAppbar(page: settingsPageConfig),
    ),
    GoRoute(
      name: loginPageConfig.name,
      path: '$_root/${loginPageConfig.name}',
      builder: (context, state) => loginPageConfig.child!,
    ),
  ],
);
