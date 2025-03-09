import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowButton extends StatelessWidget {
  RowButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.color,
    this.isBordered=true,
  });
  Function() onPressed;
  String text;
  Color? color;
  bool isBordered;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: (isBordered==false)?BoxDecoration(
          border: Border(top: BorderSide(
            color: Color.fromARGB(255, 235, 235, 235),
                        width: 0.5)
                    ),)
            : BoxDecoration(
          border: Border.all(
              color: Color.fromARGB(255, 235, 235, 235),
              width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: CupertinoButton(
          color: color ?? Color(0xFF17A436),
          child: Text(text),
          onPressed: onPressed,
        ),
      ),
    );
  }
}