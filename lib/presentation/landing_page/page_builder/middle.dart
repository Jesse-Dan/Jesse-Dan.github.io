import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/presentation/landing_page/components/content_builder.dart';

import '../../../config/theme.dart';

Stack buildMiddle(double halfInfinit, halfInfinity) {
  return Stack(
    children: [
      Container(
        height: 1000,
        width: (halfInfinity * 2),
        color: bgColor,
      ),
      Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(500),
                    bottomRight: Radius.circular(500)),
                color: kSecondaryColor,
              ),
              height: 1000,
              width: (halfInfinity * 2) / 1.5,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 128.0, left: 32),
            child: contentWidget(
              titleTextAlign: TextAlign.start,
              content: txt2,
              contentColor: bgColor,
              contentFontSize: 20,
              widgetWidth: 800,
              widgetHeight: 800,
              titleContent: RichText(
                  textAlign: TextAlign.start,
                  text: TextSpan(
                      style: GoogleFonts.josefinSans(
                          decoration: TextDecoration.underline,
                          height: 1.5,
                          fontSize: 40,
                          color: bgColor,
                          fontWeight: FontWeight.w700),
                      children: [
                        TextSpan(
                          text: 'AIMS ',
                          style: TextStyle(
                              fontSize: 40,
                              color: primaryColor,
                              fontWeight: FontWeight.w900),
                        ),
                        TextSpan(text: 'AND'),
                        TextSpan(
                          text: ' OBJECTIVES',
                          style: TextStyle(
                              fontSize: 40,
                              color: primaryColor,
                              fontWeight: FontWeight.w900),
                        ),
                        TextSpan(text: ' OF THE CENTER'),
                      ])),
            ),
          )
        ],
      ),
    ],
  );
}

Widget buildFooter(w) {
  return Container(
    height: 450,
    width: double.infinity,
    color: bgColor,
    child: Row(
      children: [
        buildContactUs(w),
        Padding(
          padding: const EdgeInsets.only(top: 80.0),
          child: Container(
            color: primaryColor.withOpacity(0.5),
            width: 2,
            height: 120,
          ),
        ),
        buildAboutDeveloper(w)
      ],
    ),
  );
}

Widget buildContactUs(w) {
  var width = w / 2;
  var spacer = 30;
  return Container(
    padding: EdgeInsets.all(50),
    child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Contact Us',
            style: GoogleFonts.josefinSans(
                decoration: TextDecoration.underline,
                height: 1.5,
                fontSize: 40,
                color: primaryColor,
                fontWeight: FontWeight.w700),
          ),
          Row(
            children: [
              Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primaryColor,
                  gradient: LinearGradient(colors: [primaryColor, bgColor]),
                  boxShadow: [
                    BoxShadow(
                      color: kblackColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: TextFormField(),
              ),
              SizedBox(width: spacer.toDouble()),
              Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primaryColor,
                  gradient: LinearGradient(colors: [primaryColor, bgColor]),
                  boxShadow: [
                    BoxShadow(
                      color: kblackColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primaryColor,
                  gradient: LinearGradient(colors: [primaryColor, bgColor]),
                  boxShadow: [
                    BoxShadow(
                      color: kblackColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
              SizedBox(width: spacer.toDouble()),
              Container(
                height: 50,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: primaryColor,
                  gradient: LinearGradient(colors: [primaryColor, bgColor]),
                  boxShadow: [
                    BoxShadow(
                      color: kblackColor.withOpacity(0.3),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: 50,
            width: w + spacer,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: primaryColor,
              gradient: LinearGradient(colors: [primaryColor, bgColor]),
              boxShadow: [
                BoxShadow(
                  color: kblackColor.withOpacity(0.3),
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
          )
        ]),
  );
}

Widget buildAboutDeveloper(w) {
  var width = w / 1.4;
  var spacer = 30;

  return Container(
      width: width + spacer,
      padding: EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
                // mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Check us out on social media',
                    style: GoogleFonts.josefinSans(
                        height: 1.5,
                        fontSize: 30,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      CircleAvatar(radius: 25),
                      SizedBox(width: 5),
                      CircleAvatar(radius: 25),
                      SizedBox(width: 5),
                      CircleAvatar(radius: 25),
                      SizedBox(width: 5),
                      CircleAvatar(radius: 25),
                      SizedBox(width: 5),
                      CircleAvatar(radius: 25),
                    ],
                  ),
                  Text(
                    'Developed By | Jesse Dan Amuda',
                    textAlign: TextAlign.end,
                    style: GoogleFonts.josefinSans(
                        height: 1.5,
                        fontSize: 25,
                        color: primaryColor,
                        fontWeight: FontWeight.w900),
                  ),
                ]),
          ],
        ),
      ));
}

/// name phone email subject message
