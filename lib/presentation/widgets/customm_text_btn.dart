import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

class TextBtn extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color? iconColor;
  final Color? textColor;
  final Function()? onTap;
  const TextBtn({
    super.key,
    required this.text,
    required this.icon,
    this.iconColor,
    this.textColor,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onTap ?? () {},
        child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                text,
                style: GoogleFonts.dmSans(
                    color: textColor ?? primaryColor, fontSize: 15),
              ),
              const SizedBox(
                width: 10,
              ),
              Icon(
                icon,
                size: 15,
                color: iconColor ?? primaryColor,
              ),
            ]));
  }
}
