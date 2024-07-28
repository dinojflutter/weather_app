import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/theme/my_theme.dart';
import 'package:weather_app/data/repositories/weather_repo.dart';
import 'package:weather_app/presentation/screens/splash_screen.dart';

import 'data/repositories/repository.dart';

void main() {
  runApp(RepositoryProvider(
    create: (context) => Repository(
      weatherrepo: WeatherRepo(),
    ),
    child: const MyApp(),
  ));
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
