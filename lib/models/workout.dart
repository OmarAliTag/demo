class Workout {
  final String type;
  final DateTime date;
  final int duration; // in minutes

  Workout({required this.type, required this.date, required this.duration});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'date': date.toIso8601String(),
      'duration': duration,
    };
  }

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      type: map['type'],
      date: DateTime.parse(map['date']),
      duration: map['duration'],
    );
  }
}
