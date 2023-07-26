import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';
import 'package:tyldc_finaalisima/config/overlay_config/overlay_service.dart';
import '../../../../../../logic/bloc/admin_management/admin_managemet_bloc.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../models/departments_type_model.dart';
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

  final TextEditingController newDeptCtl = TextEditingController();

  /// Create new Dept ctl
  final TextEditingController createNewDeptCtl = TextEditingController();
  final TextEditingController updateDeptCtl = TextEditingController();

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
          OverlayService.closeAlert();
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

  /// CREATE NEW DEPT
  createDepatrment({AdminModel? adminModel}) {
    buildCenterFormField(
        title: 'Create New Department',
        context: context,
        widgetsList: [
          CustomTextField(
            fieldsType: TextInputType.text,
            hint: 'New Department Name',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: createNewDeptCtl,
          ),
        ],
        onSubmit: () {
          OverlayService.closeAlert();
        },
        btNtype1: ButtonType.fill,
        color1: (Colors.green),
        onSubmitText: 'Done',
        onSubmitText2: 'Create New Department',
        color2: (Colors.red),
        btNtype2: ButtonType.fill,
        alertType: AlertType.twoBtns,
        onSubmit2: () {
          BlocProvider.of<AdminManagemetBloc>(context).add(
              CreateNewDeptTypeAdminEvent(
                  dept: Departments(departmentName: createNewDeptCtl.text),
                  performedBy: adminModel!));
          BlocProvider.of<AdminManagemetBloc>(context)
              .add(const GetCodeEvent());
        });
  }

  showDeptOptions(
      {Widget? icon, DepartmentTypes? departments, AdminModel? adminModel}) {
    if (departments == null) return SizedBox.shrink();
    var listOdDept = List.generate(
      departments.departments.length,
      (index) => PopupMenuItemModel(
          title:
              'Change ${departments.departments[index].departmentName} ${Responsive.isMobileORTablet(context) ? 'Dept' : 'Department'} Code',
          onTap: () {
            viewForUpdateDeptData(
                department: departments.departments[index],
                title:
                    'Change ${departments.departments[index].departmentName} ${Responsive.isMobileORTablet(context) ? 'Dept' : 'Department'}Code',
                action: () {
                  /// UPDATE DEPT
                  BlocProvider.of<AdminManagemetBloc>(context).add(
                      UpdateDeptTypeAdminEvent(
                          dept: Departments(departmentName: updateDeptCtl.text),
                          performedBy: adminModel!,
                          oldvalue: departments.departments[index]));

                  BlocProvider.of<AdminManagemetBloc>(context)
                      .add(const GetCodeEvent());
                });
          }),
    );
    return PopupMenu(icon: icon ?? Icon(Icons.abc), items: listOdDept);
  }

  viewDeptData({
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
            hint: 'New Dept',
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

  viewForUpdateDeptData({
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
            hint: 'Update Dept',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
            controller: updateDeptCtl,
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

  showOptions({icon, AdminModel? admin}) {
    List<Map<String, void Function()?>> list = [
      {
        'Viewer': () {
          BlocProvider.of<AdminManagemetBloc>(context).add(AlterCodeEvent(
              oldCode: oldauthCodeController.text,
              context: context,
              newCode: authCodeController.text,
              field: 'authCode',
              adminCodeField: 'viewerCode'));
        }
      },
      {
        'Admin': () {
          BlocProvider.of<AdminManagemetBloc>(context).add(AlterCodeEvent(
              oldCode: oldauthCodeController.text,
              context: context,
              newCode: authCodeController.text,
              field: 'authCode',
              adminCodeField: 'adminCode'));
        }
      },
      {
        'Super Admin': () {
          BlocProvider.of<AdminManagemetBloc>(context).add(AlterCodeEvent(
              context: context,
              oldCode: oldauthCodeController.text,
              newCode: authCodeController.text,
              field: 'authCode',
              adminCodeField: 'superAdminCode'));
        }
      }
    ];
    var listOdDept = List.generate(
      list.length,
      (index) => PopupMenuItemModel(
        title:
            'Change ${list[index].keys.toString().split('(')[1].split(')')[0]} Code',
        onTap: () => viewAuthCodeData()(
          admin: admin,
          title:
              'Change ${list[index]['${list[index].keys.toString().split('(')[1].split(')')[0]}']}',
          action: () {
            log('${list[index]['${list[index].keys.toString().split('(')[1].split(')')[0]}']}');
            list[index][
                '${list[index].keys.toString().split('(')[1].split(')')[0]}']!();
            BlocProvider.of<AdminManagemetBloc>(context)
                .add(const GetCodeEvent());
          },
        ),
      ),
    ).toList();

    return PopupMenu(icon: icon ?? Icon(Icons.abc), items: listOdDept);
  }

  ///[IF ADMIN CODE IS CHANGED TO A HIGHER ACCESS CODE USER ACTIONS  ARE UOPDATED]
  viewAuthCodeData({title, AdminModel? admin, void Function()? action}) {
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
          OverlayService.closeAlert();
        },
        btNtype1: ButtonType.fill,
        color1: (Colors.green),
        onSubmitText: 'Done',
        onSubmitText2: 'Edit Auth Code',
        color2: (Colors.red),
        btNtype2: ButtonType.fill,
        alertType: AlertType.twoBtns,
        onSubmit2: () {
          action!();
          BlocProvider.of<AdminManagemetBloc>(context)
              .add(const GetCodeEvent());
        });
  }
}
