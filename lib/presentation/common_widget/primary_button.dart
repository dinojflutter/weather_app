import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {super.key,
      required this.title,
      required this.onpressed,
      required this.btmcolors,
      required this.txtcolors});

  final String title;
  final VoidCallback onpressed;
  final Color btmcolors;
  final Color txtcolors;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width - 20,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18), color: btmcolors),
        child: Center(
            child: Text(
          title,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: txtcolors),
        )),
      ),
    );
  }
}
