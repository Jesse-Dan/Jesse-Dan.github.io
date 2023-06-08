import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tyldc_finaalisima/presentation/screens/screens/dashboard/groups_screen.dart';

import '../../../../../config/theme.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_state.dart';
import '../../../../widgets/alertify.dart';
import '../../../auth/login.dart';
import '../../dashboard/admin_screen.dart';
import '../../dashboard/attendees_screen.dart';
import '../../dashboard/non_admins_screen.dart';
import '../../dashboard/notification_screen.dart';
import '../main_screen.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Navigator.pushReplacementNamed(context, MainScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Season",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Attendees",
            svgSrc: "assets/icons/menu_tran.svg",
            press: () {
              Navigator.pushReplacementNamed(
                  context, AttendeesScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Groups",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushReplacementNamed(context, GroupsScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Administative Staffs",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushReplacementNamed(context, AdminScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Non-Administative Staffs",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushReplacementNamed(context, NonAdminScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Statistics",
            svgSrc: "assets/icons/menu_store.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Notification",
            svgSrc: "assets/icons/menu_notification.svg",
            press: () {
              Navigator.pushReplacementNamed(
                  context, NotificationScreen.routeName);
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            ///[ABILITY TO CHANGE ADMIN CODE]
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
          BlocListener<AuthenticationBloc, AuthentictionState>(
            listener: (context, state) {
              if (state is AuthentictionLoading) {
                showDialog(
                    context: context,
                    builder: ((context) =>
                        Center(child: CircularProgressIndicator())));
              }
              if (state is AuthentictionSuccesful) {
                Alertify.success(
                    title: 'Ending Session Success',
                    message: 'Session Ended sussecfully');
                Navigator.pushReplacementNamed(context, SignInScreen.routeName);
              }
              if (state is AuthentictionFailed) {
                Navigator.pop(context);
                Alertify.error(
                    title: 'Ending Session Error', message: state.error);
              }
            },
            child: DrawerListTile(
              title: "End Session",
              svgSrc: "assets/icons/menu_profile.svg",
              press: () {
                showDialog(
                    context: context,
                    builder: (builder) => AlertDialog(
                          backgroundColor: bgColor,
                          title: Text(
                            'End Session',
                            style:
                                TextStyle(color: kSecondaryColor, fontSize: 15),
                          ),
                          content: Text(
                            'Are you sure you want to End this Session?',
                            style:
                                TextStyle(color: kSecondaryColor, fontSize: 25),
                          ),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Cancel',
                                  style: TextStyle(color: kSecondaryColor),
                                )),
                            TextButton(
                                onPressed: () {
                                  BlocProvider.of<AuthenticationBloc>(context)
                                      .add(LogoutEvent());
                                },
                                child: const Text(
                                  'Proceed',
                                  style: TextStyle(color: Colors.red),
                                ))
                          ],
                        ));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        color: kSecondaryColor,
        // colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: kSecondaryColor),
      ),
    );
  }
}
