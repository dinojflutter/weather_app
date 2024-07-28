import 'package:flutter/material.dart';

class MainText extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  const MainText({
    super.key,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
