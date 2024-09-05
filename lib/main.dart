import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/workout_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => WorkoutProvider(),
      child: MaterialApp(
        title: 'Fitness Tracker',
        theme: ThemeData(
          primaryColor: Color(0xFF5C6BC0),
          scaffoldBackgroundColor: Colors.grey[100],
          appBarTheme: AppBarTheme(
            color: Color(0xFF5C6BC0),
            elevation: 0,
          ),
          textTheme: TextTheme(
            headlineMedium: TextStyle(
              color: Color(0xFF333333),
              fontWeight: FontWeight.bold,
            ),
            bodyMedium: TextStyle(color: Color(0xFF666666)),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFFF4081),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
