import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../models/event.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/task_list.dart';
import '../widgets/add_task_dialog.dart';
import '../pages/home_page.dart';
import '../models/event_manager.dart';
import 'dart:async';

class TaskPage extends StatefulWidget {
  const TaskPage({super.key});

  @override
  State<TaskPage> createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  final DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  final EventManager _eventManager = EventManager();
  DateTime _currentTime = DateTime.now();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        setState(() {
          _currentTime = DateTime.now();
        });
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
      _selectedDay!.year,
      _selectedDay!.month,
      _selectedDay!.day,
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
      appBar: AppBar(title: const Text('Task Calendar')),
      body: Column(
        children: [
          const SizedBox(height: 16),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task List takes most of the space
                Expanded(
                  flex: 4,
                  child: TaskList(tasks: _getEventsForDay(_selectedDay!)),
                ),

                // Clock on the right
                Container(
                  padding: const EdgeInsets.all(16),
                  alignment: Alignment.topCenter,
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
          ElevatedButton(
            child: const Text('Open Second Route'),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage()),
              );
            },
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

class SecondRoute extends StatelessWidget {
  const SecondRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Route')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Go Back'),
        ),
      ),
    );
  }
}
