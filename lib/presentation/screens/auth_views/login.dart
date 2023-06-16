import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../config/palette.dart';
import '../../../config/theme.dart';
import '../../../logic/bloc/admin_management/admin_managemet_bloc.dart';
import '../../../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../../../logic/bloc/auth_bloc/authentiction_event.dart';
import '../../../logic/bloc/auth_bloc/authentiction_state.dart';
import '../../../models/auth_code_model.dart';
import '../../widgets/alertify.dart';
import 'reg.dart';

class SignInScreen extends StatefulWidget {
  static const routeName = '/.login.screen';

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController emailCtl = TextEditingController();
  final TextEditingController passwordCtl = TextEditingController();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AdminManagemetBloc>(context).add(const GetCodeEvent());
  }
  RichText toggleCreateAccount() {
    return RichText(
        textAlign: TextAlign.center,
        text: TextSpan(children: [
          TextSpan(
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Palette.white),
              text: 'Don\'t have an account? '),
          TextSpan(
              style: GoogleFonts.dmSans(
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                  color: primaryColor),
              text: ' Create a new Account',
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  Navigator.of(context).pushNamed(SignUpScreen.routeName);
                })
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticationBloc, AuthentictionState>(
        listener: (context, state) {
      if (state is AuthentictionLoading) {
        showDialog(
            context: context,
            builder: ((context) =>
                const Center(child: CircularProgressIndicator())));
      }
      if (state is AuthentictionSuccesful) {
        Alertify.success(
            title: 'Login Successful', message: 'User Logged in sussecfully');
      }
      if (state is AuthentictionFailed) {
        Navigator.pop(context);
        Alertify.error(title: 'Login Error', message: state.error);
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
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
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
                        BlocProvider.of<AuthenticationBloc>(context).add(
                            LoginEvent(context,
                                email: emailCtl.text.trim(),
                                password: passwordCtl.text.trim()));

                        // Perform login logic here
                      },
                      child: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    toggleCreateAccount()
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
