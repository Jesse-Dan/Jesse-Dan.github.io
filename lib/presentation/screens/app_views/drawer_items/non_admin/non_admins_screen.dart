import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../config/overlay_config/overlay_service.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../../../logic/bloc/non_admin_management/non_admin_management_bloc.dart';
import '../../../../widgets/alertify.dart';
import '../../../auth_views/login.dart';
import 'forms/view_forms.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/data_table.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';

import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../../models/non_admin_staff.dart';
import '../../../../widgets/customm_text_btn.dart';
import '../../../../widgets/verify_action_dialogue.dart';
import '../../components/header.dart';
import '../../components/prefered_size_widget.dart';
import '../dashboard/components/side_menu.dart';
import 'forms/reg_forms.dart';

class NonAdminScreen extends StatefulWidget {
  static const routeName = '/main.non.admins';

  const NonAdminScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<NonAdminScreen> createState() => _NonAdminScreenState();
}

class _NonAdminScreenState extends State<NonAdminScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is NonAdminRegistrationLoaded ||
                  state is GroupRegistrationLoaded ||
                  state is AttendeeRegistrationLoaded) {
                OverlayService.closeAlert();
                BlocProvider.of<DashBoardBloc>(context)
                    .add(DashBoardDataEvent());
              }
              if (state is RegistrationLoading) OverlayService.showLoading();
              if (state is RegistrationFailed) {
                Alertify.error(
                    title: 'Registration Error', message: state.error);
                OverlayService.closeAlert();
              }
            },
          ),
          BlocListener<NonAdminManagementBloc, NonAdminManagementState>(
            listener: (context, state) {
              if (state is NonAdminManagementLoaded) {
                OverlayService.closeAlert();
                BlocProvider.of<DashBoardBloc>(context)
                    .add(DashBoardDataEvent());
              }
              if (state is NonAdminManagementLoading)
                OverlayService.showLoading();
              if (state is NonAdminManagementFailed) {
                Alertify.error(
                    title: 'Non Admin Management Error', message: state.error);
                OverlayService.closeAlert();
              }
            },
          ),
          BlocListener<DashBoardBloc, DashBoardState>(
            listener: (context, state) {
              if (state is DashBoardFetched) {
                OverlayService.closeAlert();
              }
              if (state is DashBoardLoading) OverlayService.showLoading();
              if (state is DashBoardFailed) {
                Alertify.error(title: 'DashBooard Error', message: state.error);
                OverlayService.closeAlert();
              }
              if (state is DashBoardFetched && !state.user.enabled) {
                Alertify.error(message: 'Your account has been disabled');
                BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.routeName, (_) => false);
              }
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
                //table
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
                          label: Text("Fullname",
                              style: GoogleFonts.josefinSans(
                                  color: kSecondaryColor, fontSize: 15))),
                      DataColumn(
                          label: Text("Department",
                              style: GoogleFonts.josefinSans(
                                  color: kSecondaryColor, fontSize: 15))),
                      DataColumn(
                          label: Text("Id",
                              style: GoogleFonts.josefinSans(
                                  color: kSecondaryColor, fontSize: 15))),
                      DataColumn(
                          label: Text("Role",
                              style: GoogleFonts.josefinSans(
                                  color: kSecondaryColor, fontSize: 15))),
                      DataColumn(
                          label: Text("Phone",
                              style: GoogleFonts.josefinSans(
                                  color: kSecondaryColor, fontSize: 15))),
                      DataColumn(
                          label: Text("Gender",
                              style: GoogleFonts.josefinSans(
                                  color: kSecondaryColor, fontSize: 15))),
                      DataColumn(
                          label: Text("Created By",
                              style: GoogleFonts.josefinSans(
                                  color: kSecondaryColor, fontSize: 15))),
                      DataColumn(
                          label: Text("Edit",
                              style: GoogleFonts.josefinSans(
                                  color: kSecondaryColor, fontSize: 15))),
                      DataColumn(
                          label: Text("Delete",
                              style: GoogleFonts.josefinSans(
                                  color: kSecondaryColor, fontSize: 15))),
                    ],
                    row: List.generate(
                      fetched ? state.nonAdminModel.length : 0,
                      (index) => (recentFileDataRow(
                          nonAdminId: fetched ? state.nonadminId[index] : null,
                          adminModel: fetched ? state.user : null,
                          fetched ? state.nonAdminModel[index] : null,
                          context)),
                    ),
                    title: 'Non Admins ',
                    actions: [
                      TextBtn(
                        icon: Icons.person_add,
                        text: 'Add Non admin',
                        onTap: () {
                          NonAdminsRegistrationForms(context: context)
                              .registerNonAdminForm(
                                  title: 'Non Admin',
                                  nonAdmin:
                                      fetched ? state.nonAdminModel : null,
                                  admin: fetched ? state.user : null);
                        },
                      ),
                      const TextBtn(
                        icon: Icons.filter_list,
                        text: 'Filter',
                      )
                    ],
                  );
                })
              ],
            ),
          ),
          floatingActionButton: CustomFloatingActionBtn(
            onPressed: () {
              BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
            },
          ),
        ));
  }
}

DataRow recentFileDataRow(NonAdminModel? registerdNonAdmin, context,
    {nonAdminId, adminModel}) {
  return DataRow(
    cells: [
      DataCell(Text(registerdNonAdmin!.firstName!.toLowerCase(),
          style:
              GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15))),
      DataCell(Text(registerdNonAdmin.dept!.toLowerCase(),
          style:
              GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15))),
      DataCell(Text(registerdNonAdmin.id!,
          style:
              GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15))),
      DataCell(Text(registerdNonAdmin.role!,
          style:
              GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15))),
      DataCell(Text(
        registerdNonAdmin.phoneNumber!,
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(registerdNonAdmin.gender!.toLowerCase(),
          style:
              GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15))),
      DataCell(Text(registerdNonAdmin.createdBy!.toLowerCase(),
          style:
              GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15))),
      DataCell(IconButton(
          splashRadius: 5,
          icon: Icon(Icons.edit_document, color: kSecondaryColor, size: 20),
          onPressed: () {
            NonAdminViewForms(context: context).viewSelectedNonAdminStaffData(
                title:
                    '${registerdNonAdmin.firstName} ${registerdNonAdmin.lastName}',
                nonAdmin: registerdNonAdmin);
          })),
      DataCell(IconButton(
          splashRadius: 5,
          icon: Icon(Icons.delete, color: kSecondaryColor, size: 20),
          onPressed: () {
            verifyAction(
                context: context,
                text: 'Do you wish to proceed to delete this Non Admin?',
                title: 'Non Admin ${registerdNonAdmin.firstName} ',
                action: () {
                  BlocProvider.of<NonAdminManagementBloc>(context).add(
                      DeleteNonAdminEvent(
                          nonAdminId: nonAdminId,
                          nonAdminModel: registerdNonAdmin,
                          adminModel: adminModel));
                });
          }))
    ],
  );
}
