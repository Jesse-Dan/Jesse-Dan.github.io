import 'package:get/get.dart';

import '../presentation/screens/app_views/drawer_items/dashboard_screen.dart';
import '../presentation/screens/app_views/main/main_screen.dart';

List<GetPage> appRoutes = [
  GetPage(
    name: DashboardScreen.routeName,
    page: () => DashboardScreen(),
  ),
  GetPage(
    name: MainScreen.routeName,
    page: () => MainScreen(),
  ),
  GetPage(
    name: MainScreen.routeName,
    page: () => MainScreen(),
  ),
  GetPage(
    name: MainScreen.routeName,
    page: () => MainScreen(),
  )
];
