import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';
import 'package:tyldc_finaalisima/logic/bloc/auth_bloc/authentiction_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/auth_bloc/authentiction_event.dart';
import 'package:tyldc_finaalisima/presentation/widgets/index.dart';

import '../../../../config/theme.dart';
import '../../../widgets/dialogue_forms.dart';

class AuthViewComponents extends FormWidget {
  AuthViewComponents({required this.context});
  final BuildContext context;
  final mobileNumberCtl = TextEditingController();
  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail, Size size,
      {required TextEditingController controller,
      TextInputType? type,
      limit,
      inputColors,
      fillColor}) {
    return Container(
      clipBehavior: Clip.hardEdge,
      margin: const EdgeInsets.only(
        left: defaultPadding,
        right: defaultPadding,
        top: 10,
      ),
      height: Responsive.isDesktop(context) ? size.height / 10 : size.width / 8,
      width: size.width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: fillColor == null ? Colors.black.withOpacity(.05) : fillColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
        maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
        maxLength: limit,
        buildCounter: (context,
                {required int currentLength,
                required bool isFocused,
                required int? maxLength}) =>
            null,
        controller: controller,
        style: TextStyle(color: inputColors ?? Colors.black.withOpacity(.8)),
        obscureText: isPassword,
        keyboardType:
            isEmail ? TextInputType.emailAddress : type ?? TextInputType.text,
        decoration: InputDecoration(
          fillColor: fillColor,
          filled: fillColor == null ? false : true,
          prefixIcon: Icon(
            icon,
            color: inputColors ?? Colors.black.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
              fontSize: 14, color: inputColors ?? Colors.black.withOpacity(.5)),
        ),
      ),
    );
  }

  Widget component2(
      String string, double width, VoidCallback voidCallback, Size size) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: voidCallback,
      child: Container(
        margin:
            const EdgeInsets.only(left: defaultPadding, right: defaultPadding),
        height:
            Responsive.isDesktop(context) ? size.height / 10 : size.width / 8,
        width: Responsive.isDesktop(context)
            ? size.width / (width + 4)
            : size.width / width,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: const Color(0xff4796ff),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(
          string,
          style:
              const TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  updatePhoneNumber() {
    buildCenterFormField(
        mainBgColor: kSecondaryColor,
        title: 'Update Number',
        titleColor: Colors.black,
        context: context,
        widgetsList: [
          component1(
              Icons.phone, '9012345678', false, true, const Size(500, 500),
              controller: mobileNumberCtl,
              type: TextInputType.phone,
              fillColor: cardColors,
              inputColors: kSecondaryColor,
              limit: 10),
        ],
        onSubmit: () {
          Navigator.of(context).pop();
        },
        alertType: AlertType.twoBtns,
        btNtype1: ButtonType.fill,
        btNtype2: ButtonType.fill,
        color1: Colors.red,
        color2: Colors.green,
        onSubmit2: () {
          BlocProvider.of<AuthenticationBloc>(context)
              .add(UpdateNumberEvent(context, mobileNumberCtl.text));
        },
        onSubmitText: 'Cancel',
        onSubmitText2: 'Update');
  }
}

class MyBehavior extends ScrollBehavior {
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
