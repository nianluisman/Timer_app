import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/event.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/task_list.dart';
import '../widgets/add_task_dialog.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final Map<DateTime, List<Event>> _events = {};

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _events[DateTime(day.year, day.month, day.day)] ?? [];
  }
  void _addEvent(String title) {
    final date = DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day);
    setState(() {
      if (_events[date] != null) {
        _events[date]!.add(Event(title));
      } else {
        _events[date] = [Event(title)];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Task Calendar')),
      body: Column(
        children: [
          CalendarWidget(
            focusedDay: _focusedDay,
            selectedDay: _selectedDay,
            calendarFormat: _calendarFormat,
            onDaySelected: (selected, focused) {
              setState(() {
                _selectedDay = selected;
                _focusedDay = focused;
              });
            },
            onFormatChanged: (format) {
              setState(() => _calendarFormat = format);
            },
            eventLoader: _getEventsForDay,
          ),
          const SizedBox(height: 16),
          Expanded(child: TaskList(tasks: _getEventsForDay(_selectedDay!))),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskDialog(context, _addEvent),
        child: const Icon(Icons.add),
      ),
    );
  }
}
