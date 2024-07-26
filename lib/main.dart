import 'package:flutter/material.dart';
import 'package:weather_app/core/theme/my_theme.dart';
import 'package:weather_app/presentation/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: MyTheme.lightmode,
      darkTheme: MyTheme.darkmode,
      home: const SplashScreen(),
    );
  }
}
