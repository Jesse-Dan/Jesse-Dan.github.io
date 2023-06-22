// ignore_for_file: unnecessary_statements, non_constant_identifier_names, library_private_types_in_public_api, avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pinput/pinput.dart';
import 'package:tyldc_finaalisima/logic/bloc/admin_management/admin_managemet_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../config/theme.dart';
import '../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../logic/bloc/auth_bloc/authentiction_state.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';
import 'package:tyldc_finaalisima/presentation/screens/auth_views/components/components.dart';

import '../../widgets/alertify.dart';
import 'login.dart';

class PhoneVerificationScreen extends StatefulWidget {
  static const routeName = '/signup.phone.verification';
  const PhoneVerificationScreen({Key? key}) : super(key: key);

  @override
  _PhoneVerificationScreenState createState() =>
      _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;
  final TextEditingController otpCtl = TextEditingController();
  @override
  void initState() {
    BlocProvider.of<AdminManagemetBloc>(context).add(const GetCodeEvent());
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _opacity = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )..addListener(() {
        setState(() {});
      });

    _transform = Tween<double>(begin: 2, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    );

    _controller.forward();
    super.initState();
  }

  RichText toggleCreateAccount() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400, fontSize: 12, color: cardColors),
              text: 'wrong input | consider an update '),
          TextSpan(
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: primaryColor),
              text: 'Update mobile number',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  AuthViewComponents(context: context).updatePhoneNumber();
                })
        ]));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        borderRadius: BorderRadius.circular(20),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: const Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    otpField() {
      return Pinput(
        controller: otpCtl,
        defaultPinTheme: defaultPinTheme,
        focusedPinTheme: focusedPinTheme,
        submittedPinTheme: submittedPinTheme,
        length: 6,
        pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
        showCursor: true,
        onCompleted: (pin) => BlocProvider.of<AuthenticationBloc>(context).add(
          VerifyOtpAndLoginInEvent(int.parse(pin), context: context),
        ),
      );
    }

    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthenticationBloc, AuthentictionState>(
      listener: (context, state) {
        if (state is OTPSentSuccesful) {
          Navigator.pop(context);
        }
        if (state is AuthentictionLoading) {
          showDialog(
              context: context,
              builder: ((context) =>
                  const Center(child: CircularProgressIndicator())));
        }
        if (state is PhoneAuthentictionSuccesful) {
          Navigator.pushNamedAndRemoveUntil(
              context, SignInScreen.routeName, (_) => false);
        }

        if (state is MobileNumberUpdateSuccessfully) {
          Navigator.pop(context);
          Alertify.success(message: 'Phone Number Updated successfully');
        }
        if (state is AuthentictionFailed) {
          Navigator.pop(context);
          Alertify.error(message: state.error);
        }
        if (state is PhoneAuthentictionUnsucessful) {
          Navigator.pop(context);
          Alertify.error(
              message:
                  'Phone number is invalid, Please contact your admin for futher information');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: SizedBox(
                height: size.height,
                child: Container(
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        cardColors,
                        primaryColor,
                      ],
                    ),
                  ),
                  child: Opacity(
                    opacity: _opacity.value,
                    child: Transform.scale(
                      scale: _transform.value,
                      child: Padding(
                        padding: const EdgeInsets.all(defaultPadding),
                        child: Container(
                          width: Responsive.isDesktop(context)
                              ? size.width / 3
                              : size.width * .9,
                          height: Responsive.isDesktop(context)
                              ? size.width / 2.3
                              : size.width * 1.1,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 90,
                              ),
                            ],
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(height: 25),
                                Text(
                                  textAlign: TextAlign.center,
                                  'TYLDC PORTAL\nCREATE ACCOUNT',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                Text(
                                  textAlign: TextAlign.center,
                                  'An OTP was sent to your Phone number Please enter it here..!',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.black.withOpacity(.5),
                                  ),
                                ),
                                const SizedBox(height: 25),
                                otpField(),
                                const SizedBox(height: 25),
                                // AuthViewComponents(context: context).component2(
                                //   'Verify Otp',
                                //   2.6,
                                //   () {
                                // BlocProvider.of<AuthenticationBloc>(context)
                                //     .add(VerifyOtpAndLoginInEvent(
                                //         int.parse(otpCtl.text),
                                //         context: context));
                                //   },
                                //   size,
                                // ),
                                const SizedBox(height: 20),
                                (toggleCreateAccount()),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
