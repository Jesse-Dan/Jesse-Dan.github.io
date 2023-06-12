import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../models/models.dart';
import '../../../../config/theme.dart';
import 'chart.dart';
import '../../app_views/components/attendees_stats_info_card.dart';

class AttendeesStatsDetails extends StatefulWidget {
  final double? defaultPadding;

  const AttendeesStatsDetails({
    Key? key,
    this.defaultPadding,
  }) : super(key: key);

  @override
  State<AttendeesStatsDetails> createState() => _AttendeesStatsDetailsState();
}

class _AttendeesStatsDetailsState extends State<AttendeesStatsDetails> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashBoardBloc, DashBoardState>(
      builder: (context, state) {
        bool fetched = state is DashBoardFetched;
        bool error = state is DashBoardFailed;
        bool loading = state is DashBoardLoading;
        bool initial = state is DashBoardInitial;

        return Container(
          padding: EdgeInsets.all(widget.defaultPadding!),
          decoration: const BoxDecoration(
            color: cardColors,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Attendees Age schematics",
                style: GoogleFonts.dmSans(
                  color: kSecondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: widget.defaultPadding),
              const Chart(),
              const AgeScematicsInfoCard(
                svgSrc: "assets/icons/Documents.svg",
                title: "Age 10",
                amountOfFiles: "1.3Attendees",
                numOfAttendees: 1328,
              ),
              const AgeScematicsInfoCard(
                svgSrc: "assets/icons/media.svg",
                title: "Age 11",
                amountOfFiles: "15.3Attendees",
                numOfAttendees: 1328,
              ),
              const AgeScematicsInfoCard(
                svgSrc: "assets/icons/folder.svg",
                title: "Age 12",
                amountOfFiles: "1.3Attendees",
                numOfAttendees: 1328,
              ),
              const AgeScematicsInfoCard(
                svgSrc: "assets/icons/unknown.svg",
                title: "Age 13",
                amountOfFiles: "1.3Attendees",
                numOfAttendees: 140,
              ),
              const AgeScematicsInfoCard(
                svgSrc: "assets/icons/Documents.svg",
                title: "Age 14",
                amountOfFiles: "1.3Attendees",
                numOfAttendees: 140,
              ),
              const AgeScematicsInfoCard(
                svgSrc: "assets/icons/media.svg",
                title: "Age 15",
                amountOfFiles: "1.3Attendees",
                numOfAttendees: 140,
              ),
              const AgeScematicsInfoCard(
                svgSrc: "assets/icons/folder.svg",
                title: "Age 16",
                amountOfFiles: "1.3Attendees",
                numOfAttendees: 140,
              ),
              const AgeScematicsInfoCard(
                svgSrc: "assets/icons/unknown.svg",
                title: "Age 17",
                amountOfFiles: "1.3Attendees",
                numOfAttendees: 140,
              ),
              AgeScematicsInfoCard(
                svgSrc: "assets/icons/Documents.svg",
                title: "Age 18+",
                amountOfFiles: fetched
                    ? "${getAge(
                        ageLimit: calculateAgeInSeconds(18),
                        listOfAttendees: state.attendeeModel,
                      )}Attendees"
                    : '0 Attendees',
                numOfAttendees: 140,
              ),
            ],
          ),
        );
      },
    );
  }

  int calculateAgeInSeconds(int age) {
    int secondsInAYear = 365 * 24 * 60 * 60;
    int ageInSeconds = age * secondsInAYear;
    return ageInSeconds;
  }

  int getAge(
      {required int ageLimit, required List<AttendeeModel> listOfAttendees}) {
    DateTime currentDate = DateTime.now();
    DateTime limitDate = currentDate.subtract(Duration(seconds: ageLimit));

    List<AttendeeModel> ageGroup = listOfAttendees
        .where((element) => element.dob!.isAtSameMomentAs(limitDate))
        .toList();
    int finalAgeLimitCount = ageGroup.length;
    return finalAgeLimitCount;
  }
}
