import 'package:attendance/helpers/constants.dart';
import 'package:attendance/providers/admin_data_provider.dart';
import 'package:attendance/providers/check_in_out_status_provider.dart';
import 'package:attendance/providers/leave_types_provider.dart';
import 'package:attendance/providers/user_data_provider.dart';
import 'package:attendance/screens/admin_permission_request_screen.dart';
import 'package:attendance/screens/check_screen.dart';
import 'package:attendance/screens/dashboard_screen.dart';
import 'package:attendance/screens/leave_permission_request_screen.dart';
import 'package:attendance/screens/loading_screen.dart';
import 'package:attendance/screens/loan_request_screen.dart';
import 'package:attendance/screens/location_request_screen.dart';
import 'package:attendance/screens/login_screen.dart';
import 'package:attendance/screens/notifications_screen.dart';
import 'package:attendance/screens/profile_screen.dart';
import 'package:attendance/screens/update_image_screen.dart';
import 'package:attendance/screens/user_exit_permission_request_screen.dart';
import 'package:attendance/services/auth.dart';
import 'package:attendance/services/logout_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:open_settings/open_settings.dart';
import 'package:provider/provider.dart';

import 'drawer/header_drawer.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize Hive
  await Hive.initFlutter();

  // Open The Box
  await Hive.openBox('myBox');
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider<UserInformationProvider>(
        create: (context) => UserInformationProvider()),
    ChangeNotifierProvider<AdminInformationProvider>(
        create: (context) => AdminInformationProvider()),
    ChangeNotifierProvider<LeaveTypesProvider>(
        create: (context) => LeaveTypesProvider()),
    ChangeNotifierProvider<CheckStatusProvider>(
        create: (context) => CheckStatusProvider()),
  ], child: const MyApp()));
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      debugShowCheckedModeBanner: false,
      title: 'Attendance App',
      theme: ThemeData(
        brightness: Brightness.light,
        fontFamily: GoogleFonts.poppins().fontFamily,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: kPrimaryColor, background: Colors.grey.shade200),
        appBarTheme: AppBarTheme(backgroundColor: kPrimaryColor),
      ),
      routes: {
        LoadingScreen.id: (context) => const LoadingScreen(),
        CheckInOutScreen.id: (context) => const CheckInOutScreen(),
        DashboardScreen.id: (context) => const DashboardScreen(),
        AdminPermessionRequestScreen.id: (context) =>
            const AdminPermessionRequestScreen(),
        LeavePermissionRequestScreen.id: (context) =>
            const LeavePermissionRequestScreen(),
        LocationRequestScreen.id: (context) => const LocationRequestScreen(),
        LogInScreen.id: (context) => const LogInScreen(),
        '/notifications': (context) => const NotificationsScreen(),
        UserPermessionRequestScreen.id: (context) =>
            const UserPermessionRequestScreen(),
        LoanRequestScreen.id: (context) => const LoanRequestScreen(),
        ProfileScreen.id: (context) => ProfileScreen(),
        UpdateImageScreen.id: (context) => const UpdateImageScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DrawerSections currentPage = DrawerSections.dashboard;
  bool isBiometricsEnabled = false;
  final _myBox = Hive.box('myBox');

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          title: const Text('Using Fingerprint'),
          content: const SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Would you like to use your fingerprint'),
                Text('the next time you login?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Use My Fingerprint'),
              onPressed: () {
                setState(() {
                  isBiometricsEnabled = true;
                  _myBox.put('isBiometricsEnabled', true);
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();

    // check if biometrics enabled

    if (_myBox.get('isBiometricsEnabled') != null) {
      isBiometricsEnabled = _myBox.get('isBiometricsEnabled');
    }

    // if app opened for the first time

    if (_myBox.get('firstTime') == null) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _showMyDialog());
      _myBox.put('firstTime', false);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget? body;
    String title = '';

    if (currentPage == DrawerSections.dashboard) {
      body = const DashboardScreen();
      title = 'Dashboard';
    } else if (currentPage == DrawerSections.check) {
      body = const CheckInOutScreen();
      title = 'Check In/Out';
    } else if (currentPage == DrawerSections.profile) {
      body = ProfileScreen();
      title = 'My Profile';
    } else if (currentPage == DrawerSections.leave) {
      body = const LeavePermissionRequestScreen();
      title = 'Leave Request';
    } else if (currentPage == DrawerSections.locationRequest) {
      body = const LocationRequestScreen();
      title = 'Location Request';
    } else if (currentPage == DrawerSections.exitPermissionRequest) {
      body = const UserPermessionRequestScreen();
      title = 'Exit Permission Request';
    } else if (currentPage == DrawerSections.loanRequest) {
      body = const LoanRequestScreen();
      title = 'Loan Request';
    }
    return Scaffold(
        drawer: Drawer(
          child: SingleChildScrollView(
            child: Column(
              children: [HeaderDrawer(), myDrawerList()],
            ),
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          backgroundColor: Colors.transparent,
          centerTitle: true,
          title: Text(
            title,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/notifications');
                },
                icon: const Icon(
                  FontAwesomeIcons.bell,
                  size: 24,
                ))
          ],
        ),
        body: body);
  }

  Widget myDrawerList() {
    return Container(
      padding: const EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          menuItem(
            id: 0,
            title: 'Dashboard',
            icon: Icons.dashboard_rounded,
            selected: currentPage == DrawerSections.dashboard ? true : false,
          ),
          menuItem(
            id: 1,
            title: 'Check In/Out',
            icon: FontAwesomeIcons.arrowRightToBracket,
            selected: currentPage == DrawerSections.check ? true : false,
          ),
          menuItem(
            id: 2,
            title: 'My Profile',
            icon: FontAwesomeIcons.person,
            selected: currentPage == DrawerSections.profile ? true : false,
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          menuItem(
            id: 3,
            title: 'Leave Request',
            icon: FontAwesomeIcons.personWalkingArrowRight,
            selected: currentPage == DrawerSections.leave ? true : false,
          ),
          menuItem(
            soon: true,
            id: 4,
            title: 'Location Request',
            icon: FontAwesomeIcons.locationDot,
            selected:
                currentPage == DrawerSections.locationRequest ? true : false,
          ),
          menuItem(
            soon: true,
            id: 5,
            title: 'Exit Permission Request',
            icon: FontAwesomeIcons.personWalkingDashedLineArrowRight,
            selected: currentPage == DrawerSections.exitPermissionRequest
                ? true
                : false,
          ),
          menuItem(
            soon: true,
            id: 6,
            title: 'Loan Request',
            icon: FontAwesomeIcons.file,
            selected: currentPage == DrawerSections.loanRequest ? true : false,
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SwitchListTile(
                title: const Text('Use Fingerprint'),
                activeColor: kPrimaryColor,
                activeTrackColor: kPrimaryColor.withAlpha(50),
                value: isBiometricsEnabled,
                onChanged: (value) async {
                  if (await AuthService().checkBiometricsSupp() &&
                      await AuthService().checkBiometricsEnabled()) {
                    setState(() {
                      isBiometricsEnabled = value;
                      _myBox.put('isBiometricsEnabled', value);
                    });
                  } else if (await AuthService().checkBiometricsSupp() &&
                      !await AuthService().checkBiometricsEnabled() &&
                      isBiometricsEnabled == true) {
                    setState(() {
                      isBiometricsEnabled = false;
                      _myBox.put('isBiometricsEnabled', false);
                    });
                  } else if (await AuthService().checkBiometricsSupp() &&
                      !await AuthService().checkBiometricsEnabled() &&
                      isBiometricsEnabled == false) {
                    OpenSettings.openBiometricEnrollSetting();
                  }
                }),
          ),
          const Divider(
            height: 1,
            color: Colors.grey,
          ),
          menuItem(
            id: -1,
            title: 'Logout',
            icon: FontAwesomeIcons.powerOff,
            selected: currentPage == DrawerSections.logout ? true : false,
          ),
        ],
      ),
    );
  }

  Widget menuItem(
      {required IconData icon,
      required String title,
      required int id,
      bool soon = false,
      required bool selected}) {
    return Material(
      color: selected ? Colors.grey.shade300 : Colors.transparent,
      child: InkWell(
        onTap: () async {
          Navigator.pop(context);
          bool? loggedout;

          setState(() {
            if (id == 0) {
              currentPage = DrawerSections.dashboard;
            } else if (id == 1) {
              currentPage = DrawerSections.check;
            } else if (id == 2) {
              currentPage = DrawerSections.profile;
            } else if (id == 3) {
              currentPage = DrawerSections.leave;
            } else if (id == 4) {
              currentPage = DrawerSections.locationRequest;
            } else if (id == 5) {
              currentPage = DrawerSections.exitPermissionRequest;
            } else if (id == 6) {
              currentPage = DrawerSections.loanRequest;
            } else if (id == -1) {
              AuthServiceAPI.logout().then((value) {
                loggedout = value;
                if (loggedout == true) {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoadingScreen()));
                }
              });
            }
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Expanded(
                  child: Icon(
                icon,
                size: 20,
                color: Colors.black,
              )),
              Expanded(
                  flex: 4,
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 15.0, color: Colors.black),
                  )),
              Expanded(
                  flex: 1,
                  child: Text(
                    soon == true ? 'soon' : '',
                    style: const TextStyle(fontSize: 12.0, color: Colors.red),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

enum DrawerSections {
  check,
  dashboard,
  profile,
  leave,
  locationRequest,
  exitPermissionRequest,
  loanRequest,
  logout,
}
