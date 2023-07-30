import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

class CustomTextField extends StatefulWidget {
  final String hint;
  final Widget suffix;
  final TextEditingController? controller;
  final TextInputType fieldsType;
  final int maxLines;
  final bool enabled;
  final bool obscureText;
  final String? initialValue;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function()? onTap;
  final bool readOnly;

  const CustomTextField(
      {Key? key,
      this.onChanged,
      this.onEditingComplete,
      this.enabled = true,
      required this.hint,
      required this.suffix,
      this.controller,
      this.fieldsType = TextInputType.text,
      this.maxLines = 1,
      this.initialValue,
      this.obscureText = false,
      this.onTap,
      this.readOnly = false})
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
          
          obscureText: widget.obscureText,
          onTap: widget.onTap,
          readOnly: widget.readOnly,
          // initialValue: widget.initialValue,
          enabled: widget.enabled,
          keyboardType: widget.fieldsType,
          maxLines: widget.maxLines,
          controller: widget.controller,
          onChanged: widget.onChanged,
          onEditingComplete: widget.onEditingComplete,
          style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.w600, color: kSecondaryColor),
          decoration: InputDecoration(
            
              filled: true,
              fillColor: cardColors,
              hintText: widget.hint,
              hintStyle: GoogleFonts.josefinSans(
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
      ),
    );
  }
}
