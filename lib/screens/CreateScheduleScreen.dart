import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class CreateScheduleScreen extends StatefulWidget {
  CreateScheduleScreen({Key key}) : super(key: key);

  @override
  _CreateScheduleScreenState createState() => _CreateScheduleScreenState();
}

class _CreateScheduleScreenState extends State<CreateScheduleScreen> {
  FirebaseFirestore _firestore;
  final _titleController = TextEditingController();
  DateTime _start = DateTime.now();
  DateTime _end = DateTime.now().add(Duration(hours: 1));

  @override
  void initState() {
    Firebase.initializeApp();
    _firestore = FirebaseFirestore.instance;
    super.initState();
  }

  Future<void> _handlePressStart(BuildContext context) async {
    final DateTime ymd = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (ymd == null) return;

    final TimeOfDay hm =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (hm == null) return;

    DateTime dateTime =
        new DateTime(ymd.year, ymd.month, ymd.day, hm.hour, hm.minute);

    setState(() {
      _start = dateTime;
    });
  }

  Future<void> _handlePressEnd(BuildContext context) async {
    final DateTime ymd = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    if (ymd == null) return;

    final TimeOfDay hm =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (hm == null) return;

    DateTime dateTime =
        new DateTime(ymd.year, ymd.month, ymd.day, hm.hour, hm.minute);

    setState(() {
      _end = dateTime;
    });
  }

  Future<void> _save() async {
    await _firestore
        .collection('users')
        .doc('mXO6v2waMTxXG18TRpmQ')
        .collection('schedules')
        .add({
      'title': _titleController.text,
      'start': {
        'year': _start.year,
        'month': _start.month,
        'day': _start.day,
        'hour': _start.hour,
        'minute': _start.minute,
      },
      'end': {
        'year': _end.year,
        'month': _end.month,
        'day': _end.day,
        'hour': _end.hour,
        'minute': _end.minute,
      }
    }).catchError((error) => print("Failed to add schedule: $error"));

    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                title: const Text("登録完了"),
                content: Text("カレンダーに「${_titleController.text}」を追加しました。"),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'))
                ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('予定の作成')),
      body: Container(
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
            ),
            FlatButton(
              onPressed: () => _handlePressStart(context),
              child: Text("予定開始時刻：　" + formatDateTime(_start)),
            ),
            FlatButton(
              onPressed: () => _handlePressEnd(context),
              child: Text("予定終了時刻：　" + formatDateTime(_end)),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _save(), child: Icon(Icons.save)),
    );
  }
}
