import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../logic/bloc/group_management_bloc/group_management_bloc.dart';
import '../../../logic/db/db.dart';

import '../../../config/date_time_formats.dart';
import '../../../config/theme.dart';
import '../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../../../models/atendee_model.dart';
import '../../../models/group_model.dart';
import '../../../models/non_admin_staff.dart';
import '../../../models/teachings_model.dart';
import '../../../models/user_model.dart';
import '../CustomViewTextField.dart';
import '../costum_text_field.dart';
import '../custom_submit_btn.dart';
import '../data_card.dart';
import '../dialogue_forms.dart';

class RegistrationForms extends FormWidget {
  RegistrationForms({required this.context});

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
              BlocProvider.of<RegistrationBloc>(context).add(CreateNonAdminEvent(
                  authCodeCtlNonAdminReg.text,
                  nonAdminModel: NonAdminModel(
                      id: '${BlocProvider.of<DashBoardBloc>(context).auth.currentUser?.uid}',
                      lastName: lastnameCtlNonAdminReg.text,
                      email: emailCtlNonAdminReg.text,
                      phoneNumber: phoneCtlNonAdminReg.text,
                      gender: genderCtlNonAdminReg.text,
                      dept: deptCtlNonAdminReg.text,
                      role: roleCtlNonAdminReg.text,
                      authCode: authCodeCtlNonAdminReg.text,
                      createdBy: createdBy.text,
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
        log('message1111');
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
        log('message');
      },
      onSubmitText: 'Create',
      alertType: AlertType.oneBtn,
      onSubmit2: () {},
      color1: Colors.green,
      btNtype1: ButtonType.long,
    );
  }

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

  viewSelectedNonAdminStaffData({title, required NonAdminModel nonAdmin}) {
    buildCenterFormField(
        title: title,
        context: context,
        widgetsList: [
          CustomViewTextField(
            initialValue: nonAdmin.firstName,
            fieldsType: TextInputType.text,
            hint: 'First Name',
            suffix: const Icon(Icons.person),
          ),
          CustomViewTextField(
            initialValue: nonAdmin.lastName,
            fieldsType: TextInputType.text,
            hint: 'Last Name',
            suffix: const Icon(Icons.person),
          ),
          CustomViewTextField(
            initialValue: nonAdmin.phoneNumber,
            fieldsType: TextInputType.phone,
            hint: 'Phone Number',
            suffix: const Icon(Icons.phone),
          ),
          CustomViewTextField(
            initialValue: nonAdmin.email,
            fieldsType: TextInputType.text,
            hint: 'Email ',
            suffix: const Icon(Icons.mail),
          ),
          CustomViewTextField(
            initialValue: nonAdmin.gender,
            fieldsType: TextInputType.text,
            hint: 'Gender',
            suffix: const Icon(Icons.male),
          ),
          CustomViewTextField(
            initialValue: nonAdmin.dept,
            fieldsType: TextInputType.text,
            hint: 'Department',
            suffix: const Icon(Icons.people),
          ),
          CustomViewTextField(
            initialValue: nonAdmin.role,
            fieldsType: TextInputType.text,
            hint: 'Role',
            suffix: const Icon(Icons.settings_accessibility_rounded),
          ),
          CustomViewTextField(
            initialValue: nonAdmin.createdBy,
            fieldsType: TextInputType.text,
            hint: 'Created by?',
            suffix: const Icon(Icons.payment_rounded),
          ),
          CustomViewTextField(
            initialValue: nonAdmin.authCode,
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
              title: nonAdmin.firstName,
              text:
                  'Do you want to proceed to edit ${nonAdmin.firstName} ${nonAdmin.lastName}?');
        });
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
  }

  viewGroupData(
      {title,
      GroupModel? presentGroupModel,
      String? presenttGroupId,
      required List<AttendeeModel> attendees}) {
    buildCenterFormField(
        title: title,
        context: context,
        widgetsList: [
          CustomViewTextField(
            initialValue: presentGroupModel?.name,
            fieldsType: TextInputType.text,
            hint: 'Group Name',
            suffix: const Icon(Icons.group_rounded),
          ),
          CustomViewTextField(
            initialValue: presentGroupModel?.description,
            fieldsType: TextInputType.text,
            hint: 'Group Description',
            suffix: const Icon(Icons.people_alt_rounded),
          ),
          CustomViewTextField(
            initialValue: presenttGroupId,
            fieldsType: TextInputType.text,
            hint: 'Group Id',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
          ),
          CustomViewTextField(
            initialValue: presentGroupModel!.facilitator,
            fieldsType: TextInputType.text,
            hint: 'Facilitator',
            suffix: const Icon(Icons.admin_panel_settings_rounded),
          ),
          CustomViewTextField(
            initialValue: '${presentGroupModel.groupMembers.length} members',
            fieldsType: TextInputType.text,
            hint: 'Groups Members Count',
            suffix: const Icon(Icons.numbers),
          ),
          const SizedBox(
            height: 15,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Members Grid',
                      style: GoogleFonts.gochiHand(
                          fontWeight: FontWeight.w600,
                          color: kSecondaryColor,
                          fontSize: 15),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton.icon(
                        onPressed: () {
                          buildselectMembers(
                              title: 'Add Members',
                              id: presenttGroupId,
                              attendees: attendees);
                        },
                        icon: const Icon(Icons.person_add_alt_1_rounded),
                        label: const Text('add member'),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              presentGroupModel.groupMembers.length.isEqual(0)
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(
                          top: kdefaultPadding - 6,
                          bottom: kdefaultPadding - 6),
                      child: Container(
                        clipBehavior: Clip.hardEdge,
                        height: presentGroupModel.groupMembers.length.isEqual(1)
                            ? 250
                            : (160 *
                                (presentGroupModel.groupMembers.length - 1)),
                        width: 485,
                        decoration: BoxDecoration(
                            color: cardColors,
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: kdefaultPadding, right: kdefaultPadding),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: presentGroupModel.groupMembers.length,
                              itemBuilder: (itemBuilder, i) => TransactionCard(
                                    onSlideToLeft: (newcontext) {},
                                    data: presentGroupModel.groupMembers[i],
                                    onTap: () {
                                      var data =
                                          presentGroupModel.groupMembers[i];
                                      viewSelectedAttendeeData(
                                          title:
                                              '${data.firstName} ${data.lastName}',
                                          attendee: presentGroupModel
                                              .groupMembers[i]);
                                    },
                                    presenttGroupId: presenttGroupId!,
                                  )),
                        ),
                      ),
                    ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
        onSubmit: () {
          Navigator.of(context).pop();
        },
        btNtype1: ButtonType.fill,
        color1: (Colors.green),
        onSubmitText: 'Done',
        onSubmitText2: 'Edit Group Data',
        color2: (Colors.red),
        btNtype2: ButtonType.fill,
        alertType: AlertType.twoBtns,
        onSubmit2: () {
          verifyAction(
              title: title,
              text: 'Do you want to proceed to edit this GROUP DATA?');
        });
  }

  buildselectMembers({title, id, required List<AttendeeModel> attendees}) {
    buildBottomFormField(
        context: context,
        widgetsList: [
          BlocBuilder<DashBoardBloc, DashBoardState>(builder: (context, state) {
            if (state is DashBoardFetched) {
              return ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: state.attendeeModel.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(
                        left: kdefaultPadding, right: kdefaultPadding),
                    child: TransactionCard(
                      data: state.attendeeModel[index],
                      onTap: () {
                        BlocProvider.of<GroupManagementBloc>(context).add(
                            AddTOGroupEvent(
                                groupId: id, userId: attendees[index]));
                      },
                      presenttGroupId: id,
                    ),
                  );
                },
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          })
        ],
        title: title);
  }
}
