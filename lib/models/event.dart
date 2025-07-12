class Event {
  final String title;
  Event(this.title);
  
  @override  
  String toString() => title;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Event && title == other.title;

  @override
  int get hashCode => title.hashCode;

}

