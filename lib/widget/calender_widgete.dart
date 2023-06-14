import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/provider/todos.dart';
import '/widget/todo_widget.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderWidget extends StatelessWidget {
  CalenderWidget({ required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: SfCalendar(
        view: CalendarView.month,
      ),
    ));
  }
}


class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Appointment> source) {
    appointments = source;
  }
}
