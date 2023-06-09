// import 'package:flutter/material.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:tyldc_finaalisima/config/constants/responsive.dart';
// import 'package:tyldc_finaalisima/config/theme.dart';
// import 'package:tyldc_finaalisima/presentation/screens/auth_views/components/components.dart';

// import '../logic/bloc/auth_bloc/authentiction_bloc.dart';
// import '../logic/bloc/auth_bloc/authentiction_state.dart';
// import '../presentation/screens/auth_views/reg.dart';


// class SignInScreen extends StatefulWidget {
//   static const routeName = '/.login.screen';
//   const SignInScreen({Key? key}) : super(key: key);

//   @override
//   _SignInScreenState createState() => _SignInScreenState();
// }

// class _SignInScreenState extends State<SignInScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _opacity;
//   late Animation<double> _transform;
//   final TextEditingController emailCtl = TextEditingController();
//   final TextEditingController passwordCtl = TextEditingController();

//   @override
//   void initState() {
//     _controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 3),
//     );

//     _opacity = Tween<double>(begin: 0, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.ease,
//       ),
//     )..addListener(() {
//         setState(() {});
//       });

//     _transform = Tween<double>(begin: 2, end: 1).animate(
//       CurvedAnimation(
//         parent: _controller,
//         curve: Curves.fastLinearToSlowEaseIn,
//       ),
//     );

//     _controller.forward();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return BlocConsumer<AuthenticationBloc, AuthentictionState>(
//       listener: (context, state) {
//         if (state is AuthentictionLoading) {
//           showDialog(
//               context: context,
//               builder: ((context) =>
//                   const Center(child: CircularProgressIndicator())));
//         }
//         if (state is AuthentictionSuccesful) {
//           Fluttertoast.showToast(msg: 'User Logged in sussecfullyd');
//         }
//         if (state is AuthentictionFailed) {
//           Navigator.pop(context);

//           Fluttertoast.showToast(msg: state.error);
//         }
//       },
//       builder: (context, state) {
//         return Scaffold(
//           extendBodyBehindAppBar: true,
//           appBar: AppBar(
//             backgroundColor: Colors.transparent,
//             elevation: 0,
//             systemOverlayStyle: SystemUiOverlayStyle.light,
//           ),
//           body: ScrollConfiguration(
//             behavior: MyBehavior(),
//             child: SingleChildScrollView(
//               child: SizedBox(
//                 height: size.height,
//                 child: Container(
//                   alignment: Alignment.center,
//                   decoration: const BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [
//                         cardColors,
//                         primaryColor,
//                       ],
//                     ),
//                   ),
//                   child: Opacity(
//                     opacity: _opacity.value,
//                     child: Transform.scale(
//                       scale: _transform.value,
//                       child: Padding(
//                         padding: const EdgeInsets.all(defaultPadding),
//                         child: Container(
//                           width: Responsive.isDesktop(context)
//                               ? size.width / 3
//                               : size.width * .9,
//                           height: Responsive.isDesktop(context)
//                               ? size.width / 2.3
//                               : size.width * 1.1,
//                           decoration: BoxDecoration(
//                             color: Colors.white,
//                             borderRadius: BorderRadius.circular(15),
//                             boxShadow: [
//                               BoxShadow(
//                                 color: Colors.black.withOpacity(.1),
//                                 blurRadius: 90,
//                               ),
//                             ],
//                           ),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               const SizedBox(),
//                               Text(
//                                 textAlign: TextAlign.center,
//                                 'TYLDC PORTAL\nLOGIN',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.w600,
//                                   color: Colors.black.withOpacity(.7),
//                                 ),
//                               ),
//                               const SizedBox(),
//                               AuthViewComponents(context: context).component1(
//                                   Icons.email_outlined,
//                                   'Email...',
//                                   false,
//                                   true,
//                                   size,
//                                   controller: emailCtl),
//                               AuthViewComponents(context: context).component1(
//                                   Icons.lock_outline,
//                                   'Password...',
//                                   true,
//                                   false,
//                                   size,
//                                   controller: passwordCtl),
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   AuthViewComponents(context: context)
//                                       .component2(
//                                     'LOGIN',
//                                     2.6,
//                                     () {
//                                       HapticFeedback.lightImpact();
//                                       Fluttertoast.showToast(
//                                           msg: 'Login button pressed');
//                                     },
//                                     size,
//                                   ),
//                                   SizedBox(
//                                       width: Responsive.isDesktop(context)
//                                           ? size.width / 100
//                                           : size.width / 25),
//                                   Container(
//                                     width: Responsive.isDesktop(context)
//                                         ? size.width / 7
//                                         : size.width / 2.6,
//                                     alignment: Alignment.center,
//                                     child: RichText(
//                                       text: TextSpan(
//                                         text: 'Forgotten password!',
//                                         style: const TextStyle(
//                                             color: Colors.blueAccent),
//                                         recognizer: TapGestureRecognizer()
//                                           ..onTap = () {
//                                             Fluttertoast.showToast(
//                                               msg:
//                                                   'Forgotten password! button pressed',
//                                             );
//                                           },
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                               const SizedBox(),
//                               RichText(
//                                 text: TextSpan(
//                                   text: 'Create a new Account',
//                                   style: const TextStyle(
//                                     color: Colors.blueAccent,
//                                     fontSize: 15,
//                                   ),
//                                   recognizer: TapGestureRecognizer()
//                                     ..onTap = () {
//                                       Navigator.of(context)
//                                           .pushNamed(SignUpScreen.routeName);
//                                     },
//                                 ),
//                               ),
//                               const SizedBox(),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
