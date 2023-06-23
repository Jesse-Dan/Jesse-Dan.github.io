
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../config/constants/responsive.dart';
import '../../../../config/theme.dart';
import '../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../models/atendee_model.dart';
import '../drawer_items/attendees/attendees_screen.dart';

class RecentFiles extends StatefulWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

  @override
  State<RecentFiles> createState() => _RecentFilesState();
}

class _RecentFilesState extends State<RecentFiles> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: cardColors,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Recent Registrations",
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 20),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, AttendeesScreen.routeName);
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'more',
                          style: GoogleFonts.dmSans(
                              color: primaryColor, fontSize: 15),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios_rounded,
                          size: 15,
                          color: primaryColor,
                        ),
                      ]))
            ],
          ),
          SingleChildScrollView(
            child: BlocConsumer<DashBoardBloc, DashBoardState>(
              listener: (context, state) {
                
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
                                  "CamperStatus",
                                  style: GoogleFonts.dmSans(
                                      color: kSecondaryColor, fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Sex",
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
                                  "CamperStatus",
                                  style: GoogleFonts.dmSans(
                                      color: kSecondaryColor, fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Code",
                                  style: GoogleFonts.dmSans(
                                      color: kSecondaryColor, fontSize: 15),
                                ),
                              ),
                              DataColumn(
                                label: Text(
                                  "Commitment Fee",
                                  style: GoogleFonts.dmSans(
                                      color: kSecondaryColor, fontSize: 15),
                                ),
                              ),
                            ],
                      rows: List.generate(
                        state.attendeeModel.length.isGreaterThan(10)
                            ? state.attendeeModel.sublist(0, 10).length
                            : state.attendeeModel.length,
                        (index) => (recentFileDataRow(
                            state.attendeeModel.length.isGreaterThan(10)
                                ? state.attendeeModel.sublist(0, 10)[index]
                                : state.attendeeModel[index],
                            context)),
                      ),
                    ),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow recentFileDataRow(AttendeeModel recentReg, context) {
  return DataRow(
    cells: Responsive.isMobile(context)
        ? [
            DataCell(
              Text(
                '${recentReg.firstName} ${recentReg.lastName}',
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
            ),
            DataCell(Text(
              recentReg.wouldCamp,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              recentReg.gender,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
          ]
        : [
            DataCell(
              Text(
                recentReg.firstName,
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
            ),
            DataCell(Text(
              recentReg.wouldCamp,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              recentReg.id,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
            DataCell(Text(
              recentReg.commitmentFee,
              style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
            )),
          ],
  );
}
