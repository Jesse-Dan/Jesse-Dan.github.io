// import 'dart:developer';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import '../../config/codes.dart';
// import '../../models/models.dart';
// import '../db/db.dart';

// class FireBaseAuthentication {
//   final auth = FirebaseAuth.instance;
//   FireBaseAuthentication();

//   Future<dynamic> login({email, password}) async {
//     try {
//       await auth.signInWithEmailAndPassword(
//         email: email,
//         password: password,
//       );
      // var actor = await DB(auth: auth).fetchAdminData();
      // await DB(auth: auth).sendNotificationData(
      //     Notifier.login(data: actor.firstName + actor.lastName));
//       return true;
//     } on FirebaseAuthException catch (e) {
//       if (e.code == 'invalid-email') {
//         print('Invalid email address.');
//         return e.message.toString();
//       } else if (e.code == 'wrong-password') {
//         print('Incorrect password.');
//         return e.message.toString();
//       } else if (e.code == 'user-not-found') {
//         // There is no user corresponding to the email address.
//         print('No user found for that email.');
//         return e.message.toString();
//       } else if (e.code == 'user-disabled') {
//         // The user account has been disabled by an administrator.
//         print('User account has been disabled.');
//         return e.message.toString();
//       } else if (e.code == 'too-many-requests') {
//         return e.message.toString();
//         // There have been too many unsuccessful sign-in attempts.
//       } else if (e.code == 'operation-not-allowed') {
//         return e.message.toString();
//         // The requested sign-in method is not enabled for the Firebase project.
//       } else if (e.code == 'email-already-in-use') {
//         return e.message.toString();
//         // The email address is already associated with a different user account.
//       } else {
//         print('Error occurred while signing in: ${e.message}');

//         return e.message.toString();
//         // Handle other exceptions.
//       }
//     } catch (e) {
//       return false;
//     }
//   }

//   Future<dynamic> signup({required AdminModel adminModel}) async {
//     if (adminModel.authCode.trim() == ADMIN_AUTH_CODE) {
//       try {
//         await auth.createUserWithEmailAndPassword(
//           email: adminModel.email,
//           password: adminModel.password,
//         );
//         await DB(auth: auth).sendAdminData(AdminModel(
//             id: adminModel.id,
//             lastName: adminModel.lastName,
//             email: adminModel.email,
//             phoneNumber: adminModel.phoneNumber,
//             gender: adminModel.gender,
//             dept: adminModel.dept,
//             role: adminModel.role,
//             authCode: adminModel.authCode,
//             password: adminModel.password,
//             firstName: adminModel.firstName,
//             imageUrl: ''));
        // await DB(auth: auth).sendNotificationData(
        //     Notifier.signUp(data: adminModel.firstName + adminModel.lastName));

//         return true;
//       } on FirebaseAuthException catch (e) {
//         if (e.code == 'invalid-email') {
//           return e.message.toString();
//           // The email address is invalid.
//         } else if (e.code == 'email-already-in-use') {
//           return e.message.toString();
//           // The email address is already associated with a different user account.
//         } else if (e.code == 'operation-not-allowed') {
//           return e.message.toString();
//           // The requested sign-up method is not enabled for the Firebase project.
//         } else if (e.code == 'weak-password') {
//           return e.message.toString();
//           // The password is too weak.
//         } else {
//           return e.message.toString();
//           // Handle other exceptions.
//         }
//       } catch (e) {
//         log(e.toString());
//         return false;
//       }
//     } else {
//       return 'Admin Authentication code [${adminModel.authCode}] is incorrect, contact your admin for support'
//           .toString();
//     }
//   }

//   Future<bool> logout() async {
//     try {
//       await auth.signOut().then((value) => log('User Logged Out'));
      // await DB(auth: auth)
      //     .sendNotificationData(Notifier.logout(data: 'You ended your session'));

//       return true;
//     } on FirebaseAuthException catch (e) {
//       log(e.toString());
//       return false;
//     } catch (e) {
//       log(e.toString());
//       return false;
//     }
//   }
// }
