
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../logic/bloc/admin_management/admin_managemet_bloc.dart';
import '../../../../../../models/auth_code_model.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../models/user_model.dart';
import '../../../../../widgets/CustomViewTextField.dart';
import '../../../../../widgets/costum_text_field.dart';
import '../../../../../widgets/custom_submit_btn.dart';
import '../../../../../widgets/dialogue_forms.dart';
import '../../../../../widgets/popupmenu_widget.dart';
import '../../../../../widgets/verify_action_dialogue.dart';

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
  final oldauthCodeController = TextEditingController();
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

  showOptions({icon, AdminModel? admin, AdminCodesModel? codes}) {
    return PopupMenu(
      items: [
        PopupMenuItemModel(
            title: 'Change Viewer Code',
            onTap: () {
              viewAuthCodeData(
                  admin: admin,
                  title: 'Change Viewer Code',
                  action: () {
                    viewAuthCodeData(
                        admin: admin,
                        title: 'Change Viewer Code',
                        action: () {
                          BlocProvider.of<AdminManagemetBloc>(context).add(
                              AlterCodeEvent(
                                  oldCode: oldauthCodeController.text,
                                  newCode: authCodeController.text,
                                  field: 'authCode',
                                  adminCodeField: 'viewerCode'));
                          BlocProvider.of<AdminManagemetBloc>(context)
                              .add(const GetCodeEvent());
                        });
                  });
            }),
        PopupMenuItemModel(
            title: 'Change Admin Code',
            onTap: () {
              viewAuthCodeData(
                  admin: admin,
                  title: 'Change Admin Code',
                  action: () {
                    viewAuthCodeData(
                        admin: admin,
                        title: 'Change Admin Code',
                        action: () {
                          BlocProvider.of<AdminManagemetBloc>(context).add(
                              AlterCodeEvent(
                                  oldCode: oldauthCodeController.text,
                                  newCode: authCodeController.text,
                                  field: 'authCode',
                                  adminCodeField: 'adminCode'));
                        });
                  });
            }),
        PopupMenuItemModel(
            title: 'Change Super Admin Code',
            onTap: () {
              viewAuthCodeData(
                  admin: admin,
                  title: 'Change Super Admin Code',
                  action: () {
                    BlocProvider.of<AdminManagemetBloc>(context).add(
                        AlterCodeEvent(
                            oldCode: oldauthCodeController.text,
                            newCode: authCodeController.text,
                            field: 'authCode',
                            adminCodeField: 'superAdminCode'));
                  });
            })
      ],
      icon: icon,
    );
  }

  ///[IF ADMIN CODE IS CHANGED TO A HIGHER ACCESS CODE USER ACTIONS  ARE UOPDATED]
  viewAuthCodeData({title, AdminModel? admin, action}) {
    buildCenterFormField(
        title: title,
        context: context,
        widgetsList: [
          CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'Old AuthCode',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: oldauthCodeController,
          ),
          CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'New Auth Code',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: authCodeController,
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
          action;
          BlocProvider.of<AdminManagemetBloc>(context)
              .add(const GetCodeEvent());
        });
  }
}
