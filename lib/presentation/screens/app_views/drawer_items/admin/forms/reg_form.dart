import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../models/user_model.dart';
import '../../../../../widgets/CustomViewTextField.dart';
import '../../../../../widgets/custom_submit_btn.dart';
import '../../../../../widgets/dialogue_forms.dart';

class AdminsRegistrationForms extends FormWidget {
  AdminsRegistrationForms({required this.context});

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
  viewSelectedAdminStaffData({title, required AdminModel admin}) {
    buildCenterFormField(
        title: title,
        context: context,
        widgetsList: [
          Center(
              child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(admin.imageUrl, scale: 10))),
          CustomViewTextField(
            initialValue: admin.firstName,
            fieldsType: TextInputType.text,
            hint: 'First Name',
            suffix: const Icon(Icons.person),
          ),
          CustomViewTextField(
            initialValue: admin.lastName,
            fieldsType: TextInputType.text,
            hint: 'Last Name',
            suffix: const Icon(Icons.person),
          ),
          CustomViewTextField(
            initialValue: admin.phoneNumber,
            fieldsType: TextInputType.phone,
            hint: 'Phone Number',
            suffix: const Icon(Icons.phone),
          ),
          CustomViewTextField(
            initialValue: admin.email,
            fieldsType: TextInputType.text,
            hint: 'Email ',
            suffix: const Icon(Icons.mail),
          ),
          CustomViewTextField(
            initialValue: admin.gender,
            fieldsType: TextInputType.text,
            hint: 'Gender',
            suffix: const Icon(Icons.male),
          ),
          CustomViewTextField(
            initialValue: admin.dept,
            fieldsType: TextInputType.text,
            hint: 'Department',
            suffix: const Icon(Icons.people),
          ),
          CustomViewTextField(
            initialValue: admin.role,
            fieldsType: TextInputType.text,
            hint: 'Role',
            suffix: const Icon(Icons.settings_accessibility_rounded),
          ),
          CustomViewTextField(
            initialValue: admin.imageUrl,
            fieldsType: TextInputType.text,
            hint: 'Image URL',
            suffix: const Icon(Icons.image),
          ),
          CustomViewTextField(
            initialValue: admin.authCode,
            fieldsType: TextInputType.text,
            obscureText: true,
            hint: 'Auth Code',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
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
              title: admin.firstName,
              text:
                  'Do you want to proceed to edit ${admin.firstName} ${admin.lastName}?');
        });
  }

  ///[IF ADMIN CODE IS CHANGED TO A HIGHER ACCESS CODE USER ACTIONS  ARE UOPDATED]
  viewAuthCodeData({title, AdminModel? admin}) {
    buildCenterFormField(
        title: title,
        context: context,
        widgetsList: [
          CustomViewTextField(
            initialValue: admin?.authCode,
            fieldsType: TextInputType.text,
            hint: 'Old AuthCode',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
          ),
          const CustomViewTextField(
            initialValue: '',
            fieldsType: TextInputType.text,
            hint: 'New Auth Code',
            suffix: Icon(Icons.admin_panel_settings_rounded),
          ),
        ],
        onSubmit: () {
          Navigator.of(context).pop();
        },
        btNtype1: ButtonType.fill,
        color1: (Colors.green),
        onSubmitText: 'Done',
        onSubmitText2: 'Edit Auth Code',
        color2: (Colors.red),
        btNtype2: ButtonType.fill,
        alertType: AlertType.twoBtns,
        onSubmit2: () {
          verifyAction(
              title: title,
              text: 'Do you want to proceed to edit the ADMIN AUTH CODE?');
        });
  }}
