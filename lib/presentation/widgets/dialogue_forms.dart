import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../config/theme.dart';
import 'custom_submit_btn.dart';

///[DETERMINE THE DESIGN FORMAT BY THE AMOUNT OF BUTTON YOU ALLOW]
enum AlertType { oneBtn, twoBtns }

class FormWidget {
  Future<dynamic> buildBottomFormField(
      {required BuildContext context,
      required List<Widget> widgetsList,
      required String title,}) {
        
    List<Widget> columnChilren = [];
    columnChilren.add(Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Text(
        '$title Registration',
        style: GoogleFonts.gochiHand(
            color: kSecondaryColor, fontSize: 43, fontWeight: FontWeight.w600),
        textAlign: TextAlign.center,
      ),
    ));
    columnChilren.addAll(widgetsList);
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        isDismissible: true,
        // enableDrag: true,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (builder) {
          return StatefulBuilder(builder: (context, putState) {
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
          });
        });
  }

  Future<dynamic> buildCenterFormField({
    required String title,
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

    return showDialog(
      barrierDismissible: true,
      barrierColor: Colors.black12,
      context: context,
      builder: (builder) => AlertDialog(
        actionsAlignment: MainAxisAlignment.center,
        insetPadding:
            const EdgeInsets.only(left: 2, right: 2, top: 10, bottom: 10),
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0))),
        titlePadding: const EdgeInsets.only(top: 20),
        contentPadding: const EdgeInsets.all(0),
        scrollable: true,
        titleTextStyle: GoogleFonts.gochiHand(
            color: kSecondaryColor, fontSize: 43, fontWeight: FontWeight.w600),
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        clipBehavior: Clip.antiAlias,
        backgroundColor: bgColor,
        actions: getbtn(alertType),
        content: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: (columnChilren),
          ),
        ),
      ),
    );
  }
}
