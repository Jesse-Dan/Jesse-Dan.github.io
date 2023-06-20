import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/config/app_autorizations.dart';

import '../../../../config/constants/responsive.dart';
import '../../../../config/palette.dart';
import '../../../../config/theme.dart';
import '../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../logic/local_storage_service.dart/local_storage.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    this.title,
    this.onPressed,
  }) : super(key: key);
  final dynamic onPressed;
  final dynamic title;

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? buildHeaderContent(flex: 2)
        : AppBar(
            iconTheme: const IconThemeData(color: primaryColor),
            backgroundColor: Colors.transparent,
            // foregroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            leading: // if (!Responsive.isDesktop(context))
                SizedBox(
              child: Padding(
                  padding: const EdgeInsets.only(right: 6.0),
                  child: IconButton(
                      focusColor: Colors.transparent,
                      color: Colors.transparent,
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(
                        Icons.menu_open,
                        size: 30,
                        color: primaryColor,
                      ),
                      onPressed: () => Scaffold.of(context).openDrawer())),
            ),
            title: buildHeaderContent(flex: 1),
            automaticallyImplyLeading: false,
          );
  }

  Widget buildHeaderContent({flex}) {
    return BlocBuilder<DashBoardBloc, DashBoardState>(
      builder: (context, state) {
        ///[check state]
        bool fetched = state is DashBoardFetched;
        return Row(children: [
          Text(
            fetched

                /// [if state is  loaded && is mobile]
                ? Responsive.isMobile(context)
                    ? AppAuthorizations(
                            localStorageService: LocalStorageService())
                        .getAuthLevel(
                            adminCode: fetched ? state.user.authCode : '')
                    : '${AppAuthorizations(localStorageService: LocalStorageService()).getAuthLevel(adminCode: fetched ? state.user.authCode : '')} | Auth code : ${state.user.authCode}'

                /// [if state is not loaded]
                : 'Loading...| Refresh Page',
            style: GoogleFonts.dmSans(
                fontSize: Responsive.isMobile(context) ? 18 : 22,
                color: primaryColor),
          ),
          Spacer(flex: flex),
          Responsive.isTablet(context)
              ? const Expanded(child: SearchField())
              : const SizedBox.shrink(),
          Responsive.isMobile(context)
              ? const SizedBox.shrink()
              : const Expanded(child: SearchField()),
          const ProfileCard()
        ]);
      },
    );
  }
}

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DashBoardBloc, DashBoardState>(
      listener: (context, state) {},
      builder: (context, state) {
        return GestureDetector(
          onTap: (() {}),
          child: Container(
            margin: const EdgeInsets.only(left: defaultPadding),
            padding: const EdgeInsets.symmetric(
              horizontal: defaultPadding,
              vertical: defaultPadding / 2,
            ),
            decoration: BoxDecoration(
              color: cardColors,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              border: Border.all(color: Colors.white10),
            ),
            child: Row(
              children: [
                Image.asset(
                  "assets/images/profile_pic.png",
                  height: 38,
                ),
                if (!Responsive.isMobile(context))
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: defaultPadding / 3),
                    child: Text(
                      state is DashBoardFetched
                          ? '${state.user.firstName} ${state.user.lastName}'
                          : "Loading User ",
                      style: GoogleFonts.dmSans(color: Palette.white),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: GoogleFonts.dmSans(fontSize: 20, color: Palette.white),
      decoration: InputDecoration(
        hintStyle: GoogleFonts.dmSans(fontSize: 20, color: primaryColor),
        hintText: "Search",
        fillColor: cardColors,
        filled: true,
        border: const OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(30)),
        ),
        suffixIcon: InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(defaultPadding * 0.75),
            margin: const EdgeInsets.symmetric(horizontal: defaultPadding / 2),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(20)),
            ),
            child: SvgPicture.asset("assets/icons/Search.svg"),
          ),
        ),
      ),
    );
  }
}
