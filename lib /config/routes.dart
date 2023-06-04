import 'package:get/get.dart';

import '../presentation/screens/screens/dashboard/dashboard_screen.dart';
import '../presentation/screens/screens/main/main_screen.dart';

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
