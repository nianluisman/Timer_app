import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/event.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/task_list.dart';
import '../widgets/add_task_dialog.dart';
import 'CalanderPage.dart';
import '../models/event_manager.dart';
import 'dart:async';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final DateTime _focusedDay = DateTime.now();
  late DateTime _selectedDay;
  final EventManager _eventManager = EventManager();
  DateTime _currentTime = DateTime.now();
  Timer? _timer;
   int _selectedIndex = 0;
   // List of pages
  final List<Widget> _pages = [
    HomePage(),
    CalanderPage(),
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update index to switch views
    });
  }

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _currentTime = DateTime.now();
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  List<Event> _getEventsForDay(DateTime day) {
    return _eventManager.getEventsForDay(day);
  }

  void _addEvent(String title) {
    final date = DateTime(
      _selectedDay.year,
      _selectedDay.month,
      _selectedDay.day,
    );
    setState(() {
      _eventManager.addEvent(date, Event(title));
    });
  }

  String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}:${time.second.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task List
                Expanded(
                  flex: 2,
                  child: TaskList(
                    tasks: _getEventsForDay(_selectedDay),
                    onDismissed: (event) {
                      setState(() {
                        final date = DateTime(
                          _selectedDay.year,
                          _selectedDay.month,
                          _selectedDay.day,
                        );
                        _eventManager.removeEvent(date, event);
                      });
                    },
                  ),
                ),
                // Clock Display
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.topCenter,
                  color: const Color.fromARGB(255, 84, 118, 134),
                  child: Text(
                    _formatTime(_currentTime),
                    style: const TextStyle(
                      fontSize: 120,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          
          ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTaskDialog(context, _addEvent),
        child: const Icon(Icons.add),
      ),
    );
  }
}
