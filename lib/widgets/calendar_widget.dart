import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/event.dart';
import '../utils/utils.dart';


class CalendarWidget extends StatelessWidget {
  final DateTime focusedDay;
  final DateTime? selectedDay;
  final CalendarFormat calendarFormat;
  final Function(DateTime, DateTime) onDaySelected;
  final Function(CalendarFormat) onFormatChanged;
  final List<Event> Function(DateTime) eventLoader;

  const CalendarWidget({
    super.key,
    required this.focusedDay,
    required this.selectedDay,
    required this.calendarFormat,
    required this.onDaySelected,
    required this.onFormatChanged,
    required this.eventLoader,
  });

  @override
  Widget build(BuildContext context) {
return TableCalendar<Event>(
  firstDay: kFirstDay,
  lastDay: kLastDay,
  focusedDay: focusedDay,
  calendarFormat: calendarFormat,
  selectedDayPredicate: (day) => isSameDay(selectedDay, day),
  onDaySelected: onDaySelected,
  onFormatChanged: onFormatChanged,
  onPageChanged: (_) {},
  eventLoader: eventLoader, 
);
  }
}

