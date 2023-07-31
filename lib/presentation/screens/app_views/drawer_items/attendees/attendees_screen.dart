import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../config/overlay_config/overlay_service.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../../../logic/bloc/index_blocs.dart';
import '../../../../../logic/bloc/user_management/user_management_bloc.dart';
import '../../../../widgets/alertify.dart';
import '../../../auth_views/login.dart';
import 'forms/pdf_gen.dart';
import 'forms/view_form.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/data_table.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../models/atendee_model.dart';
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
        BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state is AttendeeRegistrationLoaded) {
              OverlayService.closeAlert();
              BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
            }
            if (state is RegistrationLoading) OverlayService.showLoading();
            if (state is RegistrationFailed) OverlayService.closeAlert();
          },
        ),
        BlocListener<UserManagementBloc, UserManagementState>(
          listener: (context, state) {
            if (state is UserManagementLoaded) {
              OverlayService.closeAlert();
              BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
            }
            if (state is UserManagementLoading) OverlayService.showLoading();
            if (state is UserManagementFailed) OverlayService.closeAlert();
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

              BlocBuilder<DashBoardBloc, DashBoardState>(
                  builder: (context, state) {
                bool fetched = state is DashBoardFetched;
                return PageContentWidget(
                  columns: [
                    DataColumn(
                      label: Text(
                        "Fullname",
                        style: GoogleFonts.josefinSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "CamperStatus",
                        style: GoogleFonts.josefinSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                        label: Text(
                          "Code",
                          style: GoogleFonts.josefinSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                        numeric: true),
                    DataColumn(
                      label: Text(
                        "Phone",
                        style: GoogleFonts.josefinSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Disability Cluster",
                        style: GoogleFonts.josefinSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Commitment Fee",
                        style: GoogleFonts.josefinSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Delete Attendee",
                        style: GoogleFonts.josefinSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Edit Attendee Details",
                        style: GoogleFonts.josefinSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Generate Attendee ID",
                        style: GoogleFonts.josefinSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Present Status",
                        style: GoogleFonts.josefinSans(
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
                          attendees: fetched ? state.attendeeModel : [],
                          title: 'Attendee',
                          admin: fetched ? state.user : null,
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
          style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
        ),
      ),
      DataCell(Text(
        registerdUser.wouldCamp.toLowerCase(),
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdUser.id,
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdUser.phoneNo,
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdUser.disabilityCluster,
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdUser.commitmentFee.toLowerCase(),
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
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
          AttendeeViewForms(context: context).viewSelectedAttendeeData(
              title: 'Update Attendee',
              attendee: registerdUser,
              attendeeID: id,
              adminModel: admin);
        },
      )),
      DataCell(IconButton(
        splashRadius: 5,
        icon: Icon(
          Icons.perm_identity_rounded,
          color: kSecondaryColor,
          size: 20,
        ),
        onPressed: () =>
            PdfGenerator(context: context).generatePDF(attendee: registerdUser),
      )),
      DataCell(Container(
          alignment: Alignment.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'absent',
                style: GoogleFonts.josefinSans(
                    color: kSecondaryColor, fontSize: 15),
              ),
              CupertinoSwitch(
                  dragStartBehavior: DragStartBehavior.down,
                  value: registerdUser.present!,
                  onChanged: (val) {
                    switch (registerdUser.present) {
                      case true:
                        BlocProvider.of<UserManagementBloc>(context).add(
                            MarkAttendeeAbsent(false,
                                performedBy: admin, id: registerdUser.id));
                        break;
                      case false:
                        BlocProvider.of<UserManagementBloc>(context).add(
                            MarkAttendeePresent(true,
                                performedBy: admin, id: registerdUser.id));
                        break;
                      default:
                    }
                  }),
              Text(
                'present',
                style: GoogleFonts.josefinSans(
                    color: kSecondaryColor, fontSize: 15),
              )
            ],
          ))),
    ],
  );
}
