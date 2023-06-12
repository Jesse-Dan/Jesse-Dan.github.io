import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../config/date_time_formats.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../models/atendee_model.dart';
import '../../../../../widgets/CustomViewTextField.dart';
import '../../../../../widgets/custom_submit_btn.dart';
import '../../../../../widgets/dialogue_forms.dart';

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

  viewSelectedAttendeeData({title, required AttendeeModel attendee}) {
    DateTime? editableFormattedDate;
    buildCenterFormField(
        title: title,
        context: context,
        widgetsList: [
          CustomViewTextField(
            initialValue: attendee.firstName,
            fieldsType: TextInputType.text,
            hint: 'First Name',
            suffix: const Icon(Icons.person),
          ),
          CustomViewTextField(
            initialValue: attendee.middleName,
            fieldsType: TextInputType.text,
            hint: 'Middle Name',
            suffix: const Icon(Icons.person),
          ),
          CustomViewTextField(
            initialValue: attendee.lastName,
            fieldsType: TextInputType.text,
            hint: 'Last Name',
            suffix: const Icon(Icons.person),
          ),
          CustomViewTextField(
            initialValue: attendee.gender,
            fieldsType: TextInputType.text,
            hint: 'Gender(Male / Female)',
            suffix: const Icon(Icons.male_rounded),
          ),
          CustomViewTextField(
              onTap: () async {},
              readOnly: true,
              fieldsType: const TextInputType.numberWithOptions(),
              hint: 'Date of Birth',
              suffix: const Icon(Icons.calendar_view_day_rounded),
              initialValue: dateWithoutTIme.format((attendee.dob!))),
          CustomViewTextField(
            initialValue: attendee.phoneNo,
            fieldsType: const TextInputType.numberWithOptions(),
            hint: 'Phone Number',
            suffix: const Icon(Icons.phone),
          ),
          CustomViewTextField(
            initialValue: attendee.parentName,
            fieldsType: TextInputType.text,
            hint: 'Parent Name ',
            suffix: const Icon(Icons.no_adult_content),
          ),
          CustomViewTextField(
            initialValue: attendee.parentNo,
            fieldsType: const TextInputType.numberWithOptions(),
            hint: 'Parent Phone Number',
            suffix: const Icon(Icons.phone),
          ),
          CustomViewTextField(
            initialValue: attendee.parentConsent,
            fieldsType: TextInputType.text,
            hint: 'Parent Consent',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
          ),
          CustomViewTextField(
            initialValue: attendee.passIssued,
            fieldsType: TextInputType.text,
            hint: 'Pass Issued',
            suffix: const Icon(Icons.perm_identity),
          ),
          CustomViewTextField(
            initialValue: attendee.homeAddress,
            fieldsType: TextInputType.text,
            hint: 'Home Address',
            suffix: const Icon(Icons.house),
          ),
          CustomViewTextField(
            initialValue: attendee.wouldCamp,
            fieldsType: TextInputType.text,
            hint: 'Would You be Camping?',
            suffix: const Icon(Icons.home),
          ),
          CustomViewTextField(
            initialValue: attendee.disabilityCluster,
            fieldsType: TextInputType.text,
            hint: 'Disability Cluster',
            suffix: const Icon(Icons.hearing_disabled_outlined),
          ),
          const CustomViewTextField(
            initialValue: 'null',
            fieldsType: TextInputType.text,
            obscureText: true,
            hint: 'Auth Code',
            suffix: Icon(Icons.admin_panel_settings_rounded),
          ),
          CustomViewTextField(
            initialValue: attendee.commitmentFee,
            fieldsType: TextInputType.text,
            hint: 'Payment Status (Please take in full / record in full)',
            suffix: const Icon(Icons.payment_rounded),
          ),
          CustomViewTextField(
            initialValue: attendee.firstName,
            fieldsType: TextInputType.text,
            hint: 'Created by?',
            suffix: const Icon(Icons.payment_rounded),
          ),
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
              title: attendee.firstName,
              text:
                  'Do you want to proceed to edit ${attendee.firstName} ${attendee.lastName}?');
        });
  }

  verifyAction({
    title,
    text,
    action,
  }) {
    buildCenterFormField(
      title: title,
      context: context,
      widgetsList: [getBody(text)],
      onSubmit: () {
        Navigator.of(context).pop();
      },
      btNtype1: ButtonType.fill,
      color1: (Colors.green),
      onSubmitText: 'Cancel',
      onSubmitText2: 'Proceed',
      color2: (Colors.red),
      btNtype2: ButtonType.fill,
      alertType: AlertType.twoBtns,
      onSubmit2: action,
    );
  }
}
