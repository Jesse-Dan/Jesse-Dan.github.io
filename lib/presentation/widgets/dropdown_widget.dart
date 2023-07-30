import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

class ReusableDropdown<T> extends StatefulWidget {
  final String labelText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final Color? fillColor;
  final Color? inputColors;
  final IconData iconsData;
  final bool isTextField;
  final Widget? suffix;
  final Color? labelcolor;
  final double? labelFontSize;
  final BuildContext? newContext;

  ReusableDropdown(
      {this.isTextField = false,
      this.suffix,
      required this.labelText,
      required this.items,
      required this.value,
      required this.onChanged,
      this.fillColor,
      this.inputColors,
      required this.iconsData,
      this.labelcolor,
      this.labelFontSize,  this.newContext});

  @override
  _ReusableDropdownState<T> createState() => _ReusableDropdownState<T>();
}

class _ReusableDropdownState<T> extends State<ReusableDropdown<T>> {
  @override
  Widget build(BuildContext newContext) {
    return InputDecorator(
      decoration: widget.isTextField
          ? InputDecoration(
              filled: true,
              fillColor: cardColors,
              hintText: widget.labelText,
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
              suffixIcon: widget.suffix)
          : InputDecoration(
              labelText: widget.labelText,
              labelStyle: GoogleFonts.josefinSans(
                color: widget.labelcolor ?? kSecondaryColor,
                fontSize: widget.labelFontSize ?? 15,
              ),

              fillColor: widget.fillColor,
              filled: widget.fillColor == null ? false : true,
              prefixIcon: Icon(
                widget.iconsData,
                color: widget.inputColors ?? Colors.black.withOpacity(.7),
              ),
              // suffixIconConstraints: BoxConstraints.loose(size),

              border: InputBorder.none,
              hintMaxLines: 1,
              hintStyle: TextStyle(
                  fontSize: 14,
                  color: widget.inputColors ?? Colors.black.withOpacity(.5)),
            ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: widget.value,
          items: widget.items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(item.toString()),
            );
          }).toList(),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
