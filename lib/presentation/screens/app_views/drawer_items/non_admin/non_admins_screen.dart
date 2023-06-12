import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/data_table.dart';
import '../../../../widgets/forms/forms.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';

import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../../models/non_admin_staff.dart';
import '../../../../widgets/alertify.dart';
import '../../../../widgets/customm_text_btn.dart';
import '../dashboard/components/side_menu.dart';

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

          if (state is NonAdminRegistrationLoaded) {
            Alertify.success();
            Navigator.of(context).pop();
          }
          if (state is RegistrationFailed) {
            Alertify.error(title: 'An Error occured', message: state.error);
            Navigator.of(context).pop();
          }
        },
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
                  if (state is DashBoardFetched) {
                    for (var element in state.nonAdminModel) {
                      log(element.firstName!);
                    }
                  }
                }, builder: (context, state) {
                  bool fetched = state is DashBoardFetched;
                  return DataTableWidget(
                    columns: Responsive.isMobile(context)
                        ? [
                            DataColumn(
                              label: Text(
                                "Fullname",
                                style: GoogleFonts.dmSans(
                                    color: kSecondaryColor, fontSize: 15),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Department",
                                style: GoogleFonts.dmSans(
                                    color: kSecondaryColor, fontSize: 15),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Role",
                                style: GoogleFonts.dmSans(
                                    color: kSecondaryColor, fontSize: 15),
                              ),
                            )
                          ]
                        : [
                            DataColumn(
                              label: Text(
                                "Fullname",
                                style: GoogleFonts.dmSans(
                                    color: kSecondaryColor, fontSize: 15),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Department",
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
                                "Role",
                                style: GoogleFonts.dmSans(
                                    color: kSecondaryColor, fontSize: 15),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Phone",
                                style: GoogleFonts.dmSans(
                                    color: kSecondaryColor, fontSize: 15),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                "Gender",
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
                          ],
                    row: List.generate(
                      fetched ? state.nonAdminModel.length : 0,
                      (index) => (recentFileDataRow(
                          fetched ? state.nonAdminModel[index] : null,
                          context)),
                    ),
                    title: 'Non Administrative Staffs ',
                    actions: [
                      TextBtn(
                        icon: Icons.person_add,
                        text: 'Add Non admin',
                        onTap: () {
                          RegistrationForms(context: context)
                              .registerNonAdminForm(title: 'Non Admin');
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

DataRow recentFileDataRow(NonAdminModel? registerdNonAdmin, context) {
  return DataRow(
    onLongPress: () {
      RegistrationForms(context: context).viewSelectedNonAdminStaffData(
          title: '${registerdNonAdmin.firstName} ${registerdNonAdmin.lastName}',
          nonAdmin: registerdNonAdmin);
    },
    cells: Responsive.isMobile(context)
        ? [
            DataCell(
              Text(
                '${registerdNonAdmin!.firstName!.toLowerCase()} ${registerdNonAdmin.lastName!.toLowerCase()}',
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
            ),
            DataCell(Text(
              registerdNonAdmin.dept!.toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdNonAdmin.role!.toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
          ]
        : [
            DataCell(
              Text(
                registerdNonAdmin!.firstName!.toLowerCase(),
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
            ),
            DataCell(Text(
              registerdNonAdmin.dept!.toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdNonAdmin.id!,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdNonAdmin.role!,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdNonAdmin.phoneNumber!,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdNonAdmin.gender!.toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdNonAdmin.createdBy!.toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
          ],
  );
}
