import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';

/// [MAKE THE BUTTON LONG OR MAKE IT FILL IT WITH THE SIZE OF ITS CONTENT]
enum ButtonType { long, fill }

class CustomButton extends StatefulWidget {
  final String btnText;
  final void Function()? onTap;
  final Color? color;
  final ButtonType btNtype;
  const CustomButton({
    Key? key,
    required this.btnText,
    required this.onTap,
    this.color,
    this.btNtype = ButtonType.long,
  }) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool horvered = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.btNtype == ButtonType.fill
          ? const EdgeInsets.only(left: 5.0, right: 5.0, bottom: 5, top: 5)
          : const EdgeInsets.only(left: 12.0, right: 12.0, bottom: 5, top: 20),
      child: InkWell(
        onHover: (_) {
          setState(() {
            horvered = _;
          });
        },
        onTap: widget.onTap

        // log('CUSTOM BUTTON TAPPED');
        ,
        child: Container(
          decoration: BoxDecoration(
            boxShadow: horvered
                ? [
                    BoxShadow(
                        color: kSecondaryColor.withOpacity(.6), spreadRadius: 1)
                  ]
                : [],
            borderRadius: BorderRadius.circular(30),
            color: widget.color ?? primaryColor,
          ),
          height: 40,
          width: widget.btNtype == ButtonType.fill
              ? widget.btnText.length * 25
              : double.infinity,
          child: Center(
              child: Text(
            widget.btnText,
            style: GoogleFonts.josefinSans(
              fontWeight: FontWeight.w600,
              color: kSecondaryColor,
              fontSize: 18,
            ),
          )),
        ),
      ),
    );
  }
}
