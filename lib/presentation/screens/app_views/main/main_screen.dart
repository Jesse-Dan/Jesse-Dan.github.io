import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../config/theme.dart';
import '../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/constants/responsive.dart';
import '../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../widgets/alertify.dart';
import '../drawer_items/components/header.dart';
import '../drawer_items/components/prefered_size_widget.dart';
import '../drawer_items/dashboard_screen.dart';
import 'components/side_menu.dart';

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
    BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationInitial) {
          print('initial');
        }
        if (state is RegistrationLoading) {
          showDialog(
              context: context,
              builder: (builder) =>
                  const Center(child: CircularProgressIndicator()));
        }

        if (state is GroupRegistrationLoaded) {
          Navigator.of(context).pop();

          Alertify.success();
        }
        if (state is NonAdminRegistrationLoaded) {
          Navigator.of(context).pop();

          Alertify.success();
        }
        if (state is AttendeeRegistrationLoaded) {
          Navigator.of(context).pop();

          Alertify.success();
        }
        if (state is RegistrationFailed) {
          Navigator.of(context).pop();

          Alertify.error(title: 'An Error occured', message: state.error);
        }
      },
      child: Scaffold(
        appBar: (Responsive.isMobile(context))
            ? CustomPreferredSizeWidget(
                preferredHeight: 100,
                preferredWidth: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(kdefaultPadding),
                  child: Header( onPressed: () {
                  }),
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
