import 'package:flutter/material.dart';
import '../models/event.dart';

class TaskList extends StatelessWidget {
  final List<Event> tasks;
  final void Function(Event) onDismissed;

  const TaskList({
    super.key,
    required this.tasks,
    required this.onDismissed,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      return const Center(child: Text('No tasks for this day.'));
    }

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Dismissible(
          key: Key('${task.title}-$index'),
          direction: DismissDirection.endToStart,
          onDismissed: (_) => onDismissed(task),
          background: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: const Icon(Icons.delete, color: Colors.white),
          ),
          child: ListTile(
            title: Text(task.title),
          ),
        );
      },
    );
  }
}

