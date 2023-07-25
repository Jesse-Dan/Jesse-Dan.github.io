import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../../config/date_time_formats.dart';
import '../../../../../../config/overlay_config/overlay_service.dart';
import '../../../../../../config/theme.dart';
import '../../../../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../../../../../../logic/bloc/group_management_bloc/group_management_bloc.dart';
import '../../../../../../config/bloc_controller.dart';
import '../../../../../../models/atendee_model.dart';
import '../../../../../../models/group_model.dart';
import '../../../../../widgets/CustomViewTextField.dart';
import '../../../../../widgets/costum_text_field.dart';
import '../../../../../widgets/custom_submit_btn.dart';
import '../../../../../widgets/data_card.dart';
import '../../../../../widgets/dialogue_forms.dart';
import '../../../../../widgets/verify_action_dialogue.dart';

class GroupsViewForms extends FormWidget {
  final BuildContext context;
  GroupsViewForms({required this.context});

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
            initialValue: presentGroupModel?.id,
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
                              attendees: attendees,
                              groups: presentGroupModel);
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
                  : StatefulBuilder(builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: kdefaultPadding - 6,
                            bottom: kdefaultPadding - 6),
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: presentGroupModel.groupMembers.length
                                  .isEqual(1)
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
                                itemCount:
                                    presentGroupModel.groupMembers.length,
                                itemBuilder: (itemBuilder, i) =>
                                    TransactionCard(
                                      groupData: presentGroupModel,
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
                                      presentGroupId: presenttGroupId!,
                                    )),
                          ),
                        ),
                      );
                    }),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
        ],
        onSubmit: () {
          OverlayService.closeAlert();
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
              context: context,
              title: title,
              text: 'Do you want to proceed to edit this GROUP DATA?');
        });
  }

  buildselectMembers(
      {title,
      id,
      required List<AttendeeModel> attendees,
      required GroupModel groups}) {
    buildBottomFormField(
      context: context,
      widgetsList: [
        BlocConsumer<DashBoardBloc, DashBoardState>(listener: (context, state) {
          updateSessionState(state: state, context: context);
          updateLoadingBlocState(state: state, context: context);
          updatetSuccessBlocState(state: state, context: context);
          updateFailedBlocState(state: state, context: context);
        }, builder: (context, state) {
          bool fetched = state is DashBoardFetched;
          List<AttendeeModel?> search = [];
          TextEditingController searchController = TextEditingController();

          searchVal(val) {
            search.clear();
            search.addAll(attendees.where((element) =>
                element.toString().toLowerCase().contains(val) ||
                element.toString().toUpperCase().contains(val)));
            log('input: $val');
            log('data: $search');
            log('data length: ${search.length}');
          }

          return Column(
            children: [
              Padding(
                  padding: const EdgeInsets.only(
                      left: 8.0, right: 8.0, top: 16, bottom: 6),
                  child: CustomTextField(
                    hint: 'Search by name, camper, id, gender...',
                    suffix: const Icon(Icons.search),
                    controller: searchController,
                    onChanged: (val) => searchVal(searchController.text),
                    // onEditingComplete: () =>
                    //     searchVal(_searchController.text),
                  )),
              (fetched)
                  ? (search.isNotEmpty)
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: search.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: kdefaultPadding,
                                  right: kdefaultPadding),
                              child: TransactionCard(
                                groupData: groups,
                                data: search[index],
                                onTap: () {
                                  BlocProvider.of<GroupManagementBloc>(context)
                                      .add(AddTOGroupEvent(
                                          groupModel: groups,
                                          groupId: id,
                                          attendees: search[index]!));
                                },
                                presentGroupId: id,
                              ),
                            );
                          })
                      : ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: attendees.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(
                                  left: kdefaultPadding,
                                  right: kdefaultPadding),
                              child: TransactionCard(
                                groupData: groups,
                                data: attendees[index],
                                onTap: () {
                                  BlocProvider.of<GroupManagementBloc>(context)
                                      .add(AddTOGroupEvent(
                                          groupModel: groups,
                                          groupId: id,
                                          attendees: attendees[index]));
                                },
                                presentGroupId: id,
                              ),
                            );
                          })
                  : const SizedBox.shrink()
            ],
          );
        })
      ],
      title: title,
    );
  }

  viewSelectedAttendeeData({title, required AttendeeModel attendee}) {
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
              title: attendee.firstName,
              text:
                  'Do you want to proceed to edit ${attendee.firstName} ${attendee.lastName}?');
        });
  }
}
