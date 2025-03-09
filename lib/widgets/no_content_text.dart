import 'package:flutter/material.dart';

class NoContentText extends StatelessWidget {
  NoContentText({
    super.key,
    required this.text
  });
  String text;

  @override
  Widget build(BuildContext context) {
    return Container(
       decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 235, 235, 235), width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Center(child: Text(text, style: TextStyle(color: Colors.grey, fontSize: 18),)),
      ));
  }
}