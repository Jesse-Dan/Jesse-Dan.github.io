// ignore_for_file: non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../config/bloc_aler_notifier.dart';
import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/data_table.dart';
import '../../components/header.dart';
import '../../components/prefered_size_widget.dart';
import '../dashboard/components/side_menu.dart';

class SettingsScreen extends StatefulWidget {
  static const routeName = 'main.settings';

  const SettingsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            updateSessionState(state: state, context: context);
            updateLoadingBlocState(state: state, context: context);
            updatetSuccessBlocState(state: state, context: context);
            updateFailedBlocState(state: state, context: context);
          },
        ),
        BlocListener<DashBoardBloc, DashBoardState>(
          listener: (context, state) {
            updateSessionState(state: state, context: context);
            updateLoadingBlocState(state: state, context: context);
            updatetSuccessBlocState(state: state, context: context);
            updateFailedBlocState(state: state, context: context);
          },
        ),
      ],
      child: Scaffold(
        drawer: const SideMenu(),
        appBar: Responsive.isMobile(context)
            ? CustomPreferredSizeWidget(
                preferredHeight: 100,
                preferredWidth: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(kdefaultPadding),
                  child: Header(title: 'Notification', onPressed: () {}),
                ),
              )
            : null,
        backgroundColor: bgColor,
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display side menu only for large screens
              if (Responsive.isDesktop(context))
                const Expanded(
                  child: SideMenu(),
                ),
              BlocConsumer<DashBoardBloc, DashBoardState>(
                listener: (context, state) {},
                builder: (context, state) {
                  bool fetched = state is DashBoardFetched;
                  return PageContentWidget(
                    title: 'Settings',
                    child: Padding(
                      padding: const EdgeInsets.only(top: defaultPadding),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        floatingActionButton: CustomFloatingActionBtn(
          onPressed: () {
            BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
          },
        ),
      ),
    );
  }
}
