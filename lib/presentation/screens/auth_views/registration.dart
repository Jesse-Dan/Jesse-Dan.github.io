// ignore_for_file: unnecessary_statements, non_constant_identifier_names, avoid_single_cascade_in_expression_statements
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tyldc_finaalisima/config/validators.dart';
import 'package:tyldc_finaalisima/logic/bloc/admin_management/admin_managemet_bloc.dart';
import '../../../config/overlay_config/overlay_service.dart';
import '../../../config/theme.dart';
import '../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../logic/bloc/auth_bloc/authentiction_state.dart';
import '../../../models/user_model.dart';
import 'package:tyldc_finaalisima/config/constants/responsive.dart';
import 'package:tyldc_finaalisima/presentation/screens/auth_views/components/components.dart';

import '../../landing_page/page_builder/ball.dart';
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
  bool obs_1 = true;
  bool obs_2 = true;
  bool a_d_obs_1 = true;

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
  String? gender;
  String? dept;

  @override
  void initState() {
    BlocProvider.of<AdminManagemetBloc>(context).add(GetCodeEvent());
    BlocProvider.of<AdminManagemetBloc>(context).add(GetMultipleEvent());
    OverlayService.closeAlert();
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
              style: GoogleFonts.josefinSans(
                  fontWeight: FontWeight.w400, fontSize: 12, color: cardColors),
              text: 'Already have an account? '),
          TextSpan(
              style: GoogleFonts.josefinSans(
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
          OverlayService.showLoading();
        }
        if (state is AuthentictionSuccesful) {
          Navigator.pushNamedAndRemoveUntil(
              context, SignInScreen.routeName, (_) => false);
          // BlocProvider.of<AuthenticationBloc>(context)
          //     .add(SendOtpEvent(int.parse(PhoneCtl.text)));
          // Alertify.success(message: 'An otp has been sent to ${PhoneCtl.text}');
        }
        if (state is AuthentictionFailed) {
          OverlayService.closeAlert();
          Alertify.error(message: state.error);
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: ScrollConfiguration(
            behavior: MyBehavior(),
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                width: double.infinity,
                color: kSecondaryColor,
                child: Stack(
                  children: [
                    /// TOP
                    BgAnime(),
                    SizedBox(
                      height: size.height,
                      child: Container(
                        alignment: Alignment.center,
                        // decoration: const BoxDecoration(
                        //   gradient: LinearGradient(
                        //     begin: Alignment.topLeft,
                        //     end: Alignment.bottomRight,
                        //     colors: [
                        //       cardColors,
                        //       primaryColor,
                        //     ],
                        // ),
                        // ),
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
                                  child: BlocBuilder<AdminManagemetBloc,
                                      AdminManagemetState>(
                                    buildWhen: (previous, current) {
                                      return current
                                          is AdminManagemetFetchedMultipleForMAINPAGE;
                                    },
                                    builder: (context, state) {
                                      bool fetched = state
                                          is AdminManagemetFetchedMultipleForMAINPAGE;
                                      // bool loading = state is AdminManagementLoading;
                                      // bool error = state is AdminManagemetFailed;

                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          const SizedBox(height: 25),
                                          Text(
                                            textAlign: TextAlign.center,
                                            'TYLDC PORTAL\nCREATE ACCOUNT',
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w600,
                                              color:
                                                  Colors.black.withOpacity(.7),
                                            ),
                                          ),
                                          const SizedBox(height: 25),
                                          const SizedBox(),
                                          AuthViewComponents(context: context)
                                              .component1(
                                                  Icons.account_circle_outlined,
                                                  'First Name...',
                                                  false,
                                                  true,
                                                  size,
                                                  controller: firstNameCtl),
                                          AuthViewComponents(context: context)
                                              .component1(
                                                  Icons.account_circle_outlined,
                                                  'Last Name...',
                                                  false,
                                                  true,
                                                  size,
                                                  controller: LastnameCtl),
                                          AuthViewComponents(context: context)
                                              .component1(Icons.email_outlined,
                                                  'Email...', false, true, size,
                                                  controller: emailCtl),
                                          AuthViewComponents(context: context)
                                              .component1(Icons.phone_outlined,
                                                  'Phone...', false, true, size,
                                                  controller: PhoneCtl,
                                                  limit: 10,
                                                  type: TextInputType.phone),
                                          AuthViewComponents(context: context)
                                              .genderDropDown(
                                                  iconsData: Icons.male_rounded,
                                                  size: size,
                                                  fillColor: null,
                                                  inputColors: null,
                                                  onChanged: (_) {
                                                    setState(() => gender = _);
                                                  },
                                                  value: gender),
                                          // AuthViewComponents(context: context)
                                          //     .valueablesDropDown(
                                          //         iconsData: Icons.watch,
                                          //         size: size,
                                          //         fillColor: null,
                                          //         inputColors: null,
                                          //         onChanged: (_) {
                                          //           setState(() {
                                          //             if (valueable.contains(_)) {
                                          //               FormWidget()
                                          //                   .buildCenterFormField(
                                          //                       title:
                                          //                           'Error Selecting Valuables',
                                          //                       context: context,
                                          //                       widgetsList: [
                                          //                         Padding(
                                          //                           padding:
                                          //                               const EdgeInsets
                                          //                                       .all(
                                          //                                   16.0),
                                          //                           child: Text(
                                          //                             'You cannot Select ${_} valuable type multiple times',
                                          //                             textAlign:
                                          //                                 TextAlign
                                          //                                     .center,
                                          //                             style: GoogleFonts.josefinSans(
                                          //                                 height:
                                          //                                     1.5,
                                          //                                 fontSize:
                                          //                                     15,
                                          //                                 color:
                                          //                                     kSecondaryColor,
                                          //                                 fontWeight:
                                          //                                     FontWeight
                                          //                                         .w500),
                                          //                           ),
                                          //                         )
                                          //                       ],
                                          //                       onSubmit: () {
                                          //                         OverlayService
                                          //                             .closeAlert();
                                          //                       },
                                          //                       alertType: AlertType
                                          //                           .oneBtn,
                                          //                       onSubmit2: () {});
                                          //             } else {
                                          //               valueable.add(_!);
                                          //             }
                                          //           });
                                          //         },
                                          //         value: empty),
                                          // if (valueable.length != 0)
                                          //   AuthViewComponents(context: context)
                                          //       .buildParentCard(
                                          //           padding: EdgeInsets.symmetric(
                                          //               horizontal: 20),
                                          //           size: size,
                                          //           child: GridView.count(
                                          //               shrinkWrap: true,
                                          //               crossAxisCount: 4,
                                          //               crossAxisSpacing: 1.0,
                                          //               mainAxisSpacing: 5.0,
                                          //               children: List.generate(
                                          //                   valueable.length,
                                          //                   (index) =>
                                          //                       AuthViewComponents(
                                          //                               context:
                                          //                                   context)
                                          //                           .buildChip(
                                          //                               color:
                                          //                                   bgColor,
                                          //                               label: valueable[
                                          //                                   index],
                                          //                               onDelete:
                                          //                                   () {
                                          //                                 setState(
                                          //                                     () {
                                          //                                   valueable
                                          //                                       .removeAt(index);
                                          //                                 });
                                          //                               })))),
                                          // AuthViewComponents(context: context)
                                          //     .healthStatusDropDown(
                                          //         iconsData: Icons
                                          //             .medical_information_rounded,
                                          //         size: size,
                                          //         fillColor: null,
                                          //         inputColors: null,
                                          //         onChanged: (_) {
                                          //           setState(
                                          //               () => medicalStatus = _);
                                          //         },
                                          //         value: medicalStatus),
                                          // if (medicalStatus == 'Yes')
                                          //   AuthViewComponents(context: context)
                                          //       .component1(
                                          //           Icons
                                          //               .medical_information_rounded,
                                          //           'Medical Condition or Prescription...',
                                          //           false,
                                          //           true,
                                          //           size,
                                          //           controller: DeptCtl),
                                          // if (medicalStatus == 'Yes')
                                          //   AuthViewComponents(context: context)
                                          //       .healthStatusDropDown(
                                          //           title:
                                          //               'Do you have any Disabilities',
                                          //           iconsData: Icons
                                          //               .medical_information_rounded,
                                          //           size: size,
                                          //           fillColor: null,
                                          //           inputColors: null,
                                          //           onChanged: (_) {
                                          //             setState(() =>
                                          //                 disabilityStatus = _);
                                          //           },
                                          //           value: disabilityStatus),
                                          // if (disabilityStatus == 'Yes')
                                          //   AuthViewComponents(context: context)
                                          //       .disabilityDropDown(
                                          //           iconsData: Icons
                                          //               .medical_information_rounded,
                                          //           size: size,
                                          //           fillColor: null,
                                          //           inputColors: null,
                                          //           onChanged: (_) {
                                          //             setState(
                                          //                 () => disability = _);
                                          //           },
                                          //           value: disability),
                                          AuthViewComponents(context: context)
                                              .deptDropDown(
                                                  iconsData: Icons.male_rounded,
                                                  size: size,
                                                  fillColor: null,
                                                  inputColors: null,
                                                  onChanged: (_) =>
                                                      setState(() => dept = _),
                                                  value: dept,
                                                  list: fetched
                                                      ? state.departmentTypes!
                                                          .departments
                                                          .map((e) => e
                                                              .departmentName
                                                              .toString())
                                                          .toList()
                                                      : []),
                                          AuthViewComponents(context: context)
                                              .component1(
                                                  Icons
                                                      .admin_panel_settings_outlined,
                                                  'Role...',
                                                  false,
                                                  true,
                                                  size,
                                                  controller: RoleCtl),
                                          AuthViewComponents(context: context)
                                              .component1(
                                                  Icons
                                                      .admin_panel_settings_outlined,
                                                  'AuthCode...',
                                                  a_d_obs_1,
                                                  false,
                                                  size,
                                                  controller: AuthCodeCtl,
                                                  suffixIcon:
                                                      Icons.remove_red_eye,
                                                  onTapSuffixIcon: () {
                                            setState(() {
                                              a_d_obs_1 = !a_d_obs_1;
                                            });
                                          }),
                                          AuthViewComponents(context: context)
                                              .component1(
                                                  Icons.password_outlined,
                                                  'Password...',
                                                  obs_1,
                                                  false,
                                                  size,
                                                  controller: passwordCtl,
                                                  suffixIcon:
                                                      Icons.remove_red_eye,
                                                  onTapSuffixIcon: () {
                                            setState(() {
                                              obs_1 = !obs_1;
                                            });
                                          }),
                                          AuthViewComponents(context: context)
                                              .component1(
                                                  Icons.password_outlined,
                                                  'Confirm Password...',
                                                  obs_2,
                                                  false,
                                                  size,
                                                  controller:
                                                      confirmPasswordCtl,
                                                  suffixIcon:
                                                      Icons.remove_red_eye,
                                                  onTapSuffixIcon: () {
                                            setState(() {
                                              obs_2 = !obs_2;
                                            });
                                          }),
                                          const SizedBox(height: 25),
                                          AuthViewComponents(context: context)
                                              .component2(
                                            'Create Account',
                                            2.6,
                                            () {
                                              try {
                                                bool isStrongPassword =
                                                    Validators.isValidPassword(
                                                        passwordCtl.text);
                                                bool isPasswordMatch =
                                                    Validators.isPasswordMatch(
                                                        passwordCtl.text,
                                                        confirmPasswordCtl
                                                            .text);
                                                if (!isPasswordMatch) {
                                                  Alertify.error(
                                                      title:
                                                          'Registration Error',
                                                      message:
                                                          'Password dosen\'t match');
                                                } else if (!isStrongPassword) {
                                                  Alertify.error(
                                                      title:
                                                          'Registration Error',
                                                      message:
                                                          'Password doesn\'t meet requirements (A-z,1-9,@\'_)');
                                                } else if (PhoneCtl.text.length
                                                        .isLowerThan(10) ||
                                                    PhoneCtl.text[0] == '0' ||
                                                    PhoneCtl.text.contains(
                                                        RegExp(r'[a-zA-Z]'))) {
                                                  Alertify.error(
                                                      title:
                                                          'Registration Error',
                                                      message:
                                                          'Phone Number entered appears invalid');
                                                } else if (firstNameCtl
                                                        .text.isEmpty ||
                                                    LastnameCtl.text.isEmpty ||
                                                    PhoneCtl.text.isEmpty ||
                                                    gender == null ||
                                                    dept == null ||
                                                    RoleCtl.text.isEmpty) {
                                                  Alertify.error(
                                                      title:
                                                          'Registration Error',
                                                      message:
                                                          'Some Fields are empty');
                                                } else {
                                                  // verifyAction(
                                                  //     title: 'SignUp Process',
                                                  //     text:
                                                  //         'Are you certain of the details  you\'ve entered? any issue encountered here can only be resolved by your Admin!! ',
                                                  //     action: () {
                                                  BlocProvider.of<
                                                              AuthenticationBloc>(
                                                          context)
                                                      .add(SignUpEvent(context,
                                                          adminModel:
                                                              AdminModel(
                                                            enabled: true,
                                                            firstName:
                                                                firstNameCtl
                                                                    .text,
                                                            lastName:
                                                                LastnameCtl
                                                                    .text,
                                                            email:
                                                                emailCtl.text,
                                                            phoneNumber:
                                                                PhoneCtl.text,
                                                            gender: gender ??
                                                                'notPicked',
                                                            dept: dept ??
                                                                'Not Picked',
                                                            role: RoleCtl.text,
                                                            authCode:
                                                                AuthCodeCtl
                                                                    .text,
                                                            password:
                                                                confirmPasswordCtl
                                                                    .text,
                                                            imageUrl: '',
                                                            id: '',
                                                          )));
                                                  //       },
                                                  //       context: context);
                                                }
                                              } catch (e) {
                                                Alertify.error(
                                                    title: 'Registration Error',
                                                    message:
                                                        'An Unknown Error Occured [ERROR: $e], Contact your Admin');
                                              }
                                            },
                                            size,
                                          ),
                                          const SizedBox(height: 20),
                                          (toggleCreateAccount()),
                                          const SizedBox(height: 20),
                                        ],
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
