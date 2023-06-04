import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/theme.dart';
import '../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../models/atendee_model.dart';
import '../../../models/group_model.dart';
import '../../../models/non_admin_staff.dart';
import '../../../models/user_model.dart';
import '../costum_text_field.dart';
import '../custom_submit_btn.dart';
import '../dialogue_forms.dart';

class RegistrationForms extends FormWidget {
  RegistrationForms({required this.context});
  final BuildContext context;

  ///[ADMIN AUTH CODE CONTROLLERS]
  final authCodeController = TextEditingController();

  /// [GROUP CREATION CONTROLLERS]
  final groupNameController = TextEditingController();
  final groupDescriptionController = TextEditingController();

  /// [CREATE NON ADMIN CONTROLLERS]
  final TextEditingController lastnameCtlNonAdminReg = TextEditingController();
  final TextEditingController emailCtlNonAdminReg = TextEditingController();
  final TextEditingController phoneCtlNonAdminReg = TextEditingController();
  final TextEditingController genderCtlNonAdminReg = TextEditingController();
  final TextEditingController deptCtlNonAdminReg = TextEditingController();
  final TextEditingController roleCtlNonAdminReg = TextEditingController();
  final TextEditingController authCodeCtlNonAdminReg = TextEditingController();
  final TextEditingController firstNameCtlNonAdminReg = TextEditingController();

  /// [CREATE MEMBER CONTROLLERS]
  final TextEditingController parentName = TextEditingController();
  final TextEditingController parentNo = TextEditingController();
  final TextEditingController homeAddress = TextEditingController();
  final TextEditingController disabilityCluster = TextEditingController();
  final TextEditingController commitmentFee = TextEditingController();
  final TextEditingController parentConsent = TextEditingController();
  final TextEditingController passIssued = TextEditingController();
  final TextEditingController wouldCamp = TextEditingController();
  final TextEditingController firstName = TextEditingController();
  final TextEditingController middleName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController gender = TextEditingController();
  final TextEditingController phoneNo = TextEditingController();
  final TextEditingController createdBy = TextEditingController();

  registerNewAttandeeForm({required String title}) {
    buildBottomFormField(
      context: context,
      title: title,
      widgetsList: [
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'First Name',
            suffix: const Icon(Icons.person),
            controller: firstName),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Middle Name',
            suffix: const Icon(Icons.person),
            controller: middleName),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Last Name',
            suffix: const Icon(Icons.person),
            controller: lastName),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Gender(Male / Female)',
            suffix: const Icon(Icons.male_rounded),
            controller: gender),
        CustomTextField(
            fieldsType: TextInputType.numberWithOptions(),
            hint: 'Phone Number',
            suffix: const Icon(Icons.phone),
            controller: phoneNo),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Parent Name ',
            suffix: const Icon(Icons.no_adult_content),
            controller: parentName),
        CustomTextField(
            fieldsType: TextInputType.numberWithOptions(),
            hint: 'Parent Phone Number',
            suffix: const Icon(Icons.phone),
            controller: parentNo),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Parent Consent',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: parentConsent),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Pass Issued',
            suffix: const Icon(Icons.perm_identity),
            controller: passIssued),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Home Address',
            suffix: const Icon(Icons.house),
            controller: homeAddress),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Would You be Camping?',
            suffix: const Icon(Icons.home),
            controller: wouldCamp),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Disability Cluster',
            suffix: const Icon(Icons.hearing_disabled_outlined),
            controller: disabilityCluster),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Auth Code',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: authCodeController),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Payment Status (Please take in full / record in full)',
            suffix: const Icon(Icons.payment_rounded),
            controller: commitmentFee),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Created by?',
            suffix: const Icon(Icons.payment_rounded),
            controller: createdBy),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            color: Colors.green,
            btnText: 'Register',
            onTap: () {
              BlocProvider.of<RegistrationBloc>(context).add(
                RegisterAttendeeEvent(
                  authCodeController.text,
                  attendeeModel: AttendeeModel(
                    id: '${BlocProvider.of<DashBoardBloc>(context).auth.currentUser?.uid}_${firstNameCtlNonAdminReg.text}_role:${roleCtlNonAdminReg.text}',
                    createdBy:
                        '${BlocProvider.of<DashBoardBloc>(context).auth.currentUser?.uid}_${createdBy.text}',
                    firstName: firstName.text,
                    middleName: middleName.text,
                    lastName: lastName.text,
                    gender: gender.text,
                    phoneNo: parentNo.text,
                    parentName: parentConsent.text,
                    parentNo: parentNo.text,
                    homeAddress: homeAddress.text,
                    disabilityCluster: disabilityCluster.text,
                    commitmentFee: commitmentFee.text,
                    parentConsent: parentConsent.text,
                    passIssued: passIssued.text,
                    wouldCamp: wouldCamp.text,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  ///[REGISTER NON ADMIN]
  registerNonAdminForm({required String title}) {
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
          hint: 'Created by?',
          suffix: const Icon(Icons.payment_rounded),
          controller: createdBy),
      CustomTextField(
          fieldsType: TextInputType.text,
          hint: 'Auth Code',
          suffix: const Icon(Icons.admin_panel_settings_rounded),
          controller: authCodeCtlNonAdminReg),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(
            color: Colors.green,
            btnText: 'Create',
            onTap: () {
              BlocProvider.of<RegistrationBloc>(context).add(CreateNonAdminEvent(
                  authCodeCtlNonAdminReg.text,
                  nonAdminModel: NonAdminModel(
                      id:
                          '${BlocProvider.of<DashBoardBloc>(context).auth.currentUser?.uid}',
                      lastName: lastnameCtlNonAdminReg.text,
                      email: emailCtlNonAdminReg.text,
                      phoneNumber: phoneCtlNonAdminReg.text,
                      gender: genderCtlNonAdminReg.text,
                      dept: deptCtlNonAdminReg.text,
                      role: roleCtlNonAdminReg.text,
                      authCode: authCodeCtlNonAdminReg.text,
                      createdBy:
                          '${BlocProvider.of<DashBoardBloc>(context).auth.currentUser?.uid}_${createdBy.text}',
                      firstName: firstNameCtlNonAdminReg.text,
                      imageUrl: '')));
              log('message');
            }),
      )
    ]);
  }

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
            hint: 'Created by?',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: createdBy),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Admin Code',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: authCodeController),
      ],
      onSubmit: () {
        log('message1111');

        BlocProvider.of<RegistrationBloc>(context).add(
          CreateGroupEvent(
            authCodeController.text,
            groupModel: GroupModel(
              id: '${BlocProvider.of<DashBoardBloc>(context).auth.currentUser?.uid}',
              createdBy:
                  '${BlocProvider.of<DashBoardBloc>(context).auth.currentUser?.uid}_${createdBy.text}',
              name: groupNameController.text,
              description: groupDescriptionController.text,
              groupMembers: [],
            ),
          ),
        );
        log('message');
      },
      onSubmitText: 'Create',
      alertType: AlertType.oneBtn,
      onSubmit2: () {},
      color1: Colors.green,
      btNtype1: ButtonType.long,
    );
  }
}
