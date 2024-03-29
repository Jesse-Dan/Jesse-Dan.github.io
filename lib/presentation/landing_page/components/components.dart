import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/constants/responsive.dart';
import '../../../../config/overlay_config/overlay_service.dart';
import '../../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../../config/theme.dart';
import '../../widgets/custom_submit_btn.dart';
import '../../widgets/dialogue_forms.dart';
import '../../widgets/dropdown_widget.dart';

enum InputType { dropDown, text, radioInput }

class AuthViewComponents extends FormWidget {
  AuthViewComponents({required this.context});
  final BuildContext context;
  final mobileNumberCtl = TextEditingController();

  /// Gender
  final List<String> genderType = ['Male', 'Female'];

  Widget genderDropDown(
      {void Function(String?)? onChanged,
      String? value,
      Size? size,
      Color? fillColor,
      IconData? iconsData,
      Color? inputColors}) {
    return buildParentCard(
      fillColor: fillColor != null ? fillColor : null,
      size: size,
      child: ReusableDropdown<String>(
        iconsData: iconsData!,
        inputColors: null,
        fillColor: fillColor,
        labelText: 'Gender',
        items: genderType,
        value: value,
        onChanged: onChanged!,
      ),
    );
  }

  /// Dept
  final List<String> deptType = ['Male', 'Female'];

  Widget deptDropDown(
      {void Function(String?)? onChanged,
      String? value,
      Size? size,
      Color? fillColor,
      IconData? iconsData,
      Color? inputColors,
      List<String>? list}) {
    return buildParentCard(
        fillColor: fillColor != null ? fillColor : null,
        size: size,
        child: ReusableDropdown<String>(
          iconsData: iconsData!,
          inputColors: null,
          fillColor: fillColor,
          labelText: 'Department',
          items: list ?? [],
          value: value,
          onChanged: onChanged!,
        ));
  }

  Widget component1(
      IconData icon, String hintText, bool isPassword, bool isEmail, Size size,
      {required TextEditingController controller,
      TextInputType? type,
      int? limit,
      Color? inputColors,
      void Function()? onTapSuffixIcon,
      IconData? suffixIcon,
      InputType? inputType,
      Color? fillColor}) {
    return buildParentCard(
      fillColor: fillColor != null ? fillColor : null,
      size: size,
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
          // suffixIconConstraints: BoxConstraints.loose(size),
          suffixIcon: InkWell(
            onTap: onTapSuffixIcon,
            child: Icon(
              suffixIcon,
              color: isPassword ? kgreyColor : Colors.black,
            ),
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
          OverlayService.closeAlert();
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

  Widget buildParentCard({
    child,
    Color? fillColor,
    size,
    padding,
  }) =>
      Container(
          clipBehavior: Clip.hardEdge,
          margin: const EdgeInsets.only(
            left: defaultPadding,
            right: defaultPadding,
            top: 10,
          ),
          height:
              Responsive.isDesktop(context) ? size.height / 15 : size.width / 8,
          width: size.width / 1.22,
          alignment: Alignment.center,
          padding: EdgeInsets.only(right: size.width / 30),
          decoration: BoxDecoration(
            color: fillColor ?? Colors.black.withOpacity(.05),
            borderRadius: BorderRadius.circular(10),
          ),
          child: child);

  Widget buildChip(
      {required String label,
      required Color color,
      void Function()? onDelete}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Chip(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        onDeleted: onDelete,
        deleteIcon: Icon(
          Icons.clear,
          size: 10,
          color: primaryColor,
        ),
        labelPadding: EdgeInsets.all(2.0),
        avatar: CircleAvatar(
          backgroundColor: Colors.white70,
          child: Text(
            label[0],
            style: TextStyle(
              color: primaryColor,
            ),
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: color,
        elevation: 6.0,
        shadowColor: Colors.grey[60],
        padding: EdgeInsets.all(8.0),
      ),
    );
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
