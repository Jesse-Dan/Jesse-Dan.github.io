// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:alert_system/systems/initializer.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/admin_management/admin_managemet_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/contact_us/contact_us_state.dart';
import 'package:tyldc_finaalisima/logic/bloc/non_admin_management/non_admin_management_bloc.dart';
import 'package:tyldc_finaalisima/logic/bloc/user_management/user_management_bloc.dart';
import 'package:tyldc_finaalisima/logic/local_storage_service.dart/local_storage.dart';
import 'package:tyldc_finaalisima/presentation/screens/app_views/drawer_items/profile/profile_screen.dart';
import 'package:tyldc_finaalisima/presentation/screens/app_views/drawer_items/recently_deleted/recenttly_deleted_screen.dart';
import 'package:tyldc_finaalisima/presentation/screens/auth_views/forgotten_password.dart';
import '../config/constants/enums.dart';
import '../logic/bloc/auth_bloc/authentiction_bloc.dart';
import '../logic/bloc/cubit/methods_cubit.dart';
import '../logic/bloc/index_blocs.dart';
import '../presentation/landing_page/landingPage.dart';
import '../presentation/screens/app_views/drawer_items/attendees/attendees_screen.dart';
import '../presentation/screens/app_views/drawer_items/contact_us/contact_us_data.dart';
import '../presentation/screens/app_views/drawer_items/dashboard/dashboard_screen.dart';
import '../presentation/screens/app_views/drawer_items/dashboard/main_screen.dart';
import '../presentation/screens/app_views/drawer_items/groups/groups_screen.dart';
import '../presentation/screens/app_views/drawer_items/notification/notification_screen.dart';
import '../presentation/screens/app_views/drawer_items/settings/setting_screen.dart';
import '../presentation/screens/auth_views/login.dart';
import '../presentation/screens/auth_views/phone_verification.dart';
import '../presentation/screens/auth_views/reg.dart';
import '../presentation/screens/app_views/drawer_items/admin/admin_screen.dart';
import '../presentation/screens/app_views/drawer_items/non_admin/non_admins_screen.dart';

class MyApp extends StatefulWidget {
  final Connectivity connectivity;
  final FirebaseAuth auth;
  final FirebaseStorage storage;
  final LocalStorageService localStorageService;

  const MyApp({
    Key? key,
    required this.localStorageService,
    required this.connectivity,
    required this.auth,
    required this.storage,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => RegistrationBloc(
              auth: widget.auth,
              storage: widget.storage,
              localStorageService: widget.localStorageService),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(
              auth: widget.auth,
              localStorageService: widget.localStorageService),
        ),
        BlocProvider(
          create: (context) => MethodsCubit(),
        ),
        BlocProvider(
          create: (context) => RegistrationBloc(
              auth: widget.auth,
              storage: widget.storage,
              localStorageService: widget.localStorageService),
        ),
        BlocProvider(
          create: (context) =>
              GroupManagementBloc(auth: widget.auth, storage: widget.storage),
        ),
        BlocProvider(
          create: (context) =>
              ConnectivityCubit(connectivity: widget.connectivity),
        ),
        BlocProvider(
          create: (context) => DashBoardBloc(widget.auth, widget.storage),
        ),
        BlocProvider(
          create: (context) =>
              UserManagementBloc(auth: widget.auth, storage: widget.storage),
        ),
        BlocProvider(
          create: (context) => NonAdminManagementBloc(
              auth: widget.auth, storage: widget.storage),
        ),
        BlocProvider(
            create: (context) => AdminManagemetBloc(
                auth: widget.auth,
                storage: widget.storage,
                localStorageService: widget.localStorageService)),
        BlocProvider(
            create: (context) => ContactUsBloc(
                initialState: InitialContactUsState(),
                auth: widget.auth,
                storage: widget.storage,
                localStorageService: widget.localStorageService)),
      ],
      child: BlocBuilder<ConnectivityCubit, ConnectivityState>(
        builder: ((context, state) {
          if (state is ConnectivityConnected &&
              state.connectionType == ConnectionType.mobileData) {}
          if (state is ConnectivityConnected &&
              state.connectionType == ConnectionType.wifi) {}
          if (state is ConnectivityDisConnected) {}
          return MaterialApp(
            key: _scaffoldKey,
            navigatorObservers: [OverlayManagerInit.navigatorObserver],
            builder: OverlayManagerInit.builder,
            debugShowCheckedModeBanner: false,
            restorationScopeId: LandingPage.routeName,
            localizationsDelegates: const [],
            supportedLocales: const [
              Locale('en', 'NGN'),
            ],
            // theme: lightThemeData(context),
            // darkTheme: darkThemeData(context),
            themeMode: ThemeMode.light,
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
                      return const SignUpScreen();
                    case NotificationScreen.routeName:
                      return const NotificationScreen();
                    case AttendeesScreen.routeName:
                      return const AttendeesScreen();
                    case NonAdminScreen.routeName:
                      return const NonAdminScreen();
                    case GroupsScreen.routeName:
                      return const GroupsScreen();
                    case AdminScreen.routeName:
                      return const AdminScreen();
                    case SignInScreen.routeName:
                      return const SignInScreen();
                    case RecentlyDeleted.routeName:
                      return const RecentlyDeleted();
                    case PhoneVerificationScreen.routeName:
                      return const PhoneVerificationScreen();
                    case ForgottenPasswordScreen.routeName:
                      return const ForgottenPasswordScreen();
                    case ProfileScreen.routeName:
                      return const ProfileScreen();
                    case SettingsScreen.routeName:
                      return const SettingsScreen();
                    case LandingPage.routeName:
                      return const LandingPage();
                    case ContactUsScreen.routeName:
                      return const ContactUsScreen();
                    default:
                      return const LandingPage();
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
