import 'package:alert_system/alert_overlay_plugin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/presentation/widgets/verify_action_dialogue.dart';
import 'package:url_launcher_plus/url_launcher_plus.dart';
import '../../../config/theme.dart';
import '../../screens/auth_views/login.dart';

Widget landingPageAppBar(bool isLargeScreen, scaffoldKey, context) {
  return Padding(
    padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8.0),
    child: SizedBox(
      height: 50,
      width: double.infinity,
      child: AppBar(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), side: BorderSide.none),
        backgroundColor: kSecondaryColor,
        foregroundColor: bgColor,
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        leading: isLargeScreen
            ? null
            : IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () => scaffoldKey.currentState?.openDrawer(),
              ),
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/app_logo.png',
                height: 150,
                width: 150,
              ),
              if (isLargeScreen) Expanded(child: navBarItems())
            ],
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: LoginPaths(
              context: context,
            ),
          )
        ],
      ),
    ),
  );
}

Widget drawer(scaffoldKey) => Drawer(
      child: ListView(
        children: menuItems
            .map((item) => ListTile(
                  onTap: () {
                    scaffoldKey.currentState?.openEndDrawer();
                  },
                  title: Text(item.keys.toString().split('(')[1].split(')')[1]),
                ))
            .toList(),
      ),
    );

Widget navBarItems() => Row(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: menuItems
          .map(
            (item) => InkWell(
              onTap: () async {
                if (item.values
                    .toString()
                    .split('(')[1]
                    .split(')')[0]
                    .isNotEmpty) {
                  ///TODO: impliment url luncher here
                  await UrlLauncher(
                      launchUrl:
                          item.values.toString().split('(')[1].split(')')[0],
                      backgroundColor: bgColor,
                      blockUrls: ['blockThisSite.com1', 'blockThisSite.com2']);
                }
              },
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
                child: Text(
                  item.keys.toString().split('(')[1].split(')')[0],
                  style: const TextStyle(fontSize: 18),
                ),
              ),
            ),
          )
          .toList(),
    );

final List<Map<String, String>> menuItems = [
  {'About Developer': 'https://ephemeral-vacherin-fb5b17.netlify.app/'},
];

enum Menu { attendeeLogin, adminLogin, nonAdminLogin }

class LoginPaths extends StatefulWidget {
  final BuildContext context;
  const LoginPaths({Key? key, required this.context}) : super(key: key);

  @override
  State<LoginPaths> createState() => _LoginPathsState();
}

class _LoginPathsState extends State<LoginPaths> {
  final hover1 = false;
  final hover2 = false;
  final hover3 = false;

  @override
  Widget build(BuildContext presentContext) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: PopupMenuButton<Menu>(
          splashRadius: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          enableFeedback: false,
          position: PopupMenuPosition.over,
          tooltip: 'Login',
          color: Colors.transparent,
          shadowColor: Colors.transparent,
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: bgColor,
          ),
          surfaceTintColor: primaryColor,
          offset: const Offset(50, 40),
          onSelected: (Menu item) {
            //TODO: implement other logins
            if (item == Menu.attendeeLogin) {
              verifyAction(
                  text: 'Attendee Login Is Not Avalible Now',
                  context: context,
                  title: 'Not Avalible Now',
                  action: () => OverlayManager.dismissOverlay());
            } else if (item == Menu.nonAdminLogin) {
              verifyAction(
                  text: 'Non Admin or Facilitator Login Is Not Avalible Now',
                  context: context,
                  title: 'Not Avalible Now',
                  action: () => OverlayManager.dismissOverlay());
            } else if (item == Menu.adminLogin) {
              Navigator.of(widget.context).pushNamed(SignInScreen.routeName);
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                PopupMenuItem<Menu>(
                  value: Menu.attendeeLogin,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: bgColor),
                    child: Text('Attendee Login',
                        style: GoogleFonts.dmSans(
                            fontSize: 18, color: primaryColor)),
                  ),
                ),
                PopupMenuItem<Menu>(
                    value: Menu.nonAdminLogin,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: bgColor),
                        child: Text('Non Admin Login',
                            style: const TextStyle(
                                fontSize: 18, color: primaryColor)))),
                PopupMenuItem<Menu>(
                    value: Menu.adminLogin,
                    child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            color: bgColor),
                        child: Text('Admin Login',
                            style: const TextStyle(
                                fontSize: 18, color: primaryColor)))),
              ]),
    );
  }
}
