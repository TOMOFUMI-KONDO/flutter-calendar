import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/CreateSchedule.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: themePrimarySwatch,
      ),
      initialRoute: '/create',
      routes: {'/create': (context) => CreateSchedule()},
    );
  }
}
