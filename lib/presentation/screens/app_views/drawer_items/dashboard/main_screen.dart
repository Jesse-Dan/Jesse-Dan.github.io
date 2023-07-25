import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/config/overlay_config/overlay_service.dart';
import 'package:tyldc_finaalisima/logic/bloc/index_blocs.dart';
import '../../../../../logic/bloc/admin_management/admin_managemet_bloc.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../../config/constants/responsive.dart';
import '../../../../../config/theme.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../../widgets/alertify.dart';
import '../../../auth_views/login.dart';
import '../../components/header.dart';
import '../../components/prefered_size_widget.dart';
import 'components/side_menu.dart';
import 'dashboard_screen.dart';

final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

class MainScreen extends StatefulWidget {
  static const routeName = '/main.dashboard';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    _initializeAppAndCalls();
  }

  _initializeAppAndCalls() {
    BlocProvider.of<AuthenticationBloc>(context).add(CheckStatusEvent(context));
    BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AdminManagemetBloc, AdminManagemetState>(
          listener: (context, state) {
            if (state is AdminManagementENABLEDISABLE ||
                state is AdminManagemetLoaded ||
                state is AdminManagemetAltered) {
              OverlayService.closeAlert();
              BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
            }
            if (state is AdminManagementLoading) OverlayService.showLoading();
            if (state is AdminManagemetFailed) OverlayService.closeAlert();
          },
        ),
        BlocListener<GroupManagementBloc, GroupManagementState>(
          listener: (context, state) {
            if (state is GroupManagementLoaded) {
              OverlayService.closeAlert();
              BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
            }
            if (state is GroupManagementLoading) OverlayService.showLoading();
            if (state is GroupManagementFailed) OverlayService.closeAlert();
          },
        ),
        BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is NonAdminRegistrationLoaded ||
                state is GroupRegistrationLoaded ||
                state is AttendeeRegistrationLoaded) {
              OverlayService.closeAlert();
              BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
            }
            if (state is RegistrationLoading) OverlayService.showLoading();
            if (state is RegistrationFailed) OverlayService.closeAlert();
          },
        ),

        BlocListener<DashBoardBloc, DashBoardState>(
          listener: (context, state) {
            if (state is DashBoardFetched) {
              OverlayService.closeAlert();
            }
            if (state is DashBoardLoading) OverlayService.showLoading();
            if (state is DashBoardFailed) OverlayService.closeAlert();

            if (state is DashBoardFetched && !state.user.enabled) {
              Alertify.error(message: 'Your account has been disabled');
              BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
              Navigator.pushNamedAndRemoveUntil(
                  context, SignInScreen.routeName, (_) => false);
            }
          },
        ),

        /// [User management Bloc]
        // BlocListener<UserManagementBloc, UserManagementState>(
        //   listener: (context, state) {
        //     if (state is UserManagementLoaded) {
        //       OverlayService.closeAlert();
        //       BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
        //     }
        //     if (state is UserManagementLoading) OverlayService.showLoading();
        //     if (state is UserManagementFailed) OverlayService.closeAlert();
        //   },
        // ),
      ],
      child: Scaffold(
        appBar: (Responsive.isMobile(context))
            ? CustomPreferredSizeWidget(
                preferredHeight: 100,
                preferredWidth: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(kdefaultPadding),
                  child: Header(onPressed: () {}),
                ))
            : null,
        resizeToAvoidBottomInset: false,
        backgroundColor: bgColor,
        drawer: const SideMenu(),
        body: RefreshIndicator(
          onRefresh: () async {
            BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
          },
          child: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  const Expanded(
                    // default flex = 1
                    // and it takes 1/6 part of the screen
                    child: SideMenu(),
                  ),
                Expanded(
                  // It takes 5/6 part of the screen
                  flex: 5,
                  child: DashboardScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
