import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../logic/build/bloc_aler_notifier.dart';
import '../../groups/groups_screen.dart';

import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../../../logic/bloc/auth_bloc/authentiction_event.dart';

import '../../../../../../logic/bloc/auth_bloc/authentiction_state.dart';
import '../../../../../widgets/alertify.dart';
import '../../../../auth_views/login.dart';

import '../../admin/admin_screen.dart';
import '../../attendees/attendees_screen.dart';
import '../../non_admin/non_admins_screen.dart';

import '../../notification/notification_screen.dart';
import '../main_screen.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: bgColor,
      child: ListView(
        children: [
          if (Responsive.isMobile(context) || Responsive.isTablet(context))
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: IconButton(
                  focusColor: Colors.transparent,
                  color: Colors.transparent,
                  highlightColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  icon: const Icon(
                    Icons.close,
                    size: 30,
                    color: primaryColor,
                  ),
                  onPressed: () async {
                    Scaffold.of(context).closeDrawer();
                    // Navigator.of(context).pop();
                  },
                ),
              ),
            ),
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            svgSrc: "assets/icons/menu_dashboard.svg",
            press: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.routeName, (_) => false);
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
              Navigator.pushNamedAndRemoveUntil(
                  context, AttendeesScreen.routeName, (_) => false);
            },
          ),
          DrawerListTile(
            title: "Groups",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, GroupsScreen.routeName, (_) => false);
            },
          ),
          DrawerListTile(
            title: "Administative Staffs",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, AdminScreen.routeName, (_) => false);
            },
          ),
          DrawerListTile(
            title: "Non-Administative Staffs",
            svgSrc: "assets/icons/menu_task.svg",
            press: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, NonAdminScreen.routeName, (_) => false);
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
              Navigator.pushNamedAndRemoveUntil(
                  context, NotificationScreen.routeName, (_) => false);
            },
          ),
          DrawerListTile(
            title: "Profile",
            svgSrc: "assets/icons/menu_profile.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            svgSrc: "assets/icons/menu_setting.svg",
            press: () {},
          ),
          BlocListener<AuthenticationBloc, AuthentictionState>(
            listener: (context, state) {
              updateSessionState(state: state, context: context);
              updateLoadingBlocState(state: state, context: context);
              updateFailedBlocState(state: state, context: context);
              if (state is AuthentictionSuccesful) {
                Alertify.success(
                    title: 'Ending Session Success',
                    message: 'Session Ended sussecfully');
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.routeName, (_) => false);
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