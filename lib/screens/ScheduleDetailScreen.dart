import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../utils.dart';
import 'EditScheduleScreen.dart';

class ScheduleDetailScreen extends StatefulWidget {
  final String scheduleId;

  ScheduleDetailScreen(this.scheduleId, {Key key}) : super(key: key);

  @override
  _ScheduleDetailScreenState createState() => _ScheduleDetailScreenState();
}

class _ScheduleDetailScreenState extends State<ScheduleDetailScreen> {
  FirebaseFirestore _firestore;
  String _title;
  DateTime _start;
  DateTime _end;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  Future<void> initialize() async {
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
      _title = title;
      _start = start;
      _end = end;
    });
  }

  void _toEdit() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => (EditScheduleScreen(widget.scheduleId))));
  }

  Future<void> _delete() async {
    await _firestore
        .collection('users')
        .doc('mXO6v2waMTxXG18TRpmQ')
        .collection('schedules')
        .doc(widget.scheduleId)
        .delete();

    await showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
                content: Text('予定を削除しました。'),
                actions: <Widget>[
                  FlatButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text('OK'))
                ]));
  }

  void _showDeleteDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertDialog(content: Text('この予定を削除しますか？'), actions: <Widget>[
              FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text('キャンセル')),
              FlatButton(
                  onPressed: () async {
                    await _delete();
                    Navigator.of(context).pop();
                  },
                  child: Text('削除する'))
            ]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _toEdit(),
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: () => _showDeleteDialog(),
            )
          ],
        ),
        body: Container(
          child: Column(
            children: <Widget>[
              Text(_title ?? ''),
              Text(_start != null ? formatDateTime(_start) : ''),
              Text(_end != null ? formatDateTime(_end) : ''),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
          ),
          constraints: BoxConstraints.expand(),
        ));
  }
}
