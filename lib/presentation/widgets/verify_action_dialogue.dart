import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../config/theme.dart';
import 'custom_submit_btn.dart';
import 'dialogue_forms.dart';

verifyAction({title, text, action, context}) {
  FormWidget().buildCenterFormField(
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

Widget getBody(text) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(text,
        style: GoogleFonts.gochiHand(
            color: kSecondaryColor,
             fontSize: 17, fontWeight: FontWeight.w500)),
  );
}
