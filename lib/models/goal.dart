class Goal {
  final String type;
  final int target; // in minutes or repetitions
  final DateTime startDate;
  final DateTime endDate;

  Goal(
      {required this.type,
      required this.target,
      required this.startDate,
      required this.endDate});

  Map<String, dynamic> toMap() {
    return {
      'type': type,
      'target': target,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
    };
  }

  factory Goal.fromMap(Map<String, dynamic> map) {
    return Goal(
      type: map['type'],
      target: map['target'],
      startDate: DateTime.parse(map['startDate']),
      endDate: DateTime.parse(map['endDate']),
    );
  }
}
