import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/workout.dart';
import '../models/goal.dart';

class WorkoutProvider with ChangeNotifier {
  List<Workout> _workouts = [];
  List<Goal> _goals = [];

  List<Workout> get workouts => _workouts;
  List<Goal> get goals => _goals;

  WorkoutProvider() {
    _loadWorkouts();
    _loadGoals();
  }

  void addWorkout(Workout workout) {
    _workouts.add(workout);
    _saveWorkouts();
    notifyListeners();
  }

  void addGoal(Goal goal) {
    _goals.add(goal);
    _saveGoals();
    notifyListeners();
  }

  void _saveWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final workoutsJson = jsonEncode(_workouts.map((w) => w.toMap()).toList());
    await prefs.setString('workouts', workoutsJson);
  }

  void _loadWorkouts() async {
    final prefs = await SharedPreferences.getInstance();
    final workoutsJson = prefs.getString('workouts');
    if (workoutsJson != null) {
      final List<dynamic> decoded = jsonDecode(workoutsJson);
      _workouts = decoded.map((w) => Workout.fromMap(w)).toList();
      notifyListeners();
    }
  }

  void _saveGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final goalsJson = jsonEncode(_goals.map((g) => g.toMap()).toList());
    await prefs.setString('goals', goalsJson);
  }

  void _loadGoals() async {
    final prefs = await SharedPreferences.getInstance();
    final goalsJson = prefs.getString('goals');
    if (goalsJson != null) {
      final List<dynamic> decoded = jsonDecode(goalsJson);
      _goals = decoded.map((g) => Goal.fromMap(g)).toList();
      notifyListeners();
    }
  }

  double calculateGoalProgress(Goal goal) {
    int totalDuration = _workouts
        .where((w) =>
            w.type == goal.type &&
            w.date.isAfter(goal.startDate) &&
            w.date.isBefore(goal.endDate))
        .fold(0, (sum, workout) => sum + workout.duration);
    return totalDuration / goal.target;
  }
}
