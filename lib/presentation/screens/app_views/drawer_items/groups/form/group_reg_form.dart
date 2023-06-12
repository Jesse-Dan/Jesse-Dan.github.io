import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/index_blocs.dart';
import '../../../../../../models/group_model.dart';
import '../../../../../widgets/costum_text_field.dart';
import '../../../../../widgets/dialogue_forms.dart';
import '../../../../../widgets/index.dart';

class GroupsRegistrationForms extends FormWidget {
  GroupsRegistrationForms({required this.context});

  Widget getBody(text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text,
          style: GoogleFonts.gochiHand(
              color: kSecondaryColor,
              fontSize: 17,
              fontWeight: FontWeight.w500)),
    );
  }

  final BuildContext context;

  ///[ADMIN AUTH CODE CONTROLLERS]
  final authCodeController = TextEditingController();

  /// [GROUP CREATION CONTROLLERS]
  final groupNameController = TextEditingController();
  final groupDescriptionController = TextEditingController();
  final groupfacilitatorController = TextEditingController();

  /// [CREATE NON ADMIN CONTROLLERS]
  final TextEditingController createdBy = TextEditingController();


  ///[CREATE GROUP FORM]
  registerGroupForm({required String title}) {
    buildCenterFormField(
      title: title,
      context: context,
      widgetsList: [
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Group Name',
            suffix: const Icon(Icons.group),
            controller: groupNameController),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Group Description',
            suffix: const Icon(Icons.people_outline_rounded),
            controller: groupDescriptionController),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Facilitator',
            suffix: const Icon(Icons.leak_add_rounded),
            controller: groupfacilitatorController),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Created by?',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: createdBy),
        CustomTextField(
            fieldsType: TextInputType.text,
            obscureText: true,
            hint: 'Admin Code',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: authCodeController),
      ],
      onSubmit: () {
        BlocProvider.of<RegistrationBloc>(context).add(
          CreateGroupEvent(
            authCodeController.text,
            groupModel: GroupModel(
              id: '',
              createdBy: createdBy.text,
              name: groupNameController.text,
              description: groupDescriptionController.text,
              groupMembers: [],
              facilitator: groupfacilitatorController.text,
            ),
          ),
        );
      },
      onSubmitText: 'Create',
      alertType: AlertType.oneBtn,
      onSubmit2: () {},
      color1: Colors.green,
      btNtype1: ButtonType.long,
    );
  }
}
