import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class HomepageScreen extends StatefulWidget {
  static String id = 'homepage_screen';

  @override
  _HomepageScreenState createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  DateTime _currentDate = DateTime.now();

  void onDayPressed(DateTime date, List<Event> events) {
    this.setState(() => _currentDate = date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('calendar'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //todo
          //Screen to decide the schedule pop up
        },
        child: Icon(Icons.add),
      ),
      body: Container(
        child: CalendarCarousel<Event>(
          onDayPressed: onDayPressed,
          todayButtonColor: Colors.white,
          todayBorderColor: Colors.red,
          todayTextStyle:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          daysHaveCircularBorder: false,
          markedDateShowIcon: true,
          markedDateMoreShowTotal: false,
          thisMonthDayBorderColor: Colors.grey,
          selectedDateTime: _currentDate,
          locale: 'JA',
          selectedDayBorderColor: Colors.red,
          selectedDayButtonColor: Colors.red,
          weekdayTextStyle: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
