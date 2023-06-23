// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final List<String> options;
  final Function(String)? onChanged;

  const DropdownWidget({Key? key,required this.options, this.onChanged}) : super(key: key);

  @override
  _DropdownWidgetState createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  late String selectedOption;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: selectedOption,
      items: widget.options
          .map((option) => DropdownMenuItem<String>(
                value: option,
                child: Text(option),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedOption = value!;
        });
        widget.onChanged!(value!);
      },
      decoration: const InputDecoration(
        labelText: 'Select an option',
        border: OutlineInputBorder(),
      ),
    );
  }
}

