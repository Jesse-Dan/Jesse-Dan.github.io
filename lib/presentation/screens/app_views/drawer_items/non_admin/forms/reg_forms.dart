import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../../../models/models.dart';
import '../../../../../widgets/costum_text_field.dart';
import '../../../../../widgets/custom_submit_btn.dart';
import '../../../../../widgets/dialogue_forms.dart';

class NonAdminsRegistrationForms extends FormWidget {
  NonAdminsRegistrationForms({required this.context});

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
  final TextEditingController lastnameCtlNonAdminReg = TextEditingController();
  final TextEditingController emailCtlNonAdminReg = TextEditingController();
  final TextEditingController phoneCtlNonAdminReg = TextEditingController();
  final TextEditingController genderCtlNonAdminReg = TextEditingController();
  final TextEditingController deptCtlNonAdminReg = TextEditingController();
  final TextEditingController roleCtlNonAdminReg = TextEditingController();
  final TextEditingController authCodeCtlNonAdminReg = TextEditingController();
  final TextEditingController firstNameCtlNonAdminReg = TextEditingController();
  final TextEditingController createdBy = TextEditingController();

  ///[REGISTER NON ADMIN]
  registerNonAdminForm({required String title, nonAdmin, AdminModel? admin}) {
    buildBottomFormField(context: context, title: title, widgetsList: [
      CustomTextField(
          fieldsType: TextInputType.text,
          hint: 'First Name',
          suffix: const Icon(Icons.person),
          controller: firstNameCtlNonAdminReg),
      CustomTextField(
          fieldsType: TextInputType.text,
          hint: 'Last Name',
          suffix: const Icon(Icons.person),
          controller: lastnameCtlNonAdminReg),
      CustomTextField(
          fieldsType: TextInputType.phone,
          hint: 'Phone Number',
          suffix: const Icon(Icons.phone),
          controller: phoneCtlNonAdminReg),
      CustomTextField(
          fieldsType: TextInputType.text,
          hint: 'Email ',
          suffix: const Icon(Icons.mail),
          controller: emailCtlNonAdminReg),
      CustomTextField(
          fieldsType: TextInputType.text,
          hint: 'Gender',
          suffix: const Icon(Icons.male),
          controller: genderCtlNonAdminReg),
      CustomTextField(
          fieldsType: TextInputType.text,
          hint: 'Department',
          suffix: const Icon(Icons.people),
          controller: deptCtlNonAdminReg),
      CustomTextField(
          fieldsType: TextInputType.text,
          hint: 'Role',
          suffix: const Icon(Icons.settings_accessibility_rounded),
          controller: roleCtlNonAdminReg),
      CustomTextField(
          fieldsType: TextInputType.text,
          obscureText: true,
          hint: 'Auth Code',
          suffix: const Icon(Icons.admin_panel_settings_rounded),
          controller: authCodeCtlNonAdminReg),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
            color: Colors.green,
            btnText: 'Create',
            onTap: () {
              String generateUniqueCode(List<String> existingCodes) {
                int counter = 0;
                String code;

                do {
                  code = 'CATY-NA-${counter.toString().padLeft(3, '0')}';
                  counter++;
                } while (existingCodes.contains(code));

                return code;
              }

              List<String> getItemList(List<NonAdminModel> modelList) {
                return modelList.map((model) => model.id!).toList();
              }

              BlocProvider.of<RegistrationBloc>(context).add(
                  CreateNonAdminEvent(authCodeCtlNonAdminReg.text,
                      nonAdminModel: NonAdminModel(
                          id: generateUniqueCode(getItemList(nonAdmin)),
                          lastName: lastnameCtlNonAdminReg.text,
                          email: emailCtlNonAdminReg.text,
                          phoneNumber: phoneCtlNonAdminReg.text,
                          gender: genderCtlNonAdminReg.text,
                          dept: deptCtlNonAdminReg.text,
                          role: roleCtlNonAdminReg.text,
                          authCode: authCodeCtlNonAdminReg.text,
                          createdBy: '${admin!.firstName}_${admin.lastName}',
                          firstName: firstNameCtlNonAdminReg.text,
                          imageUrl: '')));
              log('message');
            }),
      )
    ]);
  }
}
