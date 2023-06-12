// ignore_for_file: unnecessary_statements, non_constant_identifier_names

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../config/palette.dart';
import '../../../config/theme.dart';
import '../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../logic/bloc/auth_bloc/authentiction_state.dart';
import '../../../models/user_model.dart';
import '../../widgets/alertify.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/signup.screen';

  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  RichText toggleCreateAccount() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Palette.white),
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

  final TextEditingController LastnameCtl = TextEditingController();
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController PhoneCtl = TextEditingController();
  final TextEditingController GenderCtl = TextEditingController();
  final TextEditingController DeptCtl = TextEditingController();
  final TextEditingController RoleCtl = TextEditingController();
  final TextEditingController AuthCodeCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();
  final TextEditingController firstNameCtl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthentictionState>(
        listener: (context, state) {
      if (state is AuthentictionLoading) {
        showDialog(
            context: context,
            builder: ((context) => Center(child: CircularProgressIndicator())));
      }
      if (state is AuthentictionSuccesful) {
        Alertify.success(
            title: 'Registration Success', message: 'User created sussecfully');
        Navigator.pushReplacementNamed(context, SignInScreen.routeName);
      }
      if (state is AuthentictionFailed) {
        Navigator.pop(context);
        Alertify.error(title: 'Registration Error', message: state.error);
      }
    }, builder: (context, state) {
      return Scaffold(
        backgroundColor: bgColor,
        body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 60),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    TextFormField(
                      controller: firstNameCtl,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: LastnameCtl,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailCtl,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: PhoneCtl,
                      decoration: InputDecoration(
                        hintText: 'Phone Number',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: GenderCtl,
                      decoration: InputDecoration(
                        hintText: 'Gender',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: DeptCtl,
                      decoration: InputDecoration(
                        hintText: 'Dept',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: RoleCtl,
                      decoration: InputDecoration(
                        hintText: 'Role',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: AuthCodeCtl,
                      decoration: InputDecoration(
                        hintText: 'AuthCode',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordCtl,
                      decoration: InputDecoration(
                        hintText: 'Password',
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        BlocProvider.of<AuthenticationBloc>(context)
                            .add(SignUpEvent(
                              context,
                                adminModel: AdminModel(
                          firstName: firstNameCtl.text,
                          lastName: LastnameCtl.text,
                          email: emailCtl.text,
                          phoneNumber:PhoneCtl .text,
                          gender: GenderCtl.text,
                          dept: DeptCtl.text,
                          role: RoleCtl.text,
                          authCode: AuthCodeCtl.text,
                          password: passwordCtl.text,
                          imageUrl: '',
                          id: '',
                        )));
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Sign Up'),
                    ),
                    const SizedBox(height: 16),
                    toggleCreateAccount(),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
