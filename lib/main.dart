import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/CreateScheduleScreen.dart';
import 'screens/EditScheduleScreen.dart';
import 'screens/ScheduleDetailScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: themePrimarySwatch,
      ),
      initialRoute: '/detail',
      routes: {
        '/create': (context) => CreateScheduleScreen(),
        '/detail': (context) => ScheduleDetailScreen('Lb9OaEcSQahu5n7wgEjn'),
        '/edit': (context) => EditScheduleScreen('')
      },
    );
  }
}
