import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

class CustomFloatingActionBtn extends StatelessWidget {
  final void Function() onPressed;
  const CustomFloatingActionBtn({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
      child: FloatingActionButton.extended(
        backgroundColor: cardColors,
        onPressed: onPressed,
        label: Text(
          "Refresh",
          style: GoogleFonts.dmSans(color: primaryColor, fontSize: 15),
        ),
        icon: const Icon(
          Icons.refresh,
          color: primaryColor,
          size: 20,
        ),
      ),
    );
  }
}
