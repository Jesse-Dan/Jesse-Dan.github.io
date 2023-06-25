import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/config/bloc_aler_notifier.dart';
import '../../../config/constants/responsive.dart';
import '../../../config/theme.dart';
import '../../../logic/bloc/admin_management/admin_managemet_bloc.dart';
import '../../../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../app_views/drawer_items/dashboard/main_screen.dart';
import 'components/components.dart';
import 'forgotten_password.dart';
import 'reg.dart';
import '../../widgets/alertify.dart';
import '../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../logic/bloc/auth_bloc/authentiction_state.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/.login.screen';
  const SignInScreen({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _transform;
  bool obs_1 = true;
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();

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
              text: 'Don\'t have an account? '),
          TextSpan(
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: primaryColor),
              text: 'Create a new Account',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
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
    return MultiBlocListener(
      listeners: [
        BlocListener<AuthenticationBloc, AuthentictionState>(
          listener: (context, state) {
            log(state.toString());
            if (state is AuthentictionLoading) {
              showDialog(
                  context: context,
                  builder: ((context) =>
                      const Center(child: CircularProgressIndicator())));
            }
            if (state is AuthentictionSuccesful) {
              Navigator.pushNamedAndRemoveUntil(
                  context, MainScreen.routeName, (_) => false);
              Alertify.success(message: 'User Logged in sussecfully');
            }

            if (state is AuthentictionFailed) {
              Navigator.pop(context);
              Alertify.error(message: state.error);
            }
          },
        ),
      ],
      child: BlocBuilder<AuthenticationBloc, AuthentictionState>(
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
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const SizedBox(),
                                Text(
                                  textAlign: TextAlign.center,
                                  'TYLDC PORTAL\nLOGIN',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black.withOpacity(.7),
                                  ),
                                ),
                                const SizedBox(),
                                AuthViewComponents(context: context).component1(
                                    Icons.email_outlined,
                                    'Email...',
                                    false,
                                    true,
                                    size,
                                    controller: emailCtl),
                                AuthViewComponents(context: context).component1(
                                    Icons.lock_outline,
                                    'Password...',
                                    obs_1,
                                    false,
                                    size,
                                    controller: passwordCtl,
                                    suffixIcon: Icons.remove_red_eye_sharp,
                                    onTapSuffixIcon: () {
                                  setState(() {
                                    obs_1 = !obs_1;
                                  });
                                }),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    AuthViewComponents(context: context)
                                        .component2(
                                      'LOGIN',
                                      2.6,
                                      () {
                                        BlocProvider.of<AuthenticationBloc>(
                                                context)
                                            .add(LoginEvent(context,
                                                email: emailCtl.text.trim(),
                                                password:
                                                    passwordCtl.text.trim()));
                                      },
                                      size,
                                    ),
                                    SizedBox(
                                        width: Responsive.isDesktop(context)
                                            ? size.width / 100
                                            : size.width / 25),
                                    Container(
                                      width: Responsive.isDesktop(context)
                                          ? size.width / 7
                                          : size.width / 2.6,
                                      alignment: Alignment.center,
                                      child: RichText(
                                        text: TextSpan(
                                          text: 'Forgotten password!',
                                          style: const TextStyle(
                                              color: Colors.blueAccent),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.of(context).pushNamed(
                                                  ForgottenPasswordScreen
                                                      .routeName);
                                            },
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                                Center(child: toggleCreateAccount()),
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
          );
        },
      ),
    );
  }
}
