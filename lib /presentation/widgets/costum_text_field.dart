import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/palette.dart';
import '../../config/theme.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Widget suffix;
  final TextEditingController controller;
  final TextInputType fieldsType;
  final int maxLines;
  const CustomTextField(
      {Key? key,
      required this.hint,
      required this.suffix,
      required this.controller,
      this.fieldsType = TextInputType.text,
      this.maxLines = 1})
      : super(key: key);
  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10),
      child: Container(
        decoration: const BoxDecoration(/*[Add Decoration]*/),
        height: 50,
        width: double.infinity,
        child: TextFormField(
          keyboardType: widget.fieldsType,
          maxLines: widget.maxLines,
          controller: widget.controller,
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
                    strokeAlign: StrokeAlign.center),
              ),
              suffixIcon: widget.suffix),
        ),
      ),
    );
  }
}
