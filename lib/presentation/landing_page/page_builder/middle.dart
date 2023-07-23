import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';
import 'package:tyldc_finaalisima/config/overlay_config/overlay_service.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_event.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_state.dart';
import 'package:tyldc_finaalisima/models/contact_us_model.dart';
import 'package:tyldc_finaalisima/presentation/landing_page/components/content_builder.dart';
import 'package:tyldc_finaalisima/presentation/widgets/index.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/theme.dart';
import '../../../models/socials_model.dart';

Stack buildMiddle(
  double halfInfinit,
  halfInfinity,
  context,
) {
  return Stack(
    children: [
      Container(
        height: Responsive.isMobileORTablet(context) ? null : 1000,
        width: (halfInfinity * 2),
        color: bgColor,
      ),
      Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: Responsive.isMobileORTablet(context)
                    ? BorderRadius.zero
                    : BorderRadius.only(
                        topRight: Radius.circular(500),
                        bottomRight: Radius.circular(500)),
                color: kSecondaryColor,
              ),
              height: Responsive.isMobileORTablet(context) ? 1500 : 1000,
              width: Responsive.isMobileORTablet(context)
                  ? (halfInfinity * 2)
                  : (halfInfinity * 2) / 1.5,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                top: Responsive.isMobileORTablet(context) ? 0 : 128.0,
                left: 32),
            child: contentWidget(
              addPadding: false,
              context: context,
              titleTextAlign: TextAlign.start,
              content: txt2,
              contentColor: bgColor,
              contentFontSize: 20,
              widgetWidth: 800,
              widgetHeight: Responsive.isMobileORTablet(context) ? 1800 : 800,
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

Widget buildFooter(w, context,
    {required List<TextEditingController> textEditingControllers}) {
  return Container(
    height: Responsive.isMobileORTablet(context) ? 700 : 500,
    width: double.infinity,
    color: bgColor,
    child: Responsive.isMobileORTablet(context)
        ? Column(
            children: [
              buildContactUs(w, context,
                  textEditingControllers: textEditingControllers),
              buildAboutDeveloper(w, context)
            ],
          )
        : Row(
            children: [
              buildContactUs(w, context,
                  textEditingControllers: textEditingControllers),
              Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Container(
                  color: primaryColor.withOpacity(0.5),
                  width: 2,
                  height: 120,
                ),
              ),
              buildAboutDeveloper(w, context)
            ],
          ),
  );
}

Widget buildContactUs(w, context,
    {required List<TextEditingController> textEditingControllers}) {
  var width = w / 2;
  var spacer = Responsive.isMobileORTablet(context) ? 20 : 30;
  Widget sendBtn(
    context,
  ) {
    return InkWell(
      onTap: () {
        if (textEditingControllers[0].text.isEmpty ||
            textEditingControllers[1].text.isEmpty ||
            textEditingControllers[2].text.isEmpty ||
            textEditingControllers[3].text.isEmpty ||
            textEditingControllers[4].text.isEmpty) {
          FormWidget().buildCenterFormField(
              title: 'Message Not Sent',
              context: context,
              widgetsList: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    'Dear, User your message has not been sent.\nCheck if all fields are filled ',
                    style: GoogleFonts.josefinSans(
                        height: 1.5,
                        fontSize: 15,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                )
              ],
              onSubmit: () {
                OverlayService.closeAlert();
              },
              alertType: AlertType.oneBtn,
              onSubmit2: () {});
        } else {
          try {
            BlocProvider.of<ContactUsBloc>(context).add(
                SendContactUsMessageEvent(
                    contactUsModel: ContactUsModel(
                        name: textEditingControllers[0].text,
                        phoneNumber: textEditingControllers[1].text,
                        email: textEditingControllers[2].text,
                        subject: textEditingControllers[3].text,
                        message: textEditingControllers[4].text)));
            FormWidget().buildCenterFormField(
                title: 'Message Delivered',
                context: context,
                widgetsList: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Dear, ${textEditingControllers[0].text} your message has been sent.\nYou would be contacted by a staff ',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.josefinSans(
                          height: 1.5,
                          fontSize: 15,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
                onSubmit: () {
                  OverlayService.closeAlert();
                },
                alertType: AlertType.oneBtn,
                onSubmit2: () {});
            textEditingControllers[0].clear();
            textEditingControllers[1].clear();
            textEditingControllers[2].clear();
            textEditingControllers[3].clear();
            textEditingControllers[4].clear();
          } catch (e) {
            FormWidget().buildCenterFormField(
                title: 'Unkown Error ',
                context: context,
                widgetsList: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Dear, User an unexpexcted error occured with code:\n [UKN002]',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.josefinSans(
                          height: 1.5,
                          fontSize: 15,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                  )
                ],
                onSubmit: () {
                  OverlayService.closeAlert();
                },
                alertType: AlertType.oneBtn,
                onSubmit2: () {});
          }
        }
      },
      child: Container(
        height: 80,
        width: 100,
        decoration: BoxDecoration(
            color: primaryColor, borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.send_rounded,
              color: bgColor,
              size: 30,
            ),
            Text(
              'Send',
              style: GoogleFonts.josefinSans(
                  height: 1.5,
                  fontSize: 15,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w500),
            )
          ],
        )),
      ),
    );
  }

  return StatefulBuilder(builder: (context, state) {
    return Container(
      padding: Responsive.isMobileORTablet(context)
          ? EdgeInsets.all(20)
          : EdgeInsets.all(50),
      child: Column(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width:
                      Responsive.isMobileORTablet(context) ? (w / 1.2) : width,
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingControllers[0],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Full Name',
                      hintStyle: GoogleFonts.josefinSans(
                          height: 1.5,
                          fontSize: 15,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    style: GoogleFonts.josefinSans(
                        height: 1.5,
                        fontSize: 18,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(width: spacer.toDouble()),
                Container(
                  height: 50,
                  width:
                      Responsive.isMobileORTablet(context) ? (w / 1.2) : width,
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingControllers[2],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'E-mail',
                      hintStyle: GoogleFonts.josefinSans(
                          height: 1.5,
                          fontSize: 15,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    style: GoogleFonts.josefinSans(
                        height: 1.5,
                        fontSize: 18,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Responsive.isMobileORTablet(context)
                ? SizedBox(height: 15.toDouble())
                : SizedBox.shrink(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: 50,
                  width:
                      Responsive.isMobileORTablet(context) ? (w / 1.2) : width,
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingControllers[1],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Phone Number',
                      hintStyle: GoogleFonts.josefinSans(
                          height: 1.5,
                          fontSize: 15,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    style: GoogleFonts.josefinSans(
                        height: 1.5,
                        fontSize: 18,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
                SizedBox(width: spacer.toDouble()),
                Container(
                  height: 50,
                  width:
                      Responsive.isMobileORTablet(context) ? (w / 1.2) : width,
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
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextFormField(
                    controller: textEditingControllers[3],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Subject',
                      hintStyle: GoogleFonts.josefinSans(
                          height: 1.5,
                          fontSize: 15,
                          color: kSecondaryColor,
                          fontWeight: FontWeight.w500),
                    ),
                    style: GoogleFonts.josefinSans(
                        height: 1.5,
                        fontSize: 18,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            Responsive.isMobileORTablet(context)
                ? SizedBox(height: 15.toDouble())
                : SizedBox.shrink(),
            Container(
              height: 100,
              width: Responsive.isMobileORTablet(context)
                  ? (w * 1.75)
                  : w + spacer,
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
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: textEditingControllers[4],
                maxLines: 3,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Message',
                    hintStyle: GoogleFonts.josefinSans(
                        height: 1.5,
                        fontSize: 15,
                        color: kSecondaryColor,
                        fontWeight: FontWeight.w500),
                    suffixIcon: sendBtn(
                      context,
                    )),
                style: GoogleFonts.josefinSans(
                    height: 1.5,
                    fontSize: 18,
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w500),
              ),
            )
          ]),
    );
  });
}

Widget buildAboutDeveloper(w, ctx) {
  var width = w / 1.4;
  var spacer = 30;

  return Container(
      // width: width + spacer,
      padding: Responsive.isMobileORTablet(ctx)
          ? EdgeInsets.all(20)
          : EdgeInsets.all(50),
      child: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Social media',
                textAlign: TextAlign.start,
                style: GoogleFonts.josefinSans(
                    height: 1.5,
                    fontSize: 30,
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              BlocBuilder<ContactUsBloc, ContactUsState>(
                bloc: BlocProvider.of<ContactUsBloc>(ctx),
                buildWhen: (previous, current) {
                  return current is SocialsLoadedContactUsState;
                },
                builder: (context, state) {
                  bool fetched = state is SocialsLoadedContactUsState;
                  bool error = state is ErrorContactUsState;
                  bool loading = state is LoadingContactUsState;

                  return error
                      ? Text(
                          'An error Occured',
                          textAlign: TextAlign.end,
                          style: GoogleFonts.josefinSans(
                              fontSize: 10,
                              color: primaryColor,
                              fontWeight: FontWeight.w500),
                        )
                      : loading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: fetched
                                      ? state.socials.socials.length
                                      : 0,
                                  itemBuilder: (_, i) => fetched
                                      ? socialIcon(
                                          socialMedia: state.socials.socials[i],
                                          c: ctx)
                                      : SizedBox.shrink()),
                            );
                },
              ),
              Text(
                Responsive.isMobileORTablet(ctx)
                    ? 'Developer | \nJesse Dan Amuda'
                    : 'Developed by | Jesse Dan Amuda',
                textAlign: TextAlign.end,
                style: GoogleFonts.josefinSans(
                    fontSize: 15,
                    color: primaryColor,
                    fontWeight: FontWeight.w900),
              ),
            ]),
      ));
}

Widget socialIcon({required SocialsUrls socialMedia, c}) {
  return InkWell(
    onTap: () {
      _launchUrl(
        uri: Uri.parse(socialMedia.url),
      );
    },
    child: Padding(
      padding: const EdgeInsets.only(left: 5, right: 5),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 25,
            child: Center(
                child: Icon(getSocialIcon(socialName: socialMedia.socialName))),
            foregroundColor: bgColor,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              socialMedia.socialName,
              style: GoogleFonts.josefinSans(
                  fontSize: 10,
                  color: primaryColor,
                  fontWeight: FontWeight.w900),
            ),
          )
        ],
      ),
    ),
  );
}

Future<void> _launchUrl({required Uri uri, c}) async {
  try {
    if (!await launchUrl(uri,
        webViewConfiguration: WebViewConfiguration(
          enableJavaScript: true,
        ))) {
      throw Exception('Could not launch ${uri}');
    }
  } catch (e) {
    FormWidget().buildCenterFormField(
        title: 'Url Broken',
        context: c,
        widgetsList: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              textAlign: TextAlign.center,
              'Dear, User This link is broken please refresh page, \nor contact costumer service',
              style: GoogleFonts.josefinSans(
                  height: 1.5,
                  fontSize: 15,
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
        onSubmit: () {
          OverlayService.closeAlert();
        },
        alertType: AlertType.oneBtn,
        onSubmit2: () {});
  }
}

IconData getSocialIcon({String? socialName}) {
  switch (socialName) {
    case 'Facebook':
      return (Icons.facebook_rounded);
    case 'WhatsApp':
      return (Icons.wechat_rounded);
    case 'Youtube':
      return (Icons.play_arrow_rounded);
    case 'E-mail':
      return (Icons.mail_rounded);
    case 'Tel:':
      return (Icons.phone_rounded);
    default:
      return (Icons.person_rounded);
  }
}
