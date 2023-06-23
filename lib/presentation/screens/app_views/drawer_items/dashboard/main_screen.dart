import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';

import '../../../../../config/constants/responsive.dart';
import '../../../../../config/theme.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../../config/bloc_aler_notifier.dart';
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
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is DashBoardFetched) Navigator.of(context).pop();
        updateSessionState(state: state, context: context);
        // updateLoadingBlocState(state: state, context: context);
        updatetSuccessBlocState(state: state, context: context);
        updateFailedBlocState(state: state, context: context);
      },
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
