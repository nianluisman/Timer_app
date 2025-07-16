class Event {
  final String title;
  Event(this.title);
  
  @override  
  String toString() => title;

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is Event && title == other.title;

  Map<String, dynamic> toJson() => {
      'title': title,
    };


  factory Event.fromJson(Map<String, dynamic> json){
    return Event(json['title']);
  }

  @override
  int get hashCode => title.hashCode;

}

