import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/presentation/screens/app_views/drawer_items/components/prefered_size_widget.dart';

import '../../../../../config/constants/responsive.dart';
import '../../../../../config/palette.dart';
import '../../../../../config/theme.dart';
import '../../../../../logic/bloc/cubit/methods_cubit.dart';
import '../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';

class Header extends StatefulWidget {
  const Header({
    Key? key,
    this.onPressed,
  }) : super(key: key);
  final dynamic onPressed;
  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  @override
  Widget build(BuildContext context) {
    return Responsive.isDesktop(context)
        ? Row(children: [
            if (!Responsive.isMobile(context))
              Text(
                "Dashboard",
                style: GoogleFonts.dmSans(fontSize: 30, color: primaryColor),
              ),
            if (!Responsive.isMobile(context))
              Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
            const Expanded(child: SearchField()),
            const ProfileCard()
          ])
        : AppBar(
            iconTheme: const IconThemeData(color: primaryColor),

            backgroundColor: Colors.transparent,
            // foregroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            elevation: 0,
            leading: // if (!Responsive.isDesktop(context))
                SizedBox(
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
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
                        onPressed: () => Scaffold.of(context).openDrawer())
              ),
            ),
            title: Row(
              children: [
                if (!Responsive.isMobile(context))
                  Text(
                    "Dashboard",
                    style:
                        GoogleFonts.dmSans(fontSize: 30, color: primaryColor),
                  ),
                if (!Responsive.isMobile(context))
                  Spacer(flex: Responsive.isDesktop(context) ? 2 : 1),
                const Expanded(child: SearchField()),
                const ProfileCard()
              ],
            ),
            automaticallyImplyLeading: false,
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
                        horizontal: defaultPadding / 2),
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
