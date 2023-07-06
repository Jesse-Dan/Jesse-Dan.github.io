import 'package:alert_system/alert_overlay_plugin.dart';
import 'package:alert_system/systems/overlay_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';
import 'package:tyldc_finaalisima/config/overlay_config/overlay_service.dart';
import '../../config/theme.dart';
import 'custom_submit_btn.dart';

///[DETERMINE THE DESIGN FORMAT BY THE AMOUNT OF BUTTON YOU ALLOW]
enum AlertType { oneBtn, twoBtns }

class FormWidget extends OverlayManager {
  Overlayer buildBottomFormField({
    required BuildContext context,
    required List<Widget> widgetsList,
    required String title,
  }) {
    List<Widget> columnChilren = [];
    columnChilren.add(Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: Responsive.isDesktop(context)
              ? CrossAxisAlignment.center
              : CrossAxisAlignment.start,
          children: [
            Text(
              Responsive.isDesktop(context)
                  ? '$title Registration'
                  : '$title \nRegistration',
              style: GoogleFonts.gochiHand(
                  color: kSecondaryColor,
                  fontSize: 43,
                  fontWeight: FontWeight.w600),
              textAlign: TextAlign.left,
            ),
            IconButton(
                onPressed: () {
                  OverlayService.closeAlert();
                },
                icon: Icon(
                  Icons.close_rounded,
                  size: 30,
                  color: kSecondaryColor,
                ))
          ],
        ),
      ),
    ));
    columnChilren.addAll(widgetsList);
    return Overlayer.showOverlay(
        child: BottomModal(columnChilren: columnChilren));
  }

  void buildCenterFormField({
    Color? mainBgColor,
    required String title,
    Color? titleColor,
    required BuildContext context,
    required List<Widget> widgetsList,
    String onSubmitText = 'Done',
    required void Function() onSubmit,
    required AlertType alertType,
    String onSubmitText2 = 'Done',
    required void Function() onSubmit2,
    Color? color1,
    Color? color2,
    ButtonType? btNtype1,
    ButtonType? btNtype2,
  }) {
    List<Widget> columnChilren = [];
    columnChilren.addAll(widgetsList);

    List<Widget> getbtn(AlertType btnType) {
      if (alertType == AlertType.oneBtn) {
        return [
          CustomButton(
            color: color1,
            btnText: onSubmitText,
            onTap: onSubmit,
            btNtype: btNtype1 ?? ButtonType.long,
          )
        ];
      } else {
        return [
          CustomButton(
            btNtype: btNtype1 ?? ButtonType.long,
            btnText: onSubmitText,
            onTap: onSubmit,
            color: color1,
          ),
          CustomButton(
              btNtype: btNtype2 ?? ButtonType.long,
              btnText: onSubmitText2,
              onTap: onSubmit2,
              color: color2)
        ];
      }
    }

    return OverlayManager.show(
        child: Material(
      color: Colors.transparent,
      child: StatefulBuilder(builder: (context, putState) {
        return AlertDialog(
          actionsAlignment: MainAxisAlignment.center,
          insetPadding:
              const EdgeInsets.only(left: 2, right: 2, top: 10, bottom: 10),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30.0))),
          titlePadding: const EdgeInsets.only(top: 20),
          contentPadding: const EdgeInsets.all(0),
          scrollable: true,
          titleTextStyle: GoogleFonts.gochiHand(
              color: titleColor ?? kSecondaryColor,
              fontSize: 43,
              fontWeight: FontWeight.w600),
          title: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  textAlign: TextAlign.left,
                ),
                IconButton(
                    onPressed: () {
                      OverlayService.closeAlert();
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      size: 20,
                      color: kSecondaryColor,
                    ))
              ],
            ),
          ),
          clipBehavior: Clip.antiAlias,
          backgroundColor: mainBgColor ?? bgColor,
          actions: getbtn(alertType),
          content: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: (columnChilren),
            ),
          ),
        );
      }),
    ));
  }
}

class BottomModal extends StatelessWidget {
  const BottomModal({
    super.key,
    required this.columnChilren,
  });

  final List<Widget> columnChilren;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: StatefulBuilder(builder: (context, putState) {
        return SizedBox(
            height: MediaQuery.of(context).size.height / 1.1,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: bgColor,
                  ),
                  // height: MediaQuery.of(context).size.height / 0.5,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: (columnChilren),
                      ),
                    ),
                  ),
                ),
              ),
            ));
      }),
    );
  }
}
