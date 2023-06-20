import 'package:flutter/material.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';

import '../../../../config/theme.dart';

class AuthViewComponents {
  const AuthViewComponents({required this.context});
  final BuildContext context;

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail, Size size,
      {required TextEditingController controller, TextInputType? type}) {
    return Container(
      margin: const EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: 10,
      ),
      height: Responsive.isDesktop(context) ? size.height / 10 : size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(color: Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType:
            isEmail ? TextInputType.emailAddress : type ?? TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle:
              TextStyle(fontSize: 14, color: Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }

  Widget component2(
      String string, double width, VoidCallback voidCallback, Size size) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: voidCallback,
      child: Container(
        margin:
            const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        height:
            Responsive.isDesktop(context) ? size.height / 10 : size.width / 8,
        width: Responsive.isDesktop(context)
            ? size.width / (width + 4)
            : size.width / width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff4796ff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          string,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
