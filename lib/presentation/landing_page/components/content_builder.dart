import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';
import '../../../config/theme.dart';

/// Content Builder
Widget contentWidget(
    {List<String>? title = const ['', ''],
    String? content,
    Color? contentColor,
    Color? mainTitleColor,
    double? contentFontSize,
    double? widgetWidth,
    double? widgetHeight,
    TextAlign? titleTextAlign,
    Widget? titleContent,
    double? topPadding,
    required bool addPadding,
    double? leftPadding,
    double? rightPadding,
    double? buttomPadding,
    required BuildContext context,
    Color? widgetColor,
    bool? addCurve}) {
  return Padding(
    padding: (!addPadding)
        ? EdgeInsets.only(
            top: topPadding ?? 8.0,
            left: leftPadding ?? 8.0,
            bottom: buttomPadding ?? 8.0,
            right: rightPadding ?? 8.0)
        : EdgeInsets.zero,
    child: Container(
      decoration: BoxDecoration(
          color: widgetColor,
          borderRadius:
              Responsive.isMobileORTablet(context) && (addCurve ?? false)
                  ? BorderRadius.only(
                      topLeft: Radius.circular(50),
                      topRight: Radius.circular(50))
                  : BorderRadius.zero),
      padding: (addPadding)
          ? EdgeInsets.only(
              top: topPadding ?? 8.0,
              left: leftPadding ?? 8.0,
              bottom: buttomPadding ?? 8.0,
              right: rightPadding ?? 8.0)
          : EdgeInsets.zero,
      height: widgetHeight ?? 600,
      width: widgetWidth ?? 600,
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// TITLE
              titleContent ??
                  RichText(
                      textAlign: titleTextAlign ?? TextAlign.end,
                      text: TextSpan(
                          style: GoogleFonts.josefinSans(
                              fontSize: 40,
                              color: contentColor ?? kSecondaryColor,
                              fontWeight: FontWeight.w700),
                          children: [
                            TextSpan(text: title?[0]),
                            TextSpan(
                              text: title?[1],
                              style: TextStyle(
                                  fontSize: 40,
                                  color: mainTitleColor ?? primaryColor,
                                  fontWeight: FontWeight.w900),
                            )
                          ])),

              /// SPACE BETWEEN CONTENTS [CARD AND TEXT]
              SizedBox(
                height: 10,
              ),

              /// CONTENT
              Text(
                content!,
                style: GoogleFonts.prompt(
                    fontSize: 14,
                    color: contentColor ?? Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

/// TEXT 1
final txt1 =
    '''Teens and Youths leadership Development Center is envisioned to be a hub for  equipping no excuse, new generation godly leaders, with an excellent mindset, occupying the tops of the mountains of life as positive change agents of culture.

We started in 2014 with a boot camp under the name of Vacation Bible School which was later re- engineered to Change Agents Teens and Youths Camp:  CATY CAMP in 2018.

In 2015 we launched the CATY Voice Magazine, a free annual magazine that captures our activities within the year with the intent to shape the mindset of youths and teens, for a transformed lifestyle, giving hope to the generation next.

Our mission is to start with reaching out to our Jerusalem( the Ijaniki Community), and reach out to all Teens and Youths in the nation, through our various platforms which includes, the free Annual Booth Camp, Daughter's of Greatness Camp(a free 3 day gender based camp purely for the girl-child), Caty Connections( a social media platform that gives opportunity for interactive social expression on both national and Church issues, to the teens and youths leveraging online mentorship),
monthly leadership training and mentoring program, and weekly counseling sessions as the need arises.''';

/// TEXT 2
final String txt2 = '''
1.  To establish a leadership training centre for youths and teens that will be anchored on Kingdom Values.
2. To provide a centre for tutoring, mentoring and supporting the youths to achieve their God-given potentials in leadership and entrepreneurships.
3. To provide a skill acquisition centre for equipping the youths with the right skills needed in leadership roles both in government and in every day business enterprise.
4. To raise youths that will be positive Change Agents in their societies and spheres of influence.
5. To raise a generation of Imaginal thinkers for a better and greater New Nigeria.
6. To build the confidence of the youths to embrace the culture of patriotism as true Nigerians in governance or social relationships whenever and wherever, whether locally or internationally; and to act as change agents to promote the image of Nigeria both locally and internationally. 
7. To raise goal oriented, result driven youths for the New Nigeria of our dream.
8. To provide guidance, counselling and mentorship to the youths for impactful leadership
9. To teach the youths good values that will make them responsible, accountable and committed to good works and integrity
10. To provide skill acquisition and empowerment programmes as foundation for entrepreneurial and business development and establishments
11. To provide a rehabilitation centre that will provide succour to the mentally distressed and abused youths, and a shelter to the homeless youth under training
12. To give voice to the abused and vulnerable youths that lack the capacity to create awareness of discrimination, victimisation and deprivation of societal rights and privileges from them.
13. To provide a recreation centre and facilities for the youths’ outdoor sports, entertainments, physical training and mental development
14. To provide mentorship programmes that will guide the youths to identify their mentors and role models in their career paths.
15. To carry out advocacy to authorities and agencies saddled with the responsibility of developing, promoting, improving and enforcing youths’ rights and welfare in Nigeria
16. To have the capacity to borrow or raise funds for the purpose of achieving these aims.
17. to do all such things as are incidental and ancillary to the attainment of the above objects.''';
