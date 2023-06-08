import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/palette.dart';
import '../../config/theme.dart';

class CustomViewTextField extends StatefulWidget {
  final String hint;
  final Widget suffix;
  // final TextEditingController? controller;
  final TextInputType fieldsType;
  final int maxLines;
  final bool enabled;
  final String? initialValue;
  final bool obscureText;
  final bool readOnly;
  final Function()? onTap;
  const CustomViewTextField(
      {Key? key,
      this.enabled = true,
      required this.hint,
      required this.suffix,
      //  this.controller,
      this.fieldsType = TextInputType.text,
      this.maxLines = 1,
      this.initialValue,
      this.obscureText = false,
      this.readOnly = false,
      this.onTap})
      : super(key: key);
  @override
  State<CustomViewTextField> createState() => _CustomViewTextFieldState();
}

class _CustomViewTextFieldState extends State<CustomViewTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10),
      child: Container(
        decoration: const BoxDecoration(/*[Add Decoration]*/),
        height: 100,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.hint,
              style: GoogleFonts.gochiHand(
                  fontWeight: FontWeight.w600,
                  color: kSecondaryColor,
                  fontSize: 15),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              readOnly: widget.readOnly,
              onTap: widget.onTap,
              initialValue: widget.initialValue,
              enabled: widget.enabled,
              keyboardType: widget.fieldsType,
              maxLines: widget.maxLines,
              obscureText: widget.obscureText,
              // controller: widget.c,
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600, color: kSecondaryColor),
              decoration: InputDecoration(
                  filled: true,
                  fillColor: cardColors,
                  hintText: widget.hint,
                  hintStyle: GoogleFonts.dmSans(
                      fontWeight: FontWeight.w600, color: kSecondaryColor),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      gapPadding: 10,
                      borderSide: const BorderSide(color: Colors.transparent)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    gapPadding: .0,
                    borderSide: const BorderSide(
                      color: Colors.transparent,
                      style: BorderStyle.none,
                    ),
                  ),
                  suffixIcon: widget.suffix),
            ),
          ],
        ),
      ),
    );
  }
}
