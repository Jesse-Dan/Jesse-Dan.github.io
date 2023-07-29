// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../../../config/constants/responsive.dart';
import '../../../../../../config/overlay_config/overlay_service.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../../../../models/atendee_model.dart';
import '../../../../../../models/departments_type_model.dart';
import '../../../../../../models/user_model.dart';
import '../../../../../widgets/dropdown_widget.dart';
import '../../../../../widgets/index.dart';

class AttendeeRegistrationForms extends FormWidget {
  AttendeeRegistrationForms({required this.context});

  RxString newCode = ''.obs;
  String? val;
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
  final TextEditingController newDeptCtl = TextEditingController();

  /// gender types
  final List<String> genderType = ['Male', 'Female'];

  /// Check All
  final List<String> check = ['Yes', 'No'];

  /// Medical conditions
  final List<String> disabilityClusters = [
    'Visual Impairment',
    'Hearing Impairment',
    'Physical Disabilities',
    'Intellectual Disabilities',
    'Speech and Language Disabilities',
    'Neurodevelopmental Disabilities',
    'Psychosocial Disabilities',
  ];

  /// Valuables Types
  final List<String> valuableTypes = [
    'Phone',
    'Computer',
    'Wrist-Watch',
    'Glasses',
    'Chains and Neck-Lace'
  ];

  viewAuthCodeData({
    title,
    Departments? department,
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
            controller: newDeptCtl,
          ),
        ],
        onSubmit: () {
          OverlayService.closeAlert();
        },
        btNtype1: ButtonType.fill,
        color1: (Colors.green),
        onSubmitText: 'Done',
        onSubmitText2: 'Edit ${department!.departmentName} Url',
        color2: (Colors.red),
        btNtype2: ButtonType.fill,
        alertType: AlertType.twoBtns,
        onSubmit2: () {
          action!();
        });
  }

  Widget genderDropDown(
      {void Function(String?)? onChanged,
      String? value,
      Size? size,
      Color? fillColor,
      IconData? iconsData,
      Color? inputColors}) {
    return buildParentCard(
      fillColor: fillColor != null ? fillColor : null,
      size: size,
      child: ReusableDropdown<String>(
        iconsData: iconsData!,
        inputColors: null,
        fillColor: fillColor,
        labelText: 'Gender',
        items: genderType,
        value: value,
        onChanged: onChanged!,
      ),
    );
  }

  Widget disabilityDropDown(
      {void Function(String?)? onChanged,
      String? value,
      Size? size,
      Color? fillColor,
      IconData? iconsData,
      Color? inputColors,
      title}) {
    return buildParentCard(
      fillColor: fillColor != null ? fillColor : null,
      size: size,
      child: ReusableDropdown<String>(
        iconsData: iconsData!,
        inputColors: null,
        fillColor: fillColor,
        labelText: title ?? 'Disability',
        items: disabilityClusters,
        value: value,
        onChanged: onChanged!,
      ),
    );
  }

  Widget valueablesDropDown(
      {void Function(String?)? onChanged,
      String? value,
      Size? size,
      Color? fillColor,
      IconData? iconsData,
      Color? inputColors}) {
    return buildParentCard(
      fillColor: fillColor != null ? fillColor : null,
      size: size,
      child: ReusableDropdown<String>(
        iconsData: iconsData!,
        inputColors: null,
        fillColor: fillColor,
        labelText: 'Valuables',
        items: valuableTypes,
        value: value,
        onChanged: onChanged!,
      ),
    );
  }

  Widget healthStatusDropDown(
      {void Function(String?)? onChanged,
      String? value,
      Size? size,
      Color? fillColor,
      IconData? iconsData,
      Color? inputColors,
      title}) {
    return buildParentCard(
      fillColor: fillColor != null ? fillColor : null,
      size: size,
      child: ReusableDropdown<String>(
        iconsData: iconsData!,
        inputColors: null,
        fillColor: fillColor,
        labelText: title ?? 'Do you have Any Medical Issue?',
        items: check,
        value: value,
        onChanged: onChanged!,
      ),
    );
  }

  Widget buildParentCard({
    child,
    Color? fillColor,
    size,
    padding,
  }) =>
      Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(
            left: defaultPadding,
            right: defaultPadding,
            top: 10,
          ),
          height:
              Responsive.isDesktop(context) ? size.height / 15 : size.width / 8,
          width: size.width / 1.22,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: fillColor ?? Colors.black.withOpacity(.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: child);

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
          readOnly: false,
          onTap: () async {
            // DateTime? pickedDate = await showDatePicker(
            //     context: context,
            //     initialDate: DateTime.now(),
            //     firstDate: DateTime(1900),
            //     lastDate: DateTime.now());
            // dob.value.text = dateWithoutTIme.format(pickedDate!);
            // picked.value = (pickedDate);
          },
          fieldsType: TextInputType.text,
          hint: 'YYYY-MM-DD',
          suffix: const Icon(Icons.calendar_view_day_rounded),
          controller: dob.value,
        ),
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
        Padding(
            padding: const EdgeInsets.only(left: 12.0, right: 12.0, top: 10),
            child: Container(
                decoration: BoxDecoration(
                    color: cardColors,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                        style: BorderStyle.solid,
                        color: kblackColor,
                        width: 1.2)),
                height: 50,
                width: double.infinity,
                child: ReusableDropdown(
                    labelFontSize: 20,
                    inputColors: kSecondaryColor,
                    labelText: 'Medical Conditions',
                    items: check,
                    value: val,
                    onChanged: (_) {},
                    iconsData: Icons.abc))),
        // CustomTextField(
        //     fieldsType: TextInputType.text,
        //     hint: 'Disability Cluster',
        //     suffix: const Icon(Icons.hearing_disabled_outlined),
        //     controller: disabilityCluster),
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
                    dob: DateTime.parse(dob.value.text),
                    disability: '',
                    disabilityTypes: [],
                    medicalCondiiton: '',
                    valuables: [],
                    groups: [],
                    present: true,
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
