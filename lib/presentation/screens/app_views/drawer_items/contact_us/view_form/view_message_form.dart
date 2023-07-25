import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_event.dart';
import 'package:tyldc_finaalisima/models/contact_us_model.dart';
import 'package:tyldc_finaalisima/models/socials_model.dart';
import 'package:tyldc_finaalisima/presentation/widgets/index.dart';

import '../../../../../../config/overlay_config/overlay_service.dart';
import '../../../../../widgets/popupmenu_widget.dart';
import '../../../../../widgets/verify_action_dialogue.dart';

class ContactUsViewForm extends FormWidget {
  ContactUsViewForm({required this.context});

  final newUrlCtl = TextEditingController();

  final BuildContext context;
  viewMessage({required ContactUsModel contactMessage}) {
    buildCenterFormField(
      title: 'Message from \n${contactMessage.name}',
      context: context,
      widgetsList: [getBody(contactMessage.message, null)],
      onSubmit: () {
        OverlayService.closeAlert();
      },
      btNtype1: ButtonType.fill,
      onSubmitText: 'Done',
      alertType: AlertType.oneBtn,
      onSubmit2: () {},
    );
  }

  deleteMessage({required ContactUsModel contactMessage}) {
    verifyAction(
        context: context,
        text:
            'Are you sure you want to delete this message From\n${contactMessage.name}?',
        title: 'Delete Message From\n${contactMessage.name}',
        action: () {
          BlocProvider.of<ContactUsBloc>(context)
              .add(DeleteContactMessagelEvent(contactUsModel: contactMessage));
        });
  }

  showOptions({Widget? icon, SocialsModel? socials}) {
    return socials == null
        ? SizedBox()
        : PopupMenu(
            items: [
              PopupMenuItemModel(
                  title: 'Update ${socials.socials[0].socialName} url',
                  onTap: () {
                    viewAuthCodeData(
                        socialUrl: socials.socials[0],
                        title: 'Update ${socials.socials[0].socialName} url',
                        action: () {
                          BlocProvider.of<ContactUsBloc>(context)
                              .add(UpdateSocialsEvent(
                                  contactUsModel: SocialsUrls(
                            socialName: 'Facebook',
                            url: newUrlCtl.text,
                          )));
                        });
                  }),
              PopupMenuItemModel(
                  title: 'Update ${socials.socials[1].socialName} url',
                  onTap: () {
                    viewAuthCodeData(
                        socialUrl: socials.socials[1],
                        title: 'Update ${socials.socials[1].socialName} url',
                        action: () {
                          BlocProvider.of<ContactUsBloc>(context)
                              .add(UpdateSocialsEvent(
                                  contactUsModel: SocialsUrls(
                            socialName: socials.socials[1].socialName,
                            url: newUrlCtl.text,
                          )));
                        });
                  }),
              PopupMenuItemModel(
                  title: 'Update ${socials.socials[2].socialName} url',
                  onTap: () {
                    viewAuthCodeData(
                        socialUrl: socials.socials[2],
                        title: 'Update ${socials.socials[2].socialName} url',
                        action: () {
                          BlocProvider.of<ContactUsBloc>(context)
                              .add(UpdateSocialsEvent(
                                  contactUsModel: SocialsUrls(
                            socialName: socials.socials[2].socialName,
                            url: newUrlCtl.text,
                          )));
                        });
                  }),
              PopupMenuItemModel(
                  title: 'Update ${socials.socials[3].socialName} url',
                  onTap: () {
                    viewAuthCodeData(
                        socialUrl: socials.socials[3],
                        title: 'Update ${socials.socials[3].socialName} url',
                        action: () {
                          BlocProvider.of<ContactUsBloc>(context)
                              .add(UpdateSocialsEvent(
                                  contactUsModel: SocialsUrls(
                            socialName: socials.socials[3].socialName,
                            url: newUrlCtl.text,
                          )));
                        });
                  }),
              PopupMenuItemModel(
                  title: 'Update ${socials.socials[4].socialName} url',
                  onTap: () {
                    viewAuthCodeData(
                        socialUrl: socials.socials[4],
                        title: 'Update ${socials.socials[4].socialName} url',
                        action: () {
                          BlocProvider.of<ContactUsBloc>(context)
                              .add(UpdateSocialsEvent(
                                  contactUsModel: SocialsUrls(
                            socialName: socials.socials[4].socialName,
                            url: newUrlCtl.text,
                          )));
                        });
                  })
            ],
            icon: icon ?? Icon(Icons.abc),
          );
  }

  viewAuthCodeData({
    title,
    SocialsUrls? socialUrl,
    void Function()? action,
  }) {
    buildCenterFormField(
        title: title,
        context: context,
        widgetsList: [
          CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'New Url',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: newUrlCtl,
          ),
        ],
        onSubmit: () {
          OverlayService.closeAlert();
        },
        btNtype1: ButtonType.fill,
        color1: (Colors.green),
        onSubmitText: 'Done',
        onSubmitText2: 'Edit ${socialUrl!.socialName} Url',
        color2: (Colors.red),
        btNtype2: ButtonType.fill,
        alertType: AlertType.twoBtns,
        onSubmit2: () {
          action!();
        });
  }
}
