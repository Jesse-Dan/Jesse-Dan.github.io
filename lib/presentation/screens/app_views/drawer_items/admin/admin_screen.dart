import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../logic/build/bloc_aler_notifier.dart';
import '../../../../../models/user_model.dart';
import '../../../../widgets/custom_floating_action_btn.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../widgets/alertify.dart';
import '../../../../widgets/customm_text_btn.dart';
import '../dashboard/components/side_menu.dart';
import 'forms/reg_form.dart';

class AdminScreen extends StatefulWidget {
  static const routeName = '/main.admins';

  const AdminScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      floatingActionButton: CustomFloatingActionBtn(
        onPressed: () {
          BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
        },
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
              "Administrative Staffs ",
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                BlocBuilder<DashBoardBloc, DashBoardState>(
                  builder: (context, state) {
                    return TextBtn(
                      icon: Icons.person_add,
                      text: 'Set Admin auth Code',
                      onTap: () {
                        AdminsRegistrationForms(context: context).viewAuthCodeData(
                            title: 'EDIT ADMIN AUTH CODE',
                            admin:
                                state is DashBoardFetched ? state.user : null);
                      },
                    );
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
          child: BlocListener<RegistrationBloc, RegistrationState>(
            listener: (context, state) {
              updateSessionState(state: state, context: context);
              updateLoadingBlocState(state: state, context: context);
              updatetSuccessBlocState(state: state, context: context);
              updateFailedBlocState(state: state, context: context);
            },
            child: BlocBuilder<DashBoardBloc, DashBoardState>(
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
                                  "Profile Picture",
                                  style: GoogleFonts.dmSans(
                                      color: kSecondaryColor, fontSize: 15),
                                ),
                              ),
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
                            ],
                      rows: List.generate(
                        state.admins.length,
                        (index) =>
                            (recentFileDataRow(state.admins[index], context)),
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
        )
      ],
    );
  }
}

DataRow recentFileDataRow(AdminModel registerdAdmin, context) {
  return DataRow(
    onLongPress: () {
      AdminsRegistrationForms(context: context).viewSelectedAdminStaffData(
          title: registerdAdmin.firstName, admin: registerdAdmin);
    },
    cells: Responsive.isMobile(context)
        ? [
            DataCell(
              Text(
                '${registerdAdmin.firstName.toLowerCase()} ${registerdAdmin.lastName.toLowerCase()}',
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
            ),
            DataCell(Text(
              registerdAdmin.dept.toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdAdmin.role.toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
          ]
        : [
            DataCell(registerdAdmin.imageUrl == ''
                ? const Icon(
                    Icons.person,
                    color: primaryColor,
                  )
                : CircleAvatar(
                    backgroundImage:
                        NetworkImage(registerdAdmin.imageUrl, scale: 10))),

            DataCell(
              Text(
                registerdAdmin.firstName.toLowerCase(),
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
            ),
            DataCell(Text(
              registerdAdmin.dept.toLowerCase(),
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdAdmin.role,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdAdmin.phoneNumber,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              registerdAdmin.gender,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            // DataCell(Text(
            //   registerdAdmin.gender.toLowerCase(),
            //   style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            // )),
          ],
  );
}
