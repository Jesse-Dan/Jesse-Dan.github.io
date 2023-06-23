import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

class AlignIconWithTextWidget extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color iconColor;
  final Color textColor;

  const AlignIconWithTextWidget({
    required this.text,
    required this.icon,
    this.iconColor = primaryColor,
    this.textColor = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: GoogleFonts.dmSans(
            color: textColor,
            fontSize: 15,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Icon(
          icon,
          size: 15,
          color: iconColor,
        ),
      ],
    );
  }
}
