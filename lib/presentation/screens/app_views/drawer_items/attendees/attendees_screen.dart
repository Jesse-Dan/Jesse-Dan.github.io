import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../logic/bloc/user_management/user_management_bloc.dart';
import 'forms/view_form.dart';
import '../../../../../config/bloc_aler_notifier.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/data_table.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../../../models/atendee_model.dart';
import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../widgets/customm_text_btn.dart';
import '../../../../widgets/verify_action_dialogue.dart';
import '../../components/header.dart';
import '../../components/prefered_size_widget.dart';
import '../dashboard/components/side_menu.dart';
import 'forms/reg_form.dart';

class AttendeesScreen extends StatefulWidget {
  static const routeName = '/main.attendees';

  const AttendeesScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AttendeesScreen> createState() => _AttendeesScreenState();
}

class _AttendeesScreenState extends State<AttendeesScreen> {
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
        BlocListener<UserManagementBloc, UserManagementState>(
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
        drawer: SideMenu(),
        appBar: (Responsive.isMobile(context))
            ? CustomPreferredSizeWidget(
                preferredHeight: 100,
                preferredWidth: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(kdefaultPadding),
                  child: Header(title: 'Attendees', onPressed: () {}),
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
                  listener: (context, state) {
                if (state is DashBoardFetched) {
                  for (var element in state.nonAdminModel) {
                    log(element.firstName!);
                  }
                }
              }, builder: (context, state) {
                bool fetched = state is DashBoardFetched;
                return PageContentWidget(
                  columns: [
                    DataColumn(
                      label: Text(
                        "Fullname",
                        style: GoogleFonts.dmSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "CamperStatus",
                        style: GoogleFonts.dmSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                        label: Text(
                          "Code",
                          style: GoogleFonts.dmSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                        numeric: true),
                    DataColumn(
                      label: Text(
                        "Phone",
                        style: GoogleFonts.dmSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Disability Cluster",
                        style: GoogleFonts.dmSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Commitment Fee",
                        style: GoogleFonts.dmSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Delete Attendee",
                        style: GoogleFonts.dmSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Edit",
                        style: GoogleFonts.dmSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                  ],
                  row: List.generate(
                    fetched ? state.attendeeModel.length : 0,
                    (index) => (recentFileDataRow(
                        fetched ? state.attendeeModel[index] : null, context,
                        admin: fetched ? state.user : null,
                        id: fetched ? state.userIds[index] : '')),
                  ),
                  title: 'Attendees',
                  actions: [
                    TextBtn(
                      icon: Icons.person_add,
                      text: 'Add Attendee',
                      onTap: () {
                        AttendeeRegistrationForms(context: context)
                            .registerNewAttandeeForm(
                          attendees: fetched ? state.attendeeModel : null,
                          title: 'Attendee',
                          admin: fetched ? state.user : null,
                          length: fetched ? state.attendeeModel.length : 0,
                        );
                      },
                    ),
                    const TextBtn(
                      icon: Icons.filter_list,
                      text: 'Filter',
                    )
                  ],
                );
              }),
            ],
          ),
        ),
        floatingActionButton: CustomFloatingActionBtn(
          onPressed: () {
            // AttendeeRegistrationForms(context: context).getNextCode();
            BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
          },
        ),
      ),
    );
  }
}

DataRow recentFileDataRow(AttendeeModel? registerdUser, context, {admin, id}) {
  return DataRow(
    onLongPress: () {
      AttendeeViewForms(context: context).viewSelectedAttendeeData(
         attendeeID: id,
                  adminModel: admin,
          title: '${registerdUser.firstName} ${registerdUser.lastName}',
          attendee: registerdUser);
    },
    cells: [
      DataCell(
        Text(
          registerdUser!.firstName.toLowerCase(),
          style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
        ),
      ),
      DataCell(Text(
        registerdUser.wouldCamp.toLowerCase(),
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdUser.id,
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdUser.phoneNo,
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdUser.disabilityCluster,
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdUser.commitmentFee.toLowerCase(),
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(IconButton(
        splashRadius: 5,
        icon: Icon(
          Icons.delete,
          color: kSecondaryColor,
          size: 20,
        ),
        onPressed: () {
          verifyAction(
            context: context,
            text: 'Do you wish to proceed to delete this Attendee?',
            title:
                'Attendee ${registerdUser.firstName} ${registerdUser.lastName}',
            action: () {
              BlocProvider.of<UserManagementBloc>(context).add(DeleteUserEvent(
                  attendeeID: id,
                  attendeeModel: registerdUser,
                  adminModel: admin));
            },
          );
        },
      )),
      DataCell(IconButton(
        splashRadius: 5,
        icon: Icon(
          Icons.edit,
          color: kSecondaryColor,
          size: 20,
        ),
        onPressed: () {
          AttendeeViewForms(context: context)
              .viewSelectedAttendeeData(title: 'Update Attendee',attendee: registerdUser, attendeeID: id,
                  adminModel: admin);
        },
      )),
    ],
  );
}
