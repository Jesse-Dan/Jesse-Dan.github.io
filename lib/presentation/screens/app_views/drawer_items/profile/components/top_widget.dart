import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import 'package:tyldc_finaalisima/presentation/screens/app_views/drawer_items/profile/components/user_data_container.dart';

import '../../../../../../config/theme.dart';

Stack ProfileTop() {
  return Stack(
    children: [
      Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
          ),
          Container(
            height: 400,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: cardColors,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            child: const UserData(),
          ),
        ],
      ),
      Positioned(
        top: 115,
        left: 40,
        child: Container(
          height: 160,
          width: 160,
          decoration: BoxDecoration(
            color: cardColors,
            borderRadius: BorderRadius.circular(100),
          ),
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: BlocBuilder<DashBoardBloc, DashBoardState>(
              builder: (context, state) {
                bool loading = state is DashBoardLoading;
                bool fetched = state is DashBoardFetched;
                return Container(
                    height: 10,
                    width: 10,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(
                            fetched ? state.user.imageUrl : '',
                          ),
                          fit: BoxFit.fill),
                      color: bgColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: fetched
                        ? state.user.imageUrl == ''
                            ? const Icon(Icons.person_rounded,
                                size: 120, color: cardColors)
                            : null
                        : loading
                            ? const Icon(Icons.person_rounded,
                                size: 120, color: cardColors)
                            : const Icon(Icons.person_rounded,
                                size: 120, color: cardColors));
              },
            ),
          ),
        ),
      ),
    ],
  );
}
