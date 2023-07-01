// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/logic/bloc/user_management/user_management_bloc.dart';
import '../../../../../../config/date_time_formats.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../models/atendee_model.dart';
import '../../../../../widgets/index.dart';
import '../../../../../widgets/verify_action_dialogue.dart';

class AttendeeViewForms extends FormWidget {
  AttendeeViewForms({required this.context});

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
  final Rx<TextEditingController> dob = TextEditingController().obs;
  final Rx<DateTime> picked = DateTime.now().obs;

  checkIfNull({required TextEditingController value}) {
    if (value.text.isEmpty || value.text == '') {
      return null;
    } else {
      return value.text;
    }
  }

  viewSelectedAttendeeData(
      {title, required AttendeeModel attendee, attendeeID, adminModel}) {
    DateTime? editableFormattedDate;
    buildCenterFormField(
        title: title,
        context: context,
        widgetsList: [
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'First Name: ' + attendee.firstName,
              suffix: const Icon(Icons.person),
              controller: firstName),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Middle Name: ' + attendee.middleName,
              suffix: const Icon(Icons.person),
              controller: middleName),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Last Name: ' + attendee.lastName,
              suffix: const Icon(Icons.person),
              controller: lastName),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Gender: ' + attendee.gender,
              suffix: const Icon(Icons.male_rounded),
              controller: gender),
          CustomTextField(
              readOnly: true,
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime.now());
                dob.value.text = dateWithoutTIme.format(pickedDate!);
                picked.value = (pickedDate);
              },
              fieldsType: TextInputType.text,
              hint: 'Date of Birth: ' + dateWithoutTIme.format(attendee.dob!),
              suffix: const Icon(Icons.calendar_view_day_rounded),
              controller: dob.value),
          CustomTextField(
              fieldsType: const TextInputType.numberWithOptions(),
              hint: 'Phone Number: ' + attendee.phoneNo,
              suffix: const Icon(Icons.phone),
              controller: phoneNo),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Parent Name: ' + attendee.parentName,
              suffix: const Icon(Icons.no_adult_content),
              controller: parentName),
          CustomTextField(
              fieldsType: const TextInputType.numberWithOptions(),
              hint: 'Parent Phone: ' + attendee.parentNo,
              suffix: const Icon(Icons.phone),
              controller: parentNo),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Parent Consent: ' + attendee.parentConsent,
              suffix: const Icon(Icons.admin_panel_settings_rounded),
              controller: parentConsent),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Pass Issued: ' + attendee.passIssued,
              suffix: const Icon(Icons.perm_identity),
              controller: passIssued),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Home Address: ' + attendee.homeAddress,
              suffix: const Icon(Icons.house),
              controller: homeAddress),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Camper Status: ' + attendee.wouldCamp,
              suffix: const Icon(Icons.home),
              controller: wouldCamp),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Disability Cluster: ' + attendee.disabilityCluster,
              suffix: const Icon(Icons.hearing_disabled_outlined),
              controller: disabilityCluster),
          CustomTextField(
              fieldsType: TextInputType.text,
              hint: 'Commitment Fee: ' + attendee.commitmentFee,
              suffix: const Icon(Icons.payment_rounded),
              controller: commitmentFee),
          CustomTextField(
              fieldsType: TextInputType.text,
              obscureText: true,
              hint: 'ADMIN AUTH CODE',
              suffix: const Icon(Icons.admin_panel_settings_rounded),
              controller: authCodeController),
        ],
        onSubmit: () {
          Navigator.of(context).pop();
        },
        btNtype1: ButtonType.fill,
        color1: (Colors.green),
        onSubmitText: 'Done',
        onSubmitText2: 'Edit Data',
        color2: (Colors.red),
        btNtype2: ButtonType.fill,
        alertType: AlertType.twoBtns,
        onSubmit2: () {
          verifyAction(
              context: context,
              title: attendee.firstName,
              text:
                  'Do you want to proceed to edit ${attendee.firstName} ${attendee.lastName}?',
              action: () {
                BlocProvider.of<UserManagementBloc>(context).add(
                  UpdateAttendeeEvent(
                    attendeeID: attendeeID,
                    adminModel: adminModel,
                    attendeeModel: attendee.copyWith(
                      firstName:
                          checkIfNull(value: firstName) ?? attendee.firstName,
                      middleName:
                          checkIfNull(value: middleName) ?? attendee.middleName,
                      lastName:
                          checkIfNull(value: lastName) ?? attendee.lastName,
                      gender: checkIfNull(value: gender) ?? attendee.gender,
                      phoneNo: checkIfNull(value: phoneNo) ?? attendee.phoneNo,
                      parentName:
                          checkIfNull(value: parentName) ?? attendee.parentName,
                      parentNo:
                          checkIfNull(value: parentNo) ?? attendee.parentNo,
                      homeAddress: checkIfNull(value: homeAddress) ??
                          attendee.homeAddress,
                      disabilityCluster:
                          checkIfNull(value: disabilityCluster) ??
                              attendee.disabilityCluster,
                      commitmentFee: checkIfNull(value: commitmentFee) ??
                          attendee.commitmentFee,
                      parentConsent: checkIfNull(value: parentConsent) ??
                          attendee.parentConsent,
                      passIssued:
                          checkIfNull(value: passIssued) ?? attendee.passIssued,
                      wouldCamp:
                          checkIfNull(value: wouldCamp) ?? attendee.wouldCamp,
                      dob: checkIfNull(value: dob.value) ?? attendee.dob,
                    ),
                    adminCode: authCodeController.text,
                  ),
                );
              });
        });
  }
}
