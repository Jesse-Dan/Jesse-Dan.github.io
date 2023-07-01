import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/logic/bloc/admin_management/admin_managemet_bloc.dart';
import 'package:tyldc_finaalisima/presentation/widgets/alertify.dart';
import '../../../../../config/bloc_aler_notifier.dart';
import '../../../../../models/user_model.dart';
import '../../../../widgets/align_text_with_icon_widget.dart';
import '../../../../widgets/custom_floating_action_btn.dart';

import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
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
  bool enabled = false;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<DashBoardBloc, DashBoardState>(
          listener: (context, state) {
            updateSessionState(state: state, context: context);
            updateLoadingBlocState(state: state, context: context);
            updatetSuccessBlocState(state: state, context: context);
            updateFailedBlocState(state: state, context: context);
          },
        ),
        BlocListener<AdminManagemetBloc, AdminManagemetState>(
          listener: (context, state) {
            updateSessionState(state: state, context: context);
            updateLoadingBlocState(state: state, context: context);
            updatetSuccessBlocState(state: state, context: context);
            updateFailedBlocState(state: state, context: context);
          },
        ),
      ],
      child: Scaffold(
        appBar: (Responsive.isMobile(context))
            ? CustomPreferredSizeWidget(
                preferredHeight: 100,
                preferredWidth: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(kdefaultPadding),
                  child:
                      Header(title: 'Administrative Staffs', onPressed: () {}),
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
            BlocBuilder<DashBoardBloc, DashBoardState>(
              builder: (context, state) {
                bool fetched = state is DashBoardFetched;
                return PageContentWidget(
                  actions: [
                    AdminsRegistrationForms(context: context).showOptions(
                        admin: fetched ? state.user : null,
                        icon: const AlignIconWithTextWidget(
                          icon: Icons.admin_panel_settings_rounded,
                          text: 'Set Auth Codes',
                        )),
                  ],
                  columns: [
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
                    DataColumn(
                      label: Text(
                        "Edit",
                        style: GoogleFonts.dmSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        "Enabled",
                        style: GoogleFonts.dmSans(
                            color: kSecondaryColor, fontSize: 15),
                      ),
                    ),
                  ],
                  row: List.generate(
                    fetched ? state.admins.length : 0,
                    (index) => (recentFileDataRow(
                        fetched ? state.admins[index] : null, context,
                        performedBy: fetched ? state.user : null)),
                  ),
                  title: 'Admins',
                );
              },
            ),
          ],
        )),
        floatingActionButton: CustomFloatingActionBtn(
          onPressed: () {
            BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
          },
        ),
      ),
    );
  }

  DataRow recentFileDataRow(AdminModel? registerdAdmin, context,
      {required AdminModel? performedBy}) {
    return DataRow(
      onLongPress: () {
        AdminsRegistrationForms(context: context).viewSelectedAdminStaffData(
            title: registerdAdmin.firstName, admin: registerdAdmin);
      },
      cells: [
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
        DataCell(Icon(
          Icons.edit_document,
          size: 30,
          color: kSecondaryColor,
        )),
        DataCell(Container(
            alignment: Alignment.center,
            child: CupertinoSwitch(
                dragStartBehavior: DragStartBehavior.down,
                value: registerdAdmin.enabled,
                onChanged: (val) {
                  if (registerdAdmin != performedBy) {
                    switch (registerdAdmin.enabled) {
                      case true:
                        BlocProvider.of<AdminManagemetBloc>(context).add(
                            DisableAdminEvent(false,
                                performedBy: performedBy!,
                                id: registerdAdmin.id));
                        break;
                      case false:
                        BlocProvider.of<AdminManagemetBloc>(context).add(
                            EnableAdminEvent(true,
                                performedBy: performedBy!,
                                id: registerdAdmin.id));
                        break;
                      default:
                    }
                  } else {
                    Alertify.error(
                        message: 'You can not disable your account');
                  }
                }))),
      ],
    );
  }
}
