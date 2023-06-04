// ignore_for_file: deprecated_member_use

import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'bloc_obsever.dart';
import 'src/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(() async {
    if (kIsWeb) {
      await Firebase.initializeApp(
          options: const FirebaseOptions(
        apiKey: 'AIzaSyDSLBAPo2v4pZFs2wV6o8WeXseS8tOGXIU',
        appId: '1:390567584749:web:a1aa9135fef7df72d57de4',
        messagingSenderId: '390567584749',
        projectId: 'tyldc-registry',
        authDomain: 'tyldc-registry.firebaseapp.com',
        databaseURL:
            'https://tyldc-registry-default-rtdb.europe-west1.firebasedatabase.app',
        storageBucket: 'tyldc-registry.appspot.com',
        measurementId: 'G-FVRGNG2S19',
      ));
    } else {
      await Firebase.initializeApp();
    }
    runApp(MyApp(
      storage: FirebaseStorage.instance,
      connectivity: Connectivity(),
      auth: FirebaseAuth.instance,
    ));
  }, blocObserver: MyBlocObserver());
}
