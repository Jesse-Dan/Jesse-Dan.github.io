import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/dash_board_bloc/dash_board_bloc.dart';

import '../../../../config/theme.dart';

class Chart extends StatefulWidget {
  const Chart({
    Key? key,
  }) : super(key: key);

  @override
  State<Chart> createState() => _ChartState();
}

var total = 0;

class _ChartState extends State<Chart> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardBloc, DashBoardState>(
      listener: (context, state) {
        setState(() {
          total = state is DashBoardFetched
              ? state.admins.length +
                  state.attendeeModel.length +
                  state.nonAdminModel.length
              : 0;
        });
      },
      builder: (context, state) {
        return SizedBox(
          height: 200,
          child: Stack(
            children: [
              PieChart(
                PieChartData(
                  sectionsSpace: 0,
                  centerSpaceRadius: 70,
                  startDegreeOffset: -90,
                  sections: [
                    PieChartSectionData(
                      color: primaryColor,
                      value: 25,
                      showTitle: true,
                      radius: 25,
                    ),
                    PieChartSectionData(
                      color: const Color(0xFF26E5FF),
                      value: 20,
                      showTitle: false,
                      radius: 22,
                    ),
                    PieChartSectionData(
                      color: const Color(0xFFFFCF26),
                      value: 10,
                      showTitle: false,
                      radius: 19,
                    ),
                    PieChartSectionData(
                      color: const Color(0xFFEE2727),
                      value: 15,
                      showTitle: false,
                      radius: 16,
                    ),
                    PieChartSectionData(
                      color: primaryColor.withOpacity(0.1),
                      value: 25,
                      showTitle: false,
                      radius: 13,
                    ),
                  ],
                ),
              ),
              Positioned.fill(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: defaultPadding),
                    Text(
                      total.toString(),
                      style:
                          Theme.of(context).textTheme.headlineMedium!.copyWith(
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w600,
                                height: 0.5,
                              ),
                    ),
                    const Text("of 128GB")
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
