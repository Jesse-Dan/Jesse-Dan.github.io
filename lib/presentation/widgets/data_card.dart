import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/hex_method.dart';
import '../../config/theme.dart';
import '../../logic/bloc/group_management_bloc/group_management_bloc.dart';
import '../../models/atendee_model.dart';
import '../../models/group_model.dart';
import '../screens/app_views/drawer_items/attendees/forms/view_form.dart';

class TransactionCard extends StatefulWidget {
  TransactionCard({
    Key? key,
    this.onSlideToLeft,
    required this.data,
    required this.groupData,
    this.onTap,
    required this.presentGroupId,
  }) : super(key: key);

  final AttendeeModel? data;
  final GroupModel? groupData;
  final void Function(BuildContext)? onSlideToLeft;
  final Function()? onTap;
  final String presentGroupId;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  MaterialColor getColor(type) {
    switch (type.toString().toLowerCase()) {
      case 'male':
        return Colors.deepOrange;
      case 'female':
        return Colors.purple;
      case 'Recovered':
        return Colors.green;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Slidable(
        // Specify a key if the Slidable is dismissible.
        key: const ValueKey(0),

        // The start action pane is the one at the left or the top side.
        startActionPane: ActionPane(
          // A motion is a widget used to control how the pane animates.
          motion: const ScrollMotion(),

          // A pane can dismiss the Slidable.
          dismissible: null,

          // All actions are defined in the children parameter.
          children: [
            // A SlidableAction can have an icon and/or a label.
            SlidableAction(
              onPressed: (_) =>
                  AttendeeViewForms(context: context).verifyAction(
                      text: 'Do you want to proceed to edit this GROUP USER?',
                      title: 'Delete user ${widget.data!.firstName}  ',
                      action: () {
                        BlocProvider.of<GroupManagementBloc>(context).add(
                            RemoveFromGroupEvent(
                                groupModel: widget.groupData!,
                                groupId: widget.presentGroupId,
                                userId: widget.data!));
                      }),
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
            SlidableAction(
              onPressed: (_) {
                AttendeeViewForms(context: context).viewSelectedAttendeeData(
                    attendee: widget.data!,
                    title:
                        '${widget.data!.firstName} ${widget.data!.lastName}');
              },
              backgroundColor: const Color(0xFF21B7CA),
              foregroundColor: Colors.white,
              icon: Icons.more_outlined,
              label: 'more',
            ),
          ],
        ),

        // The end action pane is the one at the right or the bottom side.
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            // SlidableAction(
            //   // An action can be bigger than the others.
            //   flex: 2,
            //   onPressed: (_) {},
            //   backgroundColor: const Color(0xFF7BC043),
            //   foregroundColor: Colors.white,
            //   icon: Icons.archive,
            //   label: 'Archive',
            // ),
            // SlidableAction(
            //   onPressed: (_) {},
            //   backgroundColor: const Color(0xFF0392CF),
            //   foregroundColor: Colors.white,
            //   icon: Icons.save,
            //   label: 'Save',
            // ),
          ],
        ),

        // The child of the Slidable is what the user sees when the
        // component is not dragged.
        child: GestureDetector(
          onTap: widget.onTap ?? () {},
          child: Padding(
              padding:
                  const EdgeInsets.only(left: .0, right: .0, top: 8, bottom: 4),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: ListTile(
                  tileColor: bgColor,
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(7.0))),
                  contentPadding: const EdgeInsets.only(
                      left: 6.0, right: 6.0, top: 0, bottom: 0),
                  leading: SizedBox(
                    // height: 64,width:64,
                    child: Padding(
                      padding: EdgeInsets.all(4.0),
                      child: CircleAvatar(
                        child: Icon(widget.data!.gender.toLowerCase() == 'male'
                            ? Icons.male
                            : Icons.female),
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${widget.data!.firstName} ${widget.data!.middleName} ${widget.data!.lastName}',
                        style: GoogleFonts.dmSans(
                          fontSize: kMidiText,
                          fontWeight: FontWeight.w700,
                          color: kblackColor,
                        ),
                      ),
                      Text(
                        '• ${widget.data!.phoneNo}',
                        style: GoogleFonts.dmSans(
                          fontSize: kSmallText + 1,
                          fontWeight: FontWeight.w600,
                          color: getColor(widget.data!.gender),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ('Address : ${widget.data!.homeAddress}'),
                        style: GoogleFonts.dmSans(
                          fontSize: kSmallText - 1,
                          fontWeight: FontWeight.w400,
                          color: kSecondaryColor,
                        ),
                      ),
                      Text(
                        'Camper: ${widget.data!.wouldCamp.toString().toLowerCase()}',
                        style: GoogleFonts.dmSans(
                          fontSize: kSmallText - 1,
                          fontWeight: FontWeight.w500,
                          color: HexColor('#757575'),
                        ),
                      ),
                    ],
                  ),
                ),
              )),
        ));
  }
}
