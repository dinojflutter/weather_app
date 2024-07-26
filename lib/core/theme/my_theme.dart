import 'package:flutter/material.dart';

import '../constant/my_color.dart';

class MyTheme {
  MyTheme();
  static final lightmode = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: MyColor.primarycolor),
    useMaterial3: true,
  );

  //dark mode
  static final darkmode = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: MyColor.secondaryColor),
    useMaterial3: true,
  );
}
