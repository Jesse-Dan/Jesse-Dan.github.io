import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../config/constants/responsive.dart';
import '../../../../../config/theme.dart';
import '../../../../../models/RecentFile.dart';
import '../../../../../models/atendee_model.dart';

class RecentFiles extends StatelessWidget {
  const RecentFiles({
    Key? key,
  }) : super(key: key);

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
                  onPressed: () {},
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
            child: SizedBox(
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
                  attendees.length,
                  (index) => (recentFileDataRow(attendees[index], context)),
                ),
              ),
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
              // Row(
              //   children: [
              // SvgPicture.asset(
              //   // recentReg.,
              //   height: 30,
              //   width: 30,
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: defaultPadding),
              //   child:
              Text(
                '${recentReg.firstName} ${recentReg.lastName}',
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
                // ),
                // ),
                // ],
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
              // Row(
              //   children: [
              // SvgPicture.asset(
              //   // recentReg.icon,
              //   height: 30,
              //   width: 30,
              // ),
              // Padding(
              //   padding:
              //       const EdgeInsets.symmetric(horizontal: defaultPadding),
              //   child:
              Text(
                recentReg.firstName,
                style: GoogleFonts.dmSans(color: kSecondaryColor, fontSize: 15),
              ),
              //   ),
              // ],
              // ),
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
