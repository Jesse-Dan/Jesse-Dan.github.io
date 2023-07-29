import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_state.dart';
import 'package:tyldc_finaalisima/presentation/screens/app_views/drawer_items/contact_us/view_form/view_message_form.dart';
import '../../../../../config/date_time_formats.dart';
import '../../../../../config/overlay_config/overlay_service.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../../../models/contact_us_model.dart';
import '../../../../widgets/alertify.dart';
import '../../../../widgets/align_text_with_icon_widget.dart';
import '../../../../widgets/custom_floating_action_btn.dart';
import '../../../../widgets/data_table.dart';
import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../widgets/customm_text_btn.dart';
import '../../../auth_views/login.dart';
import '../../components/header.dart';
import '../../components/prefered_size_widget.dart';
import '../dashboard/components/side_menu.dart';

class ContactUsScreen extends StatefulWidget {
  static const routeName = '/main.contact.messages';

  const ContactUsScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
        listeners: [
          BlocListener<ContactUsBloc, ContactUsState>(
            listener: (context, state) {
              if (state is ContactUsMessagesLoadedContactUsState ||
                  state is SocialsLoadedContactUsState) {
                OverlayService.closeAlert();
                BlocProvider.of<DashBoardBloc>(context)
                    .add(DashBoardDataEvent());
              }
              if (state is LoadingContactUsState) OverlayService.showLoading();
              if (state is ErrorContactUsState) OverlayService.closeAlert();
            },
          ),
          BlocListener<DashBoardBloc, DashBoardState>(
            listener: (context, state) {
              if (state is DashBoardFetched) {
                OverlayService.closeAlert();
              }
              if (state is DashBoardLoading) OverlayService.showLoading();
              if (state is DashBoardFailed) OverlayService.closeAlert();

              if (state is DashBoardFetched && !state.user.enabled) {
                Alertify.error(message: 'Your account has been disabled');
                BlocProvider.of<AuthenticationBloc>(context).add(LogoutEvent());
                Navigator.pushNamedAndRemoveUntil(
                    context, SignInScreen.routeName, (_) => false);
              }
            },
          ),
        ],
        child: Scaffold(
          backgroundColor: bgColor,
          drawer: SideMenu(),
          appBar: (Responsive.isMobile(context))
              ? CustomPreferredSizeWidget(
                  preferredHeight: 100,
                  preferredWidth: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(kdefaultPadding),
                    child: Header(title: 'Contact Messages', onPressed: () {}),
                  ))
              : null,
          body: SafeArea(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // We want this side menu only for large screen
                if (Responsive.isDesktop(context))
                  const Expanded(
                    // default flex = 1
                    // and it takes 1/6 part of the screen
                    child: SideMenu(),
                  ),
                //table
                BlocBuilder<DashBoardBloc, DashBoardState>(
                    builder: (context, state) {
                  bool fetched = state is DashBoardFetched;
                  return PageContentWidget(
                    searchIndex: 2,
                    columns: [
                      DataColumn(
                        label: Text(
                          "Contact Name",
                          style: GoogleFonts.josefinSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Contact Phone NO",
                          style: GoogleFonts.josefinSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Contact Time",
                          style: GoogleFonts.josefinSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Contact Email",
                          style: GoogleFonts.josefinSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Contact Subject",
                          style: GoogleFonts.josefinSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Contact Message",
                          style: GoogleFonts.josefinSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                      DataColumn(
                        label: Text(
                          "Delete Contact",
                          style: GoogleFonts.josefinSans(
                              color: kSecondaryColor, fontSize: 15),
                        ),
                      ),
                    ],
                    row: List.generate(
                      fetched ? state.contactMessages.length : 0,
                      (index) => (recentFileDataRow(
                        context: context,
                        contactMessage:
                            fetched ? state.contactMessages[index] : null,
                      )),
                    ),
                    title: 'Contact Messages',
                    actions: [
                      ContactUsViewForm(context: context).showOptions(
                          icon: AlignIconWithTextWidget(
                            icon: (Icons.update_rounded),
                            text: 'Update Social Urls',
                          ),
                          socials: fetched ? state.socials : null),
                      const TextBtn(
                        icon: Icons.filter_list,
                        text: 'Filter',
                      )
                    ],
                  );
                })
              ],
            ),
          ),
          floatingActionButton: CustomFloatingActionBtn(
            onPressed: () {
              BlocProvider.of<DashBoardBloc>(context).add(DashBoardDataEvent());
            },
          ),
        ));
  }
}

DataRow recentFileDataRow(
    {required ContactUsModel? contactMessage, required BuildContext context}) {
  return DataRow(
    cells: [
      DataCell(
        Text(
          contactMessage!.name.toLowerCase(),
          style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
        ),
      ),
      DataCell(Text(
        contactMessage.phoneNumber.toLowerCase(),
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        dateWithTime.format(contactMessage.timeStamp),
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        contactMessage.email,
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Text(
        contactMessage.subject,
        style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
      )),
      DataCell(Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        IconButton(
          splashRadius: 5,
          icon: Icon(
            Icons.open_in_full,
            color: kSecondaryColor,
            size: 20,
          ),
          onPressed: () {
            ContactUsViewForm(context: context)
                .viewMessage(contactMessage: contactMessage);
          },
        ),
        Text(
          contactMessage.message.length >= 40
              ? '${contactMessage.message.split(' ')[0]}...'
              : contactMessage.message,
          style: GoogleFonts.josefinSans(color: kSecondaryColor, fontSize: 15),
        ),
      ])),
      DataCell(IconButton(
          splashRadius: 5,
          icon: Icon(
            Icons.delete,
            color: kSecondaryColor,
            size: 20,
          ),
          onPressed: () {
            ContactUsViewForm(context: context)
                .deleteMessage(contactMessage: contactMessage);
          })),
    ],
  );
}
