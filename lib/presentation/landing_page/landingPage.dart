import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';
import 'package:tyldc_finaalisima/config/overlay_config/overlay_service.dart';
import 'package:tyldc_finaalisima/config/theme.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_event.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_state.dart';
import 'package:tyldc_finaalisima/presentation/landing_page/components/content_builder.dart';
import 'package:tyldc_finaalisima/presentation/landing_page/components/extensioion_on_box_decoration.dart';
import 'page_builder/ball.dart';
import 'page_builder/middle.dart';
import 'page_builder/page_builder.dart';

class LandingPage extends StatefulWidget {
  static const routeName = '/home';
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  final name = TextEditingController();
  final phone = TextEditingController();
  final email = TextEditingController();
  final subject = TextEditingController();
  final message = TextEditingController();
  bool _isGlowing = false;

  void _toggleGlowing() {
    setState(() {
      _isGlowing = !_isGlowing;
    });
  }

  @override
  void initState() {
    super.initState();
    _startTimer();
    BlocProvider.of<ContactUsBloc>(context).add(GetContactUsMessageEvent());
    BlocProvider.of<ContactUsBloc>(context).add(GetSocialEvent());
  }

  void _startTimer() {
    Timer.periodic(Duration(milliseconds: 800), (_) {
      _toggleGlowing();
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    var halfInfinity = (MediaQuery.of(context).size.width / 2);
    // var halfHeightInfinity = (MediaQuery.of(context).size.height);

    /// WHOLE PAGE
    return BlocListener<ContactUsBloc, ContactUsState>(
      bloc: BlocProvider.of<ContactUsBloc>(context),
      listener: (context, state) {
        if (state is LoadingContactUsState) {
          OverlayService.show(
              child: Center(
            child: CircularProgressIndicator(),
          ));
        }
        if (state is LoadedContactUsState) {
          OverlayService.closeAlert();
        }
      },
      listenWhen: (previous, current) {
        return current is! LoadingContactUsState;
      },
      child: buildPage(
          context: context,
          scaffoldKey: _scaffoldKey,
          isLargeScreen: Responsive.isDesktop(context),
          widgets: Responsive.isMobileORTablet(context)
              ? [
                  Container(
                      height:
                          Responsive.isMobileORTablet(context) ? (800) : (600),
                      width: (halfInfinity * 2),
                      color: kSecondaryColor,
                      child: Stack(
                        children: [
                          /// TOP
                          BgAnime(),

                          /// GLASS CARD
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 70, left: 5, right: 5),
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: displayMorpCard(_isGlowing)),
                          ),
                        ],
                      )),
                  contentWidget(
                      addPadding: Responsive.isMobileORTablet(context),
                      widgetColor: bgColor,
                      widgetHeight: 1000,
                      title: ['WE\'VE GONE A LONG WAY ', 'EMPOWERING YOUTHS '],
                      content: txt1,
                      context: context),

                  /// MIDDLE SECTION
                  buildMiddle(halfInfinity, halfInfinity, context),

                  /// FOOTER SECTION
                  buildFooter(halfInfinity, context, textEditingControllers: [
                    name,
                    phone,
                    email,
                    subject,
                    message
                  ])
                ]
              : [
                  /// MAIN PAGE
                  Container(
                    height: 1800,
                    child: Stack(
                      children: [
                        /// TOP STACKED WITH MIDDLE
                        Container(
                          height: 1000,
                          width: double.infinity,
                          color: kSecondaryColor,
                          child: Stack(
                            children: [
                              /// TOP
                              BgAnime(),

                              /// TOP CONTENT STACKED ON [TOP]
                              Positioned(
                                top: 150,
                                left: 150,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    /// GLASS CARD
                                    displayMorpCard(_isGlowing),

                                    /// SPACE BETWEEN CONTENTS [CARD AND TEXT]
                                    SizedBox(
                                      width: 100,
                                    ),

                                    /// TEXT CONTENT
                                    contentWidget(
                                        addPadding: true,
                                        title: [
                                          'WE\'VE GONE A LONG WAY ',
                                          'EMPOWERING YOUTHS '
                                        ],
                                        content: txt1,
                                        context: context),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),

                        /// MIDDLE SECTION
                        Positioned(
                            top: 800,
                            child: buildMiddle(
                                halfInfinity, halfInfinity, context)),
                      ],
                    ),
                  ),

                  /// FOOTER SECTION
                  buildFooter(halfInfinity, context, textEditingControllers: [
                    name,
                    phone,
                    email,
                    subject,
                    message
                  ])
                ]),
    );
  }

  Widget displayMorpCard(isGlowing) {
    return Container(
      height: Responsive.isMobile(context) || Responsive.isTablet(context)
          ? 500
          : 600,
      width: 450,
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
      ).glassMorphism(),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: 500),
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: isGlowing
                    ? [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.6),
                          spreadRadius: 8,
                          blurRadius: 16,
                        ),
                      ]
                    : null,
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/icon.png'),
                radius: 90,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(32.0),
              child: Text('TYLDC\n Raising the next Generation',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.russoOne(
                      color: kSecondaryColor, fontSize: 40)),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('3000',
                          style: GoogleFonts.dmSans(
                              color: kgreyColor, fontSize: 30)),
                      Text('youth trained',
                          style: GoogleFonts.josefinSans(color: bgColor)),
                    ],
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Container(
                    color: primaryColor.withOpacity(0.5),
                    width: 2,
                    height: 50,
                  ),
                  SizedBox(
                    width: 45,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('1500',
                          style: GoogleFonts.dmSans(
                              color: kgreyColor, fontSize: 30)),
                      Text('volenteers',
                          style: GoogleFonts.josefinSans(color: bgColor)),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
