import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/workout_provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class ProgressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);
    final workouts = workoutProvider.workouts;
    final goals = workoutProvider.goals;

    Map<String, int> workoutSummary = {};
    for (var workout in workouts) {
      workoutSummary.update(
        workout.type,
            (existing) => existing + workout.duration,
        ifAbsent: () => workout.duration,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text('Workout Summary',
                  style: Theme.of(context).textTheme.headlineMedium),
              SfCircularChart(
                series: <CircularSeries>[
                  PieSeries<MapEntry<String, int>, String>(
                    dataSource: workoutSummary.entries.toList(),
                    xValueMapper: (MapEntry<String, int> entry, _) => entry.key,
                    yValueMapper: (MapEntry<String, int> entry, _) =>
                    entry.value,
                    dataLabelSettings: DataLabelSettings(isVisible: true),
                  )
                ],
              ),
              SizedBox(height: 20),
              Text('Goals Progress',
                  style: Theme.of(context).textTheme.headlineMedium),
              ...goals.map((goal) => ListTile(
                title: Text(goal.type),
                subtitle: Text(
                    '${(workoutProvider.calculateGoalProgress(goal) * 100).toStringAsFixed(2)}% completed'),
                trailing: CircularProgressIndicator(
                  value: workoutProvider.calculateGoalProgress(goal),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}

