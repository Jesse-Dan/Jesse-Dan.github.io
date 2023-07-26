import 'package:flutter/material.dart';

class ReusableDropdown<T> extends StatefulWidget {
  final String labelText;
  final List<T> items;
  final T? value;
  final ValueChanged<T?> onChanged;
  final Color? fillColor;
  final Color? inputColors;
  final IconData iconsData;

  ReusableDropdown({
    required this.labelText,
    required this.items,
    required this.value,
    required this.onChanged, this.fillColor, this.inputColors, required this.iconsData,
  });

  @override
  _ReusableDropdownState<T> createState() => _ReusableDropdownState<T>();
}

class _ReusableDropdownState<T> extends State<ReusableDropdown<T>> {
  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: InputDecoration(
        labelText: widget.labelText,

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
            fontSize: 14, color: widget.inputColors ?? Colors.black.withOpacity(.5)),
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
