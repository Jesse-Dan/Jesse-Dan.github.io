import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_facebook_responsive_ui/screens/screens.dart';
import 'package:get/get.dart';

class MyNavigationService {
  onTapRecogniseGesture(String routeName, {dynamic arguments}) {
    return TapGestureRecognizer()
      ..onTap = () {
        Get.toNamed(routeName, arguments: arguments);
      };
  }

  pop({bool usecontext = false, ctx}) {
    return usecontext ? Navigator.pop(ctx) : Get.back();
  }

  navigateTo(String routeName,
      {dynamic arguments, bool usecontext = false, ctx}) {
    return usecontext
        ? Navigator.pushNamed(ctx, routeName, arguments: arguments)
        : Get.toNamed(routeName, arguments: arguments);
  }

  navigateAndClearRoute(
    String routeName, {
    dynamic arguments,
  }) {
    return Get.offAllNamed(
      routeName,
      arguments: arguments,
    );
  }

  navigateToDashboard({
    dynamic arguments,
    required String baseRouteName,
  }) {
    // String routeName = HomeScreen.routeName;
    // Widget page = HomeScreen();

    // return Get.offAndToNamed(
    //   routeName,
    // );
  }
}
