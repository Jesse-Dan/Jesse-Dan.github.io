import 'package:alert_system/alert_overlay_plugin.dart';
import 'package:flutter/material.dart';

class OverlayService extends OverlayManager {
  static void Function()? cancelFunc;

  OverlayService.showLoading() {
    OverlayManager.show(
        child: Material(
          color: Colors.transparent,
          child: AlertDialog(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              content: Center(child: const CircularProgressIndicator())),
        ),
        cancelFunc: cancelFunc);
  }

  OverlayService.closeAlert() {
    OverlayManager.dismissOverlay();
  }

  OverlayService.show({Widget? child}) {
    OverlayManager.show(child: child!);
  }
}
