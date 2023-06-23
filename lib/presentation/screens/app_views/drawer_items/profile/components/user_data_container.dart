import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/index_blocs.dart';
import '../../../../../../config/theme.dart';
import '../../../../../widgets/customm_text_btn.dart';
import 'data_list_tile.dart';

class UserData extends StatelessWidget {
  const UserData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.only(top: 100),
        child: Padding(
          padding: const EdgeInsets.all(defaultPadding),
          child: BlocBuilder<DashBoardBloc, DashBoardState>(
            builder: (context, state) {
              bool fetched = state is DashBoardFetched;
              bool loading = state is DashBoardLoading;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  headerText(
                      text: fetched
                          ? '${state.user.firstName} ${state.user.lastName}'
                          : loading
                              ? 'Loading'
                              : 'Refresh'),
                  contentText(
                      title: 'Phone Number',
                      text: fetched
                          ? state.user.phoneNumber
                          : loading
                              ? 'Loading'
                              : 'Refresh'),
                  contentText(
                      title: 'E-mail',
                      text: fetched
                          ? state.user.email
                          : loading
                              ? 'Loading'
                              : 'Refresh'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextBtn(
                          textColor: Colors.green,
                          icon: Icons.edit_document,
                          iconColor: Colors.green,
                          text: 'Edit Profile',
                          onTap: () {},
                        ),
                      ),
                    ],
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
