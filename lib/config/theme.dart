import 'package:flutter/material.dart';

import 'hex_method.dart';

var defaultBackgroundColor = Colors.grey[300];
var appBarColor = Colors.grey[900];
var myAppBar = AppBar(
  automaticallyImplyLeading: true,
  backgroundColor: appBarColor,
  actions: [
    Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.search_rounded,
            color: kSecondaryColor,
          )),
    )
  ],
  title: Text(' '),
  centerTitle: false,
);
const double kdefaultPadding = 16;
const double minikdefaultradius = 5;
const double midikdefaultradius = 20;
const double maxikdefaultradius = 50;
const Color kdefaultYellow = Color.fromARGB(255, 179, 166, 148);
const Color kdefaultBlue = Color.fromARGB(255, 51, 24, 209);
const kdefaultwhite = Color(0xfff1f3f6);

const primaryColor = Color(0xFF2697FF);
const cardColors = Color(0xFF2A2D3E);
const bgColor = Color(0xFF212332);

const defaultPadding = 16.0;

final KPrimaryColor = HexColor('#FFFF00');
final KPinkColor = HexColor('#FFC0CB');
final KBlueColor = HexColor('0000FF');
final KLightBlueHexColor = HexColor('FFADD8E6');
final KLightBlueColor = HexColor('FFADD8E6');

final kSecondaryColor = HexColor('#FFFFFF');
final kTextFieldColor = HexColor('#FAFAFA');
final kdisabledColor = HexColor('#DFDFDF');
final kSemiWineColor = HexColor('#f7efef');
final kFaddedButtonColor = HexColor('#F2E5E6');
final kgreyColor = HexColor('#C4C4C4');
final kgreyText = HexColor('##757575');
final kblackColor = HexColor('#1C1C1C');
final KDividerColor = HexColor('#F9F9F9');
Color noColor = Colors.transparent;
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);

const kDefaultPadding = 20.0;

const kBigText = 16.0;
const kSmallText = 12.0;
const kMidiText = 14.0;
const kZeroText = 0.0;

lightThemeData(BuildContext context) {
  return ThemeData(
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.white, //<-- SEE HERE
          displayColor: Colors.white, //<-- SEE HERE
        ),
    fontFamily: "Aeonik",
    primaryColor: KPrimaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    shadowColor: Theme.of(context).disabledColor,
    dividerColor: const Color(0xff707070),
    canvasColor: Colors.white,
    // backgroundColor: HexColor('#F8F2F2'),
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    // errorColor: kErrorColor,
    // primaryTextTheme: getTextTheme(),
    // accentTextTheme: getTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme:
        ColorScheme.light(primary: KPrimaryColor, secondary: kSecondaryColor)
            .copyWith(secondary: Colors.black),
  );
}

darkThemeData(BuildContext context) {
  return ThemeData(
    textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Colors.black, //<-- SEE HERE
          displayColor: Colors.black, //<-- SEE HERE
        ),
    scaffoldBackgroundColor: Colors.grey.shade900,
    primaryColor: KPrimaryColor,
    indicatorColor: Colors.white,
    splashColor: Colors.white24,
    splashFactory: InkRipple.splashFactory,
    fontFamily: "Aeonik",
    shadowColor: Theme.of(context).disabledColor,
    dividerColor: const Color(0xff707070),
    canvasColor: Colors.black,
    // backgroundColor: HexColor('#F8F2F2'),
    // errorColor: kErrorColor,
    // primaryTextTheme: getTextTheme(),
    // accentTextTheme: getTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    colorScheme: const ColorScheme.dark().copyWith(secondary: Colors.white),
  );
}

// TextTheme getTextTheme() {
//   return const TextTheme(
//     bodyText1: TextStyle(fontFamily: "Aeonik"),
//     bodyText2: TextStyle(fontFamily: "Aeonik"),
//     headline1: TextStyle(fontFamily: "Aeonik"),
//     headline2: TextStyle(fontFamily: "Aeonik"),
//     headline3: TextStyle(fontFamily: "Aeonik"),
//     headline4: TextStyle(fontFamily: "Aeonik"),
//     headline5: TextStyle(fontFamily: "Aeonik"),
//     headline6: TextStyle(fontFamily: "Aeonik"),
//     subtitle1: TextStyle(fontFamily: "Aeonik"),
//     subtitle2: TextStyle(fontFamily: "Aeonik"),
//     button: TextStyle(
//       fontFamily: "Aeonik",
//     ),
//     caption: TextStyle(fontFamily: "Aeonik"),
//     overline: TextStyle(fontFamily: "Aeonik"),
//   );
// }

// const KPrimaryColor = Color(0xffF76C6C);
// const kSecondaryColor = Color(0xFFFE9901);
// const kContentColorLightTheme = Color(0xFF1D1D35);
// const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarningColor = Color(0xFFF3BB1C);
// const kErrorColor = Color(0xFFF03738);
const kDefaultPaddinglogs = 20.0;
const appBarTheme = AppBarTheme(centerTitle: false, elevation: 0);
