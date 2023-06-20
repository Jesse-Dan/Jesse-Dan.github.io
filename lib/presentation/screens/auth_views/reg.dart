// ignore_for_file: unnecessary_statements, non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/config/validators.dart';
import 'package:tyldc_finaalisima/logic/bloc/admin_management/admin_managemet_bloc.dart';
import '../../../config/theme.dart';
import '../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../logic/bloc/auth_bloc/authentiction_state.dart';
import '../../../models/user_model.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';
import 'package:tyldc_finaalisima/presentation/screens/auth_views/components/components.dart';

import '../../widgets/alertify.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup.screen';
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;

  final TextEditingController LastnameCtl = TextEditingController();
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController PhoneCtl = TextEditingController();
  final TextEditingController GenderCtl = TextEditingController();
  final TextEditingController DeptCtl = TextEditingController();
  final TextEditingController RoleCtl = TextEditingController();
  final TextEditingController AuthCodeCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();
  final TextEditingController firstNameCtl = TextEditingController();
  final TextEditingController confirmPasswordCtl = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<AdminManagemetBloc>(context).add(GetCodeEvent());
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
              text: 'Already have an account? '),
          TextSpan(
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: primaryColor),
              text: 'Login',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed(SignInScreen.routeName);
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
    Size size = MediaQuery.of(context).size;
    return BlocConsumer<AuthenticationBloc, AuthentictionState>(
      listener: (context, state) {
        if (state is AuthentictionLoading) {
          showDialog(
              context: context,
              builder: ((context) =>
                  const Center(child: CircularProgressIndicator())));
        }
        if (state is AuthentictionSuccesful) {
          Alertify.success(message: 'User Logged in sussecfullyd');
        }
        if (state is AuthentictionFailed) {
          Navigator.pop(context);
          Alertify.error(message: state.error);
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
                                const SizedBox(),
                                AuthViewComponents(context: context).component1(
                                    Icons.account_circle_outlined,
                                    'First Name...',
                                    false,
                                    true,
                                    size,
                                    controller: firstNameCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.account_circle_outlined,
                                    'Last Name...',
                                    false,
                                    true,
                                    size,
                                    controller: LastnameCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.email_outlined,
                                    'Email...',
                                    false,
                                    true,
                                    size,
                                    controller: emailCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.phone_outlined,
                                    'Phone...',
                                    false,
                                    true,
                                    size,
                                    controller: PhoneCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.male_outlined,
                                    'Gender...',
                                    false,
                                    true,
                                    size,
                                    controller: GenderCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.admin_panel_settings_outlined,
                                    'Dept...',
                                    false,
                                    true,
                                    size,
                                    controller: DeptCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.admin_panel_settings_outlined,
                                    'Role...',
                                    false,
                                    true,
                                    size,
                                    controller: RoleCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.admin_panel_settings_outlined,
                                    'AuthCode...',
                                    true,
                                    false,
                                    size,
                                    controller: AuthCodeCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.password_outlined,
                                    'Password...',
                                    true,
                                    false,
                                    size,
                                    controller: passwordCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.password_outlined,
                                    'Confirm Password...',
                                    true,
                                    false,
                                    size,
                                    controller: confirmPasswordCtl),
                                const SizedBox(height: 25),
                                AuthViewComponents(context: context).component2(
                                  'Create Account',
                                  2.6,
                                  () {
                                    bool isStrongPassword =
                                        Validators.isValidPassword(
                                            passwordCtl.text);
                                    bool isPasswordMatch =
                                        Validators.isPasswordMatch(
                                            passwordCtl.text,
                                            confirmPasswordCtl.text);
                                    if (!isPasswordMatch) {
                                      Alertify.error(
                                          message: 'Password dosen\'t match');
                                    } else if (!isStrongPassword) {
                                      Alertify.error(
                                          message:
                                              'Password doesn\'t meet requirements');

                                      BlocProvider.of<AuthenticationBloc>(
                                              context)
                                          .add(SignUpEvent(context,
                                              adminModel: AdminModel(
                                                firstName: firstNameCtl.text,
                                                lastName: LastnameCtl.text,
                                                email: emailCtl.text,
                                                phoneNumber: PhoneCtl.text,
                                                gender: GenderCtl.text,
                                                dept: DeptCtl.text,
                                                role: RoleCtl.text,
                                                authCode: AuthCodeCtl.text,
                                                password:
                                                    confirmPasswordCtl.text,
                                                imageUrl: '',
                                                id: '',
                                              )));
                                    }
                                  },
                                  size,
                                ),
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
