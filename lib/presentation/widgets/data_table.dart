import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/logic/bloc/dash_board_bloc/dash_board_bloc.dart';

import '../../config/constants/responsive.dart';
import '../../config/theme.dart';
import '../screens/app_views/components/header.dart';
import '../screens/auth_views/components/components.dart';

class PageContentWidget extends StatefulWidget {
  final List<DataColumn>? columns;
  final List<DataRow>? row;
  final String title;
  final List<Widget>? actions;
  final int? searchIndex;
  final bool? searchAccending;
  final Widget? child;
  const PageContentWidget(
      {super.key,
      this.searchIndex = 0,
      this.searchAccending = true,
      this.columns,
      this.row,
      required this.title,
      this.child,
      this.actions});

  @override
  State<PageContentWidget> createState() => _PageContentWidgetState();
}

class _PageContentWidgetState extends State<PageContentWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();

  @override
  void initState() {
    // BlocProvider.of<AdminManagemetBloc>(context).add(const GetCodeEvent());
    // BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      // It takes 5/6 part of the screen
      flex: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: RefreshIndicator(
          onRefresh: () async =>
              BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent()),
          child: Container(
            clipBehavior: Clip.none,
            padding: const EdgeInsets.all(defaultPadding),
            decoration: const BoxDecoration(
              color: cardColors,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: ScrollConfiguration(
              behavior: MyBehavior(),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Opacity(
                  opacity: _opacity.value,
                  child: Transform.scale(
                    scale: _transform.value,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (Responsive.isDesktop(context))
                          Header(title: widget.title, onPressed: () {}),
                        if (Responsive.isDesktop(context))
                          Padding(
                            padding: const EdgeInsets.only(
                                top: defaultPadding, bottom: defaultPadding),
                            child: Divider(
                              color: primaryColor.withOpacity(0.7),
                            ),
                          ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          physics: const BouncingScrollPhysics(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                widget.title,
                                style: GoogleFonts.josefinSans(
                                    color: kSecondaryColor, fontSize: 20),
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.5,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                physics: const BouncingScrollPhysics(),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: widget.actions ?? [],
                                ),
                              ),
                            ],
                          ),
                        ),
                        (widget.child) ??
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              dragStartBehavior: DragStartBehavior.down,
                              child: DataTable(
                                onSelectAll: (all) {},
                                showBottomBorder: true,
                                dataTextStyle: GoogleFonts.josefinSans(
                                    color: kSecondaryColor, fontSize: 15),
                                sortColumnIndex: widget.searchIndex,
                                sortAscending: widget.searchAccending!,
                                showCheckboxColumn: true,
                                columnSpacing: defaultPadding,
                                // minWidth: 600,
                                columns: widget.columns!,
                                rows: widget.row!,
                              ),
                            )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
