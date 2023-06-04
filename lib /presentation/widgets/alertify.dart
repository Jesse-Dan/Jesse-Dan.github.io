import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Alertify {
  final String title;
  final String message;
  final IconData icon;
  final Alignment alignment;

  Alertify.success({
    this.title = "Successful",
    this.message = "Completed successfully",
    this.icon = Icons.check,
    this.alignment = const Alignment(0, -0.99),
  }) {
    botToast(Colors.green);
  }

  Alertify.warning({
    this.title = "Warning",
    this.message = "Please check well",
    this.icon = Icons.info,
    this.alignment = const Alignment(0, -0.99),
  }) {
    botToast(Colors.orangeAccent);
  }

  Alertify.error({
    this.title = "Network Error",
    this.message = "Could not connect to the internet",
    this.icon = Icons.error_outline,
    this.alignment = const Alignment(0, -0.99),
  }) {
    botToast(Colors.red);
  }

  botToast(Color bgColor) {
    return BotToast.showNotification(
      backgroundColor: bgColor,
      leading: (cancel) => SizedBox.fromSize(
        size: const Size(40, 40),
        child: IconButton(
          icon: Icon(icon, color: Colors.white),
          onPressed: cancel,
        ),
      ),
      title: (_) => Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      subtitle: (_) => Text(
        message,
        style: const TextStyle(color: Colors.white),
      ),
      trailing: (cancel) => IconButton(
        icon: const Icon(
          Icons.cancel,
          color: Colors.white,
        ),
        onPressed: cancel,
      ),
      onTap: () {},
      onLongPress: () {},
      enableSlideOff: true,
      align: alignment,
      backButtonBehavior: BackButtonBehavior.none,
      crossPage: true,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 7,
      ),
      onlyOne: false,
      animationDuration: const Duration(milliseconds: 200),
      animationReverseDuration: const Duration(milliseconds: 200),
      duration: const Duration(seconds: 4),
    );
  }
}
