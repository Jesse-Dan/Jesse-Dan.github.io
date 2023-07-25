// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'hex_method.dart';

const defaultPadding = 16.0;
const double kdefaultPadding = 16;
const double minikdefaultradius = 5;
const double midikdefaultradius = 20;
const double maxikdefaultradius = 50;
const double kDefaultPadding = 20.0;
const double kBigText = 16.0;
const double kSmallText = 12.0;
const double kMidiText = 14.0;
const double kZeroText = 0.0;

const kdefaultwhite = Color(0xfff1f3f6);
const primaryColor = Color(0xFF2697FF);
const cardColors = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

final kSecondaryColor = HexColor('#FFFFFF');
final kTextFieldColor = HexColor('#FAFAFA');
final kdisabledColor = HexColor('#DFDFDF');
final kSemiWineColor = HexColor('#f7efef');
final kFaddedButtonColor = HexColor('#F2E5E6');
final kgreyColor = HexColor('#C4C4C4');
final kgreyText = HexColor('##757575');
final kblackColor = HexColor('#1C1C1C');
const noColor = Colors.transparent;
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);
const kSuccessColor = Color(0xFF27AE60);

lightThemeData(BuildContext context) {
  return ThemeData(
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white, //<-- SEE HERE
          displayColor: Colors.white, //<-- SEE HERE
        ),
    fontFamily: "Aeonik",
    primaryColor: primaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    shadowColor: Theme.of(context).disabledColor,
    dividerColor: const Color(0xff707070),
    canvasColor: Colors.white,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    primaryTextTheme: getTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.light(primary: primaryColor, secondary: kSecondaryColor)
            .copyWith(secondary: Colors.black).copyWith(background: HexColor('#F8F2F2')).copyWith(error: kErrorColor),
  );
}

darkThemeData(BuildContext context) {
  return ThemeData(
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black, //<-- SEE HERE
          displayColor: Colors.black, //<-- SEE HERE
        ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: primaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    fontFamily: "Aeonik",
    shadowColor: Theme.of(context).disabledColor,
    dividerColor: const Color(0xff707070),
    canvasColor: Colors.black,
    primaryTextTheme: getTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.white).copyWith(background: HexColor('#F8F2F2')).copyWith(error: kErrorColor),
  );
}

TextTheme getTextTheme() {
  return const TextTheme(
    bodyText1: TextStyle(fontFamily: "Aeonik"),
    bodyText2: TextStyle(fontFamily: "Aeonik"),
    headline1: TextStyle(fontFamily: "Aeonik"),
    headline2: TextStyle(fontFamily: "Aeonik"),
    headline3: TextStyle(fontFamily: "Aeonik"),
    headline4: TextStyle(fontFamily: "Aeonik"),
    headline5: TextStyle(fontFamily: "Aeonik"),
    headline6: TextStyle(fontFamily: "Aeonik"),
    subtitle1: TextStyle(fontFamily: "Aeonik"),
    subtitle2: TextStyle(fontFamily: "Aeonik"),
    button: TextStyle(
      fontFamily: "Aeonik",
    ),
    caption: TextStyle(fontFamily: "Aeonik"),
    overline: TextStyle(fontFamily: "Aeonik"),
  );
}
