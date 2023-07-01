// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../../config/date_time_formats.dart';
import '../../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../../../models/atendee_model.dart';
import '../../../../../../models/user_model.dart';
import '../../../../../widgets/index.dart';

class AttendeeRegistrationForms extends FormWidget {
  AttendeeRegistrationForms({required this.context});

  RxString newCode = ''.obs;

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

  registerNewAttandeeForm(
      {required String title,
      length,
      List<AttendeeModel>? attendees,
      AdminModel? admin}) {
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
            hint: 'Date of Birth',
            suffix: const Icon(Icons.calendar_view_day_rounded),
            controller: dob.value),
        CustomTextField(
            fieldsType: const TextInputType.numberWithOptions(),
            hint: 'Phone Number',
            suffix: const Icon(Icons.phone),
            controller: phoneNo),
        CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Parent Name ',
            suffix: const Icon(Icons.no_adult_content),
            controller: parentName),
        CustomTextField(
            fieldsType: const TextInputType.numberWithOptions(),
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
            hint: 'Payment Status (Please take in full / record in full)',
            suffix: const Icon(Icons.payment_rounded),
            controller: commitmentFee),
        CustomTextField(
            fieldsType: TextInputType.text,
            obscureText: true,
            hint: 'Auth Code',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: authCodeController),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomButton(
            color: Colors.green,
            btnText: 'Register',
            onTap: () {
              String generateUniqueCode(List<String> existingCodes) {
                int counter = 0;
                String code;

                do {
                  code = 'CATY${counter.toString().padLeft(3, '0')}';
                  counter++;
                } while (existingCodes.contains(code));

                return code;
              }

              List<String> getItemList(List<AttendeeModel> modelList) {
                return modelList.map((model) => model.id).toList();
              }

              BlocProvider.of<RegistrationBloc>(context).add(
                RegisterAttendeeEvent(
                  authCodeController.text,
                  attendeeModel: AttendeeModel(
                    id: generateUniqueCode(getItemList(attendees!)),
                    createdBy: '${admin!.firstName}_${admin.lastName}',
                    firstName: firstName.text,
                    middleName: middleName.text,
                    lastName: lastName.text,
                    gender: gender.text,
                    phoneNo: phoneNo.text,
                    parentName: parentConsent.text,
                    parentNo: parentNo.text,
                    homeAddress: homeAddress.text,
                    disabilityCluster: disabilityCluster.text,
                    commitmentFee: commitmentFee.text,
                    parentConsent: parentConsent.text,
                    passIssued: passIssued.text,
                    wouldCamp: wouldCamp.text,
                    dob: picked.value,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }
}
