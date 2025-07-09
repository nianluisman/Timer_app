import '../models/event.dart';

class EventManager {
  static final EventManager _instance = EventManager._internal();

  factory EventManager() => _instance;

  EventManager._internal();

  final Map<DateTime, List<Event>> _events = {};

  Map<DateTime, List<Event>> get events => _events;

  List<Event> getEventsForDay(DateTime day) {
    final date = DateTime(day.year, day.month, day.day);
    return _events[date] ?? [];
  }

  void addEvent(DateTime day, Event event) {
    final date = DateTime(day.year, day.month, day.day);
    if (_events[date] != null) {
      _events[date]!.add(event);
    } else {
      _events[date] = [event];
    }
  }
}