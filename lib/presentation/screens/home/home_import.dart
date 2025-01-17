import "dart:ui";

import "package:flutter/material.dart";
import "package:flutter/widgets.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:geolocator/geolocator.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:velocity_bloc/cubit/velocity_cubit/velocity_cubit.dart";
import "package:weather_app/data/repositories/repository.dart";
import "package:weather_app/presentation/common_widget/primary_button.dart";
import "package:weather_app/presentation/screens/home/home_model.dart";
import "package:weather_app/presentation/screens/splash_screen.dart";

import "../../../core/constant/my_color.dart";
import "../../common_widget/temp_text.dart";

part 'home_page.dart';
part 'home_view_model.dart';
