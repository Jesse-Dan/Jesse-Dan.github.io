import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/logic/bloc/group_management_bloc/group_management_bloc.dart';
import 'package:tyldc_finaalisima/models/group_model.dart';
import 'package:tyldc_finaalisima/presentation/screens/screens/main/components/side_menu.dart';
import 'package:tyldc_finaalisima/presentation/widgets/forms/forms.dart';

import '../../../../../config/constants/responsive.dart';
import '../../../../../config/theme.dart';
import '../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';

import '../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../widgets/alertify.dart';
import '../../../widgets/customm_text_btn.dart';

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
            if (state is GroupManagementInitial) {
              print('initial');
            }
            if (state is GroupManagementLoading) {
              showDialog(
                  context: context,
                  builder: (builder) =>
                      const Center(child: CircularProgressIndicator()));
            }
            if (state is GroupManagementLoaded) {
              Navigator.of(context).pop();

              Alertify.success();
            }
            if (state is GroupManagementFailed) {
              Alertify.error(title: 'An Error occured', message: 'state.error');
              Navigator.of(context).pop();
            }
          }),
          BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationInitial) {
                if (kDebugMode) {
                  print('initial');
                }
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
                BlocProvider.of<DashBoardBloc>(context)
                    .add(DashBoardDataEvent());
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
        ));
  }

  Column buildTable() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "All Groups",
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextBtn(
                  icon: Icons.people_alt_rounded,
                  text: 'Create Group',
                  onTap: () {
                    RegistrationForms(context: context)
                        .registerGroupForm(title: 'Group');
                  },
                ),
                const TextBtn(
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
                for (var group in state.groupIds) {
                  for (var element in state.userIds) {
                    log('User UID $element | GroupUid $group');
                  }
                }
              }
            },
            builder: (context, state) {
              if (state is DashBoardFetched) {
                return SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      showCheckboxColumn: true,
                      columnSpacing: defaultPadding,
                      // minWidth: 600,
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
                      rows: List.generate(
                        state.groups.length,
                        (index) => (recentFileDataRow(
                            registerdGroup: state.groups[index],
                            context: context,
                            groupsId: state.groupIds[index],
                            atttendees: state.attendeeModel,
                            specificGroupId: state.groupIds[index])),
                      ),
                    ));
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

DataRow recentFileDataRow(
    {required GroupModel registerdGroup,
    context,
    groupsId,
    atttendees,
    specificGroupId}) {
  return DataRow(
    onLongPress: () {
      RegistrationForms(context: context).viewGroupData(
          presenttGroupId: groupsId,
          title: '${registerdGroup.name} Group',
          presentGroupModel: registerdGroup,
          attendees: atttendees);
    },
    cells: Responsive.isMobile(context)
        ? [
            DataCell(
              Text(
                '${registerdGroup.name.toLowerCase()} Group',
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
                registerdGroup.name.toLowerCase(),
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
                RegistrationForms(context: context).verifyAction(
                  text: 'Do you wish to proceed to delete this group?',
                  title: '${registerdGroup.name} Group',
                  action: () {
                    BlocProvider.of<GroupManagementBloc>(context)
                        .add(DeleteGroupEvent(groupId: specificGroupId));
                  },
                );
              },
            )),
          ],
  );
}
