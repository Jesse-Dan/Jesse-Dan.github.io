import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../drawer_items/groups/form/group_reg_form.dart';
import '../../../../config/constants/responsive.dart';
import '../../../../config/palette.dart';
import '../../../../config/theme.dart';
import '../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../models/stats_card.dart';
import '../drawer_items/attendees/forms/reg_form.dart';
import '../drawer_items/non_admin/forms/reg_forms.dart';
import 'dashboard_info_card.dart';

double calculatePercentage(double value) {
  return (value / 100) * 100;
}

class MyFiles extends StatefulWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<MyFiles> createState() => _MyFilesState();
}

class _MyFilesState extends State<MyFiles> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Quick Stats",
              style:
                  GoogleFonts.josefinSans(fontSize: 20, color: Palette.white),
            ),
            BlocBuilder<DashBoardBloc, DashBoardState>(
              builder: (context, state) {
                bool fetched = state is DashBoardFetched;
                return ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding /
                          (Responsive.isMobile(context) ? 2 : 1),
                    ),
                  ),
                  onPressed: () {
                    AttendeeRegistrationForms(context: context)
                        .registerNewAttandeeForm(
                      title: 'Attendee',
                      attendees: fetched ? state.attendeeModel : null,
                      admin: fetched ? state.user : null,
                      length: fetched ? state.attendeeModel.length : 0,
                    );
                  },
                  icon: const Icon(Icons.person_add_rounded),
                  label: const Text("Register New"),
                );
              },
            ),
          ],
        ),
        const SizedBox(height: defaultPadding),
        Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 ? 1.3 : 1,
          ),
          tablet: const FileInfoCardGridView(),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
        ),
      ],
    );
  }
}

class FileInfoCardGridView extends StatefulWidget {
  const FileInfoCardGridView({
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;

  @override
  State<FileInfoCardGridView> createState() => _FileInfoCardGridViewState();
}

class _FileInfoCardGridViewState extends State<FileInfoCardGridView> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardBloc, DashBoardState>(
        builder: (context, state) {
      bool fetched = state is DashBoardFetched;
      return GridView(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: widget.crossAxisCount,
          crossAxisSpacing: defaultPadding,
          mainAxisSpacing: defaultPadding,
          childAspectRatio: widget.childAspectRatio,
        ),
        children: [
          state is DashBoardFetched && state.attendeeModel.isNotEmpty
              ? FileInfoCard(
                  info: StatisticsCard(
                      title: "Attendee",
                      amount: state.attendeeModel.length,
                      img: "assets/icons/Documents.svg",
                      capacity: "",
                      color: primaryColor,
                      percentage: calculatePercentage(
                          state.attendeeModel.length.toDouble()),
                      onTap: () {
                        AttendeeRegistrationForms(context: context)
                            .registerNewAttandeeForm(
                          title: 'Attendee',
                          attendees: fetched ? state.attendeeModel : null,
                          admin: fetched ? state.user : null,
                          length: fetched ? state.attendeeModel.length : 0,
                        );
                      }))
              : emptyState(),
          state is DashBoardFetched && state.nonAdminModel.isNotEmpty
              ? FileInfoCard(
                  info: StatisticsCard(
                      title: "Non-Admin Staffs",
                      amount: state.nonAdminModel.length,
                      img: "assets/icons/google_drive.svg",
                      capacity: "",
                      color: const Color(0xFFFFA113),
                      percentage: calculatePercentage(
                          state.nonAdminModel.length.toDouble()),
                      onTap: () {
                        NonAdminsRegistrationForms(context: context)
                            .registerNonAdminForm(
                                title: 'Non Admin Staff',
                                nonAdmin: fetched ? state.nonAdminModel : null,
                                admin: fetched ? state.user : null);
                      }),
                )
              : emptyState(),
          state is DashBoardFetched && state.admins.isNotEmpty
              ? FileInfoCard(
                  info: StatisticsCard(
                    title: "Admins Staffs",
                    amount: state.admins.length,
                    img: "assets/icons/one_drive.svg",
                    capacity: "",
                    color: const Color(0xFFA4CDFF),
                    percentage:
                        calculatePercentage(state.admins.length.toDouble()),
                  ),
                )
              : emptyState(),
          state is DashBoardFetched && state.campers.isNotEmpty
              ? FileInfoCard(
                  info: StatisticsCard(
                  title: "Campers",
                  amount: state.campers.length,
                  img: "assets/icons/drop_box.svg",
                  capacity: "",
                  color: const Color(0xFF007EE5),
                  percentage:
                      calculatePercentage(state.campers.length.toDouble()),
                ))
              : emptyState(),
          state is DashBoardFetched && state.groups.isNotEmpty
              ? FileInfoCard(
                  info: StatisticsCard(
                      title: "Groups",
                      amount: state.groups.length,
                      img: "assets/icons/google_drive.svg",
                      capacity: "",
                      color: const Color(0xFFFFA113),
                      percentage:
                          calculatePercentage(state.groups.length.toDouble()),
                      onTap: () {
                        GroupsRegistrationForms(context: context)
                            .registerGroupForm(
                                title: 'Groups',
                                admin: fetched ? state.user : null,
                                groups: fetched ? state.groups : null);
                      }),
                )
              : emptyState(),
        ],
      );
    });
  }

  FileInfoCard loadingState() {
    return FileInfoCard(
      info: StatisticsCard(
          title: "Loading",
          amount: 00,
          img: "assets/icons/Documents.svg",
          capacity: "",
          color: primaryColor,
          percentage: 00,
          onTap: () {}),
    );
  }

  FileInfoCard emptyState() {
    return FileInfoCard(
        info: StatisticsCard(
            title: 'loading',
            amount: 00,
            img: '',
            capacity: "00",
            color: primaryColor,
            percentage: 00,
            onTap: null));
  }
}
