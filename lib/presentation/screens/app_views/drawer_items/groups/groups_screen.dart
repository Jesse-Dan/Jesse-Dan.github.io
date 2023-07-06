import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../config/overlay_config/overlay_service.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../../../logic/bloc/group_management_bloc/group_management_bloc.dart';
import '../../../../../models/group_model.dart';
import '../../../../widgets/alertify.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/data_table.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';

import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../widgets/customm_text_btn.dart';
import '../../../../widgets/verify_action_dialogue.dart';
import '../../../auth_views/login.dart';
import '../../components/header.dart';
import '../../components/prefered_size_widget.dart';
import '../dashboard/components/side_menu.dart';
import 'form/group_reg_form.dart';
import 'form/group_view_form.dart';

class GroupsScreen extends StatefulWidget {
  static const routeName = '/main.groups';

  const GroupsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> {
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
              if (state is RegistrationFailed) OverlayService.closeAlert();
            },
          ),
          BlocListener<GroupManagementBloc, GroupManagementState>(
            listener: (context, state) {
              if (state is GroupManagementLoaded) {
                OverlayService.closeAlert();
                BlocProvider.of<DashBoardBloc>(context)
                    .add(DashBoardDataEvent());
              }
              if (state is GroupManagementLoading) OverlayService.showLoading();
              if (state is GroupManagementFailed) OverlayService.closeAlert();
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
        ],
        child: Scaffold(
          backgroundColor: bgColor,
          drawer: SideMenu(),
          appBar: (Responsive.isMobile(context))
              ? CustomPreferredSizeWidget(
                  preferredHeight: 100,
                  preferredWidth: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(kdefaultPadding),
                    child: Header(title: 'Groups', onPressed: () {}),
                  ))
              : null,
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
                BlocBuilder<DashBoardBloc, DashBoardState>(
                    builder: (context, state) {
                  bool fetched = state is DashBoardFetched;
                  return PageContentWidget(
                    searchIndex: 2,
                    columns: [
                      DataColumn(
                        label: Text(
                          "Group Name",
                          style: GoogleFonts.dmSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Group Description",
                          style: GoogleFonts.dmSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Members count",
                          style: GoogleFonts.dmSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Id",
                          style: GoogleFonts.dmSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Created By",
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
                      DataColumn(
                        label: Text(
                          "Delete",
                          style: GoogleFonts.dmSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                    ],
                    row: List.generate(
                      fetched ? state.groups.length : 0,
                      (index) => (recentFileDataRow(
                          registerdGroup: fetched ? state.groups[index] : null,
                          context: context,
                          groupsId: fetched ? state.groupIds[index] : null,
                          atttendees: fetched ? state.attendeeModel : null,
                          admin: fetched ? state.user : null,
                          specificGroupId:
                              fetched ? state.groupIds[index] : null)),
                    ),
                    title: 'All Groups',
                    actions: [
                      TextBtn(
                        icon: Icons.people_alt_rounded,
                        text: 'Create Group',
                        onTap: () {
                          GroupsRegistrationForms(context: context)
                              .registerGroupForm(
                                  title: 'Group',
                                  admin: fetched ? state.user : null,
                                  groups: fetched ? state.groups : null);
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

DataRow recentFileDataRow(
    {required GroupModel? registerdGroup,
    admin,
    context,
    groupsId,
    atttendees,
    specificGroupId}) {
  return DataRow(
    cells: [
      DataCell(
        Text(
          registerdGroup!.name.toLowerCase(),
          style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
        ),
      ),
      DataCell(Text(
        registerdGroup.description.length >= 40
            ? '${registerdGroup.description.substring(0, 5)[0]}...'
            : registerdGroup.description.toLowerCase(),
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdGroup.groupMembers.length.toString(),
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdGroup.id,
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        registerdGroup.createdBy,
        style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(IconButton(
        splashRadius: 5,
        icon: Icon(
          Icons.edit_document,
          color: kSecondaryColor,
          size: 20,
        ),
        onPressed: () {
          GroupsViewForms(context: context).viewGroupData(
              presenttGroupId: groupsId,
              title: '${registerdGroup.name} Group',
              presentGroupModel: registerdGroup,
              attendees: atttendees);
        },
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
            text: 'Do you wish to proceed to delete this group?',
            title: '${registerdGroup.name} Group',
            action: () {
              BlocProvider.of<GroupManagementBloc>(context).add(
                  DeleteGroupEvent(
                      groupId: specificGroupId,
                      groupModel: registerdGroup,
                      adminModel: admin));
            },
          );
        },
      )),
    ],
  );
}
