import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar/screens/homepage_screen.dart';
import 'package:flutter_calendar/screens/login_screen.dart';
import 'package:flutter_calendar/screens/registration_screen.dart';
import 'package:flutter_calendar/screens/schedule_screen.dart';
import 'constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: themePrimarySwatch,
      ),
      initialRoute: RegistrationScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        ScheduleScreen.id: (context) => ScheduleScreen(),
        HomepageScreen.id: (context) => HomepageScreen(),
      },
    );
  }
}
