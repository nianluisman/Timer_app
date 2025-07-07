import 'package:flutter/material.dart';
import '../models/event.dart';

class TaskList extends StatelessWidget {
  final List<Event> tasks;

  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks for this day.'));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.check_circle_outline),
          title: Text(tasks[index].title),
        );
      },
    );
  }
}
