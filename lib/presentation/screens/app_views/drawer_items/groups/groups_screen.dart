import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../logic/bloc/group_management_bloc/group_management_bloc.dart';
import '../../../../../logic/build/bloc_aler_notifier.dart';
import '../../../../../models/group_model.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/data_table.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';

import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../widgets/customm_text_btn.dart';
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
          BlocListener<GroupManagementBloc, GroupManagementState>(
              listener: (context, state) {
            updateSessionState(state: state, context: context);
            updateLoadingBlocState(state: state, context: context);
            updatetSuccessBlocState(state: state, context: context);
            updateFailedBlocState(state: state, context: context);
          }),
          BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              updateSessionState(state: state, context: context);
              updateLoadingBlocState(state: state, context: context);
              updatetSuccessBlocState(state: state, context: context);
              updateFailedBlocState(state: state, context: context);
            },
          ),
        ],
        child: Scaffold(
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
                  updateSessionState(state: state, context: context);
                  updateLoadingBlocState(state: state, context: context);
                  updatetSuccessBlocState(state: state, context: context);
                  updateFailedBlocState(state: state, context: context);
                }, builder: (context, state) {
                  bool fetched = state is DashBoardFetched;
                  return DataTableWidget(
                    columns: Responsive.isMobile(context)
                        ? [
                            DataColumn(
                              label: Text(
                                "Group Name",
                                style: GoogleFonts.dmSans(
                                    color: kSecondaryColor, fontSize: 15),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Group description",
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
                            )
                          ]
                        : [
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
                                "Action",
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
                              .registerGroupForm(title: 'Group');
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
    context,
    groupsId,
    atttendees,
    specificGroupId}) {
  return DataRow(
    onLongPress: () {
      GroupsViewForms(context: context).viewGroupData(
          presenttGroupId: groupsId,
          title: '${registerdGroup.name} Group',
          presentGroupModel: registerdGroup,
          attendees: atttendees);
    },
    cells: Responsive.isMobile(context)
        ? [
            DataCell(
              Text(
                '${registerdGroup!.name.toLowerCase()} Group',
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
            ),
            DataCell(Text(
              registerdGroup.description.toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdGroup.groupMembers.length.toString().toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
          ]
        : [
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
              groupsId,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdGroup.createdBy,
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
                GroupsViewForms(context: context).verifyAction(
                  text: 'Do you wish to proceed to delete this group?',
                  title: '${registerdGroup.name} Group',
                  action: () {
                    BlocProvider.of<GroupManagementBloc>(context)
                        .add(DeleteGroupEvent(groupId: specificGroupId, groupModel:registerdGroup));
                  },
                );
              },
            )),
          ],
  );
}
