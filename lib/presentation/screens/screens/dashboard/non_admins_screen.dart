import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/presentation/screens/screens/main/components/side_menu.dart';
import 'package:tyldc_finaalisima/presentation/widgets/forms/forms.dart';

import '../../../../../config/constants/responsive.dart';
import '../../../../../config/theme.dart';
import '../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';

import '../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../models/non_admin_staff.dart';
import '../../../widgets/alertify.dart';
import '../../../widgets/customm_text_btn.dart';

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
              "Non Administrative Staffs ",
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
            ),
          ],
        ),
        SingleChildScrollView(
          child: BlocConsumer<DashBoardBloc, DashBoardState>(
            listener: (context, state) {
              if (state is DashBoardFetched) {
                for (var element in state.nonAdminModel) {
                  log(element.firstName!);
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
                    rows: List.generate(
                      state.nonAdminModel.length,
                      (index) => (recentFileDataRow(
                          state.nonAdminModel[index], context)),
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

DataRow recentFileDataRow(NonAdminModel registerdNonAdmin, context) {
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
                '${registerdNonAdmin.firstName!.toLowerCase()} ${registerdNonAdmin.lastName!.toLowerCase()}',
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
                registerdNonAdmin.firstName!.toLowerCase(),
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
