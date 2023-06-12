import 'package:flutter/material.dart';

class CustomPreferredSizeWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final double preferredHeight;
  final double preferredWidth;
  final Widget child;

  CustomPreferredSizeWidget({
    required this.preferredHeight,
    required this.preferredWidth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: preferredHeight,
      width: preferredWidth,
      child: child,
    );
  }

  @override
  Size get preferredSize => Size(preferredWidth, preferredHeight);
}
