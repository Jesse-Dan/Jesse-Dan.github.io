import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/config/app_autorizations.dart';
import 'package:tyldc_finaalisima/config/theme.dart';
import 'package:tyldc_finaalisima/logic/local_storage_service.dart/local_storage.dart';

import '../../../../../../logic/bloc/index_blocs.dart';
import 'data_list_tile.dart';

class ProfileMiddle extends StatelessWidget {
  const ProfileMiddle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Container(
        // height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: bgColor.withOpacity(0.5),
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(10),
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: BlocBuilder<DashBoardBloc, DashBoardState>(
            builder: (context, state) {
              bool fetched = state is DashBoardFetched;
              bool loading = state is DashBoardLoading;
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  headerText(text: "Administrative Priveleges"),
                  contentText(
                      title: 'Administrative Level',
                      color: primaryColor,
                      text: AppAuthorizations(
                              localStorageService: LocalStorageService())
                          .getAuthLevel(
                              adminCode: fetched ? state.user.authCode : '')),
                  contentText(
                      title: 'Department',
                      color: primaryColor,
                      text: fetched
                          ? state.user.dept
                          : loading
                              ? 'Loading'
                              : 'Refresh'),
                  contentText(
                      title: 'Role',
                      color: primaryColor,
                      text: fetched
                          ? state.user.role
                          : loading
                              ? 'Loading'
                              : 'Refresh'),
                  contentText(
                      title: 'Administrative Code',
                      color: primaryColor,
                      text: fetched
                          ? state.user.authCode
                          : loading
                              ? 'Loading'
                              : 'Refresh'),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
