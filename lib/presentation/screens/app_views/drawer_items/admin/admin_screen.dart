import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../config/bloc_aler_notifier.dart';
import '../../../../../models/user_model.dart';
import '../../../../widgets/align_text_with_icon_widget.dart';
import '../../../../widgets/custom_floating_action_btn.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../widgets/alertify.dart';
import '../../../../widgets/customm_text_btn.dart';
import '../../../../widgets/data_table.dart';
import '../../components/header.dart';
import '../../components/prefered_size_widget.dart';
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
      appBar: (Responsive.isMobile(context))
          ? CustomPreferredSizeWidget(
              preferredHeight: 100,
              preferredWidth: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(kdefaultPadding),
                child: Header(title: 'Administrative Staffs', onPressed: () {}),
              ))
          : null,
      drawer: const SideMenu(),
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
            flex: 9,
            child: BlocConsumer<DashBoardBloc, DashBoardState>(
              listener: (context, state) {
                updateSessionState(state: state, context: context);
                updateLoadingBlocState(state: state, context: context);
                updatetSuccessBlocState(state: state, context: context);
                updateFailedBlocState(state: state, context: context);
              },
              builder: (context, state) {
                bool fetched = state is DashBoardFetched;
                return PageContentWidget(
                  actions: [AdminsRegistrationForms(context: context)
                            .showOptions(
                                admin: fetched
                                    ? state.user
                                    : null,
                                icon: const AlignIconWithTextWidget(
                                  icon: Icons.admin_panel_settings_rounded,
                                  text: 'Set Auth Codes',
                                
                      
                    )),
                    const TextBtn(
                      icon: Icons.filter_list,
                      text: 'Filter',
                    )
                  ],
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
                  row: List.generate(
                    fetched ? state.admins.length : 0,
                    (index) => (recentFileDataRow(
                        fetched ? state.admins[index] : null, context)),
                  ),
                  title: 'Administrators',
                );
              },
            ),
          ),
        ],
      )),
      floatingActionButton: CustomFloatingActionBtn(
        onPressed: () {
          BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
        },
      ),
    );
  }

  DataRow recentFileDataRow(AdminModel? registerdAdmin, context) {
    return DataRow(
      onLongPress: () {
        AdminsRegistrationForms(context: context).viewSelectedAdminStaffData(
            title: registerdAdmin.firstName, admin: registerdAdmin);
      },
      cells: Responsive.isMobile(context)
          ? [
              DataCell(
                Text(
                  '${registerdAdmin!.firstName.toLowerCase()} ${registerdAdmin.lastName.toLowerCase()}',
                  style:
                      GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
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
              DataCell(registerdAdmin!.imageUrl == ''
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
                  style:
                      GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
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
}
