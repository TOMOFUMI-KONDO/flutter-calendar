import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utils.dart';

class EditScheduleScreen extends StatefulWidget {
  final String scheduleId;

  EditScheduleScreen(this.scheduleId, {Key key}) : super(key: key);

  @override
  _EditScheduleScreenState createState() => _EditScheduleScreenState();
}

class _EditScheduleScreenState extends State<EditScheduleScreen> {
  FirebaseFirestore _firestore;
  TextEditingController _titleController;
  DateTime _start;
  DateTime _end;

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  Future<void> _initialize() async {
    await Firebase.initializeApp();

    _firestore = FirebaseFirestore.instance;

    final DocumentSnapshot schedule = await _firestore
        .collection('users')
        .doc('mXO6v2waMTxXG18TRpmQ')
        .collection('schedules')
        .doc(widget.scheduleId)
        .get();

    Map<String, dynamic> scheduleData = schedule.data();

    final String title = scheduleData['title'];

    final Map<String, dynamic> startMap = scheduleData['start'];
    final DateTime start = new DateTime(startMap['year'], startMap['month'],
        startMap['day'], startMap['hour'], startMap['minute']);

    final Map<String, dynamic> endMap = scheduleData['end'];
    final DateTime end = new DateTime(endMap['year'], endMap['month'],
        endMap['day'], endMap['hour'], endMap['minute']);

    setState(() {
      _titleController = TextEditingController(text: title);
      _start = start;
      _end = end;
    });
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
    await FirebaseFirestore.instance
        .collection('users')
        .doc('mXO6v2waMTxXG18TRpmQ')
        .collection('schedules')
        .doc(widget.scheduleId)
        .update({
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
                content: Text('変更を保存しました。'),
                actions: <Widget>[
                  FlatButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(context).pop())
                ]));
  }

  Future<void> _close() async {
    await showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: Text('変更を保存しますか？'), actions: <Widget>[
              FlatButton(
                child: Text('いいえ'),
                onPressed: () => Navigator.of(context)
                    .popUntil(ModalRoute.withName('/detail')),
              ),
              FlatButton(
                child: Text('はい'),
                onPressed: () async {
                  await _save();
                  Navigator.of(context).pushReplacementNamed('/detail');
                },
              )
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('予定の編集'),
        actions: <Widget>[
          FlatButton(
            child: Text('完了'),
            onPressed: () => _close(),
          )
        ],
      ),
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
    );
  }
}
