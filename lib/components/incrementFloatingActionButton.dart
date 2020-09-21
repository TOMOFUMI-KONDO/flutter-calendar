import 'package:flutter/material.dart';

Widget incrementFloatingActionButton(Function function) {
  return FloatingActionButton(
    onPressed: function,
    tooltip: 'Increment',
    child: Icon(Icons.add),
  );
}
