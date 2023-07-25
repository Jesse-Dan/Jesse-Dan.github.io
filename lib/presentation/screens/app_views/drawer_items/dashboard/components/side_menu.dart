import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tyldc_finaalisima/presentation/screens/app_views/drawer_items/contact_us/contact_us_data.dart';
import 'package:tyldc_finaalisima/presentation/screens/app_views/drawer_items/settings/setting_screen.dart';
import '../../../../../../logic/bloc/index_blocs.dart';
import '../../../../../../logic/local_storage_service.dart/local_storage.dart';
import '../../profile/profile_screen.dart';
import '../../recently_deleted/recenttly_deleted_screen.dart';
import '../../../../../widgets/verify_action_dialogue.dart';

import '../../../../../../config/app_autorizations.dart';
import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/bloc_controller.dart';
import '../../groups/groups_screen.dart';

import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../../../logic/bloc/auth_bloc/authentiction_event.dart';

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
    return BlocBuilder<DashBoardBloc, DashBoardState>(
      builder: (context, state) {
        bool fetched = state is DashBoardFetched;
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
                decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.9),
                    image: DecorationImage(
                        fit: BoxFit.contain,
                        image: AssetImage('assets/images/app_logo.png'))),
                child: SizedBox.shrink(),
              ),
              DrawerListTile(
                title: "Dashboard",
                svgSrc: "assets/icons/menu_dashboard.svg",
                press: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, MainScreen.routeName, (_) => false);
                },
              ),
              fetched
                  ? AppAuthorizations(
                          localStorageService: LocalStorageService())
                      .displayForSuperAdmin(
                          adminCode: state.user.authCode,
                          child: DrawerListTile(
                            title: "Season",
                            svgSrc: "assets/icons/menu_tran.svg",
                            press: () {},
                          ))
                  : const SizedBox.shrink(),
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
              fetched
                  ? AppAuthorizations(
                          localStorageService: LocalStorageService())
                      .displayForSuperAdmin(
                          adminCode: state.user.authCode,
                          child: DrawerListTile(
                            title: "Administative Staffs",
                            svgSrc: "assets/icons/menu_task.svg",
                            press: () {
                              Navigator.pushNamedAndRemoveUntil(
                                  context, AdminScreen.routeName, (_) => false);
                            },
                          ))
                  : const SizedBox.shrink(),
              fetched
                  ? AppAuthorizations(
                          localStorageService: LocalStorageService())
                      .displayForSuperAdmin(
                          adminCode: state.user.authCode,
                          child: DrawerListTile(
                            title: "Non-Administative Staffs",
                            svgSrc: "assets/icons/menu_task.svg",
                            press: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  NonAdminScreen.routeName, (_) => false);
                            },
                          ))
                  : const SizedBox.shrink(),
              fetched
                  ? AppAuthorizations(
                          localStorageService: LocalStorageService())
                      .displayForSuperAdmin(
                          adminCode: state.user.authCode,
                          child: DrawerListTile(
                            title: "Statistics",
                            svgSrc: "assets/icons/menu_store.svg",
                            press: () {},
                          ))
                  : const SizedBox.shrink(),
              fetched
                  ? AppAuthorizations(
                          localStorageService: LocalStorageService())
                      .displayForSuperAdmin(
                          adminCode: state.user.authCode,
                          child: DrawerListTile(
                            title: "Notification",
                            svgSrc: "assets/icons/menu_notification.svg",
                            press: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  NotificationScreen.routeName, (_) => false);
                            },
                          ))
                  : const SizedBox.shrink(),
              fetched
                  ? AppAuthorizations(
                          localStorageService: LocalStorageService())
                      .displayForSuperAdmin(
                          adminCode: state.user.authCode,
                          child: DrawerListTile(
                            title: "Recently Deleted",
                            svgSrc: "assets/icons/menu_tran.svg",
                            press: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  RecentlyDeleted.routeName, (_) => false);
                            },
                          ))
                  : const SizedBox.shrink(),
              DrawerListTile(
                title: "Profile",
                svgSrc: "assets/icons/menu_profile.svg",
                press: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, ProfileScreen.routeName, (_) => false);
                },
              ),
              fetched
                  ? AppAuthorizations(
                          localStorageService: LocalStorageService())
                      .displayForSuperAdmin(
                          adminCode: state.user.authCode,
                          child: DrawerListTile(
                            title: "Contact Messages",
                            svgSrc: "assets/icons/menu_tran.svg",
                            press: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  ContactUsScreen.routeName, (_) => false);
                            },
                          ))
                  : const SizedBox.shrink(),
              fetched
                  ? AppAuthorizations(
                          localStorageService: LocalStorageService())
                      .displayForSuperAdmin(
                          adminCode: state.user.authCode,
                          child: DrawerListTile(
                            title: "Settings",
                            svgSrc: "assets/icons/menu_setting.svg",
                            press: () {
                              Navigator.pushNamedAndRemoveUntil(context,
                                  SettingsScreen.routeName, (_) => false);
                            },
                          ))
                  : const SizedBox.shrink(),
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
                    verifyAction(
                        title: 'End Session',
                        text: 'Are you sure you want to End this Session?',
                        action: () {
                          BlocProvider.of<AuthenticationBloc>(context)
                              .add(LogoutEvent());
                        },
                        context: context);
                  },
                ),
              ),
            ],
          ),
        );
      },
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
