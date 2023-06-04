// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bot_toast/bot_toast.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../config/constants/enums.dart';
import '../config/routes.dart';
import '../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../logic/bloc/connectivity_cubit/connectivity_cubit.dart';
import '../logic/bloc/cubit/methods_cubit.dart';
import '../logic/bloc/dash_board_bloc/dash_board_bloc.dart';
import '../logic/bloc/registeration_bloc/registeration_bloc.dart';
import '../presentation/screens/auth/login.dart';
import '../presentation/screens/auth/reg.dart';
import '../presentation/screens/screens/dashboard/dashboard_screen.dart';
import '../presentation/screens/screens/main/main_screen.dart';
import '../presentation/widgets/alertify.dart';

class MyApp extends StatefulWidget {
  final Connectivity connectivity;
  final FirebaseAuth auth;
  final FirebaseStorage storage;

  const MyApp({
    Key? key,
    required this.connectivity,
    required this.auth,
    required this.storage,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegistrationBloc(auth: widget.auth, storage: widget.storage),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(auth: widget.auth),
        ),
        BlocProvider(
          create: (context) =>
              MethodsCubit(globalKey: GlobalKey<ScaffoldState>()),
        ),
        BlocProvider(
          create: (context) =>
              RegistrationBloc(auth: widget.auth, storage: widget.storage),
        ),
        BlocProvider(
          create: (context) => ConnectivityCubit(
            connectivity: widget.connectivity,
          ),
        ),
        BlocProvider(
          create: (context) => DashBoardBloc(widget.auth, widget.storage),
        ),
      ],
      child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        builder: ((context, state) {
          if (state is ConnectivityConnected &&
              state.connectionType == ConnectionType.mobileData) {
            // Alertify.success(
            // message: 'You\re now connected to the internet via Mobile data',
            // title: 'Network Connection');
          }
          if (state is ConnectivityConnected &&
              state.connectionType == ConnectionType.wifi) {
            // Alertify.success(
            //     message: 'You\re now connected to the internet via Wifi',
            //     title: 'Network Connection');
          }
          if (state is ConnectivityDisConnected) {
            // Alertify.error(
            //     message: 'You\re now connected to the internet via Wifi',
            //     title: 'Network Connection');
          }
          return MaterialApp(
            navigatorObservers: [BotToastNavigatorObserver()],
            builder: BotToastInit(),
            debugShowCheckedModeBanner: false,
            restorationScopeId: 'app',
            localizationsDelegates: const [
              // AppLocalizations.delegate,
              // GlobalMaterialLocalizations.delegate,
              // GlobalWidgetsLocalizations.delegate,
              // GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', 'NGN'),
            ],
            // onGenerateTitle: (BuildContext context) =>
            //     AppLocalizations.of(context).appTitle,

            // theme: lightThemeData(context),
            // darkTheme: darkThemeData(context),
            themeMode: ThemeMode.dark,
            onGenerateRoute: (RouteSettings routeSettings) {
              return MaterialPageRoute<void>(
                settings: routeSettings,
                builder: (BuildContext context) {
                  switch (routeSettings.name) {
                    case DashboardScreen.routeName:
                      return DashboardScreen();
                    case MainScreen.routeName:
                      return MainScreen();
                    case SignUpScreen.routeName:
                      return SignUpScreen();
                    case SignInScreen.routeName:
                      return SignInScreen();
                    default:
                      return SignInScreen();
                  }
                },
              );
            },
          );
        }),
      ),
    );
  }
}
