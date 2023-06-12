import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

class DataTableWidget extends StatefulWidget {
  final List<DataColumn> columns;
  final List<DataRow> row;
  final String title;
  final List<Widget>? actions;
  const DataTableWidget(
      {super.key,
      required this.columns,
      required this.row,
      required this.title,
      this.actions});

  @override
  State<DataTableWidget> createState() => _DataTableWidgetState();
}

class _DataTableWidgetState extends State<DataTableWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      // It takes 5/6 part of the screen
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(defaultPadding),
          decoration: const BoxDecoration(
            color: cardColors,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: GoogleFonts.dmSans(
                          color: kSecondaryColor, fontSize: 20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: widget.actions ?? [],
                    ),
                  ],
                ),
                DataTable(
                  
                  showCheckboxColumn: true,
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: widget.columns, rows: widget.row,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}