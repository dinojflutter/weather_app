import "package:flutter/material.dart";
import "package:weather_app/core/constant/my_color.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColor.primarycolor,
        title: const Text("data"),
      ),
    );
  }
}
