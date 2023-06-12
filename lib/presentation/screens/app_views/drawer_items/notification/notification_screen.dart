import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/models/models.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../config/date_time_formats.dart';
import '../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../widgets/alertify.dart';
import '../../../../widgets/customm_text_btn.dart';
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
        if (state is RegistrationInitial) {
          print('initial');
        }
        if (state is RegistrationLoading) {
          showDialog(
              context: context,
              builder: (builder) =>
                  const Center(child: CircularProgressIndicator()));
        }

        if (state is AttendeeRegistrationLoaded) {
          Alertify.success();
          // Navigator.of(context).pop();
        }
        if (state is RegistrationFailed) {
          Alertify.error(title: 'An Error occured', message: state.error);
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: (Responsive.isMobile(context))
            ? CustomPreferredSizeWidget(
                preferredHeight: 100,
                preferredWidth: double.infinity,
                child: Padding(
                  padding: EdgeInsets.all(kdefaultPadding),
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
              Expanded(
                // It takes 5/6 part of the screen
                flex: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      padding: const EdgeInsets.all(defaultPadding),
                      decoration: const BoxDecoration(
                        color: cardColors,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: buildTable()),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(right: 8.0, bottom: 8.0),
          child: FloatingActionButton.extended(
            backgroundColor: cardColors,
            onPressed: () {
              BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
            },
            label: Text(
              "Refresh Table",
              style: GoogleFonts.dmSans(color: primaryColor, fontSize: 18),
            ),
            icon: const Icon(
              Icons.refresh,
              color: primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Column buildTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Notifications",
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                TextBtn(
                  icon: Icons.filter_list,
                  text: 'Filter',
                )
              ],
            ),
          ],
        ),
        SingleChildScrollView(
          child: BlocConsumer<DashBoardBloc, DashBoardState>(
            listener: (context, state) {
              if (state is DashBoardFetched) {
                for (var element in state.attendeeModel) {
                  log(element.firstName);
                }
              }
            },
            builder: (context, state) {
              if (state is DashBoardFetched) {
                return SizedBox(
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: DataTable(
                      showCheckboxColumn: true,
                      columnSpacing: defaultPadding,
                      // minWidth: 600,
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
                      rows: List.generate(
                        state.notifications.length,
                        (index) => (recentFileDataRow(
                            state.notifications[index], context)),
                      ),
                    ),
                  ),
                );
              } else {
                return const Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}

DataRow recentFileDataRow(Notifier notice, context) {
  return DataRow(
    onLongPress: () {
      // RegistrationForms(context: context).viewSelectedAttendeeData(
      //     title: '${registerdUser.firstName} ${registerdUser.lastName}',
      //     attendee: registerdUser);
    },
    cells: Responsive.isMobile(context)
        ? [
            DataCell(
              Text(
                notice.action,
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
                notice.action,
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
