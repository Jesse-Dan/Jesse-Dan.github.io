// ignore_for_file: deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tyldc_finaalisima/firebase_options.dart';
import 'bloc_obsever.dart';
import 'logic/web_midget.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(() async {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    setOrientation();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]).then((_) {
      runApp(MyApp(
        storage: FirebaseStorage.instance,
        connectivity: Connectivity(),
        auth: FirebaseAuth.instance,
      ));
    });
  }, blocObserver: MyBlocObserver());
}
