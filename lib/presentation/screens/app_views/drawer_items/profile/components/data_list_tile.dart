import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/theme.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String value;
  final void Function()? onTap;

  const CustomListTile({
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: Material(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
            title: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            subtitle: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            trailing: const Icon(
              Icons.arrow_forward_ios,
              size: 16,
            ),
            onTap: onTap),
      ),
    );
  }
}

Widget headerText({required String text, Color? textColor}) {
  return Align(
    alignment: Alignment.centerLeft,
    child: Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontWeight: FontWeight.w600,
          color: textColor ?? kSecondaryColor,
          fontSize: 25,
        ),
        textAlign: TextAlign.start,
      ),
    ),
  );
}

Widget contentText(
    {title, required String text, Color? color, Color? textColor}) {
  return Padding(
    padding: const EdgeInsets.all(3.0),
    child: Align(
        alignment: Alignment.centerLeft,
        child: CustomListTile(
          title: title,
          value: text,
        )),
  );
}
