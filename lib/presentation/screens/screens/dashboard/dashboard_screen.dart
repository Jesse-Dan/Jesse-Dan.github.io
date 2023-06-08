import 'package:flutter/material.dart';

import '../../../../config/constants/responsive.dart';
import '../../../../config/theme.dart';
import '../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import 'components/header.dart';

import 'components/my_files.dart';
import 'components/recent_registrations.dart';
import 'components/storage_details.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/main.screen.dashboard';

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        primary: false,
        padding: const EdgeInsets.all(defaultPadding),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        const MyFiles(),
                        const SizedBox(height: defaultPadding),
                        const RecentFiles(),
                        if (Responsive.isMobile(context))
                          const SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          const StorageDetails(
                            defaultPadding: defaultPadding,
                          ),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    const SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we don't want to show it
                  if (!Responsive.isMobile(context))
                    const Expanded(
                      flex: 2,
                      child: StorageDetails(
                        defaultPadding: defaultPadding,
                      ),
                    ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
