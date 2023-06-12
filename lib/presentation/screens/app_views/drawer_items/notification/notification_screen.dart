import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../logic/build/bloc_aler_notifier.dart';
import '../../../../../models/models.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../config/date_time_formats.dart';
import '../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../widgets/alertify.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/customm_text_btn.dart';
import '../../../../widgets/data_table.dart';
import '../../components/header.dart';
import '../../components/prefered_size_widget.dart';
import '../dashboard/components/side_menu.dart';

class NotificationScreen extends StatefulWidget {
  static const routeName = '/main.notification';

  const NotificationScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        updateSessionState(state: state, context: context);
        updateLoadingBlocState(state: state, context: context);
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
        backgroundColor: bgColor,
        body: SafeArea(
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
              BlocConsumer<DashBoardBloc, DashBoardState>(
                listener: (context, state) {},
                builder: (context, state) {
                  bool fetched = state is DashBoardFetched;
                  return DataTableWidget(
                      columns: Responsive.isMobile(context)
                          ? [
                              DataColumn(
                                label: FittedBox(
                                  child: Text(
                                    "Activity",
                                    style: GoogleFonts.dmSans(
                                        color: kSecondaryColor, fontSize: 15),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: FittedBox(
                                  child: Text(
                                    "time",
                                    style: GoogleFonts.dmSans(
                                        color: kSecondaryColor, fontSize: 15),
                                  ),
                                ),
                              ),
                              DataColumn(
                                label: FittedBox(
                                  child: Text(
                                    "Description",
                                    style: GoogleFonts.dmSans(
                                        color: kSecondaryColor, fontSize: 15),
                                  ),
                                ),
                              )
                            ]
                          : [
                              DataColumn(
                                label: Text(
                                  "Activity",
                                  style: GoogleFonts.dmSans(
                                      color: kSecondaryColor, fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "time",
                                  style: GoogleFonts.dmSans(
                                      color: kSecondaryColor, fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Description",
                                  style: GoogleFonts.dmSans(
                                      color: kSecondaryColor, fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Performed by | Action",
                                  style: GoogleFonts.dmSans(
                                      color: kSecondaryColor, fontSize: 15),
                                ),
                              ),
                            ],
                      row: List.generate(
                        fetched ? state.notifications.length : 0,
                        (index) => (recentFileDataRow(
                            fetched ? state.notifications[index] : null,
                            context)),
                      ),
                      title: 'Notifications');
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

DataRow recentFileDataRow(Notifier? notice, context) {
  return DataRow(
    onLongPress: () {},
    cells: Responsive.isMobile(context)
        ? [
            DataCell(
              Text(
                notice!.action,
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
            ),
            DataCell(Text(
              dateWithoutTimeButPosition(date: notice.time!).toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              notice.description..toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
          ]
        : [
            DataCell(
              Text(
                notice!.action,
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
            ),
            DataCell(Text(
              dateWithTime.format(notice.time!).toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              notice.description..toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              notice.data,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
          ],
  );
}
