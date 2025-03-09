
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FlatBorderedButton extends StatelessWidget {
  FlatBorderedButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.disable,
    this.color
  });

  String text;
  Function() onPressed;
  double? width;
  bool? disable;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      minSize: 0,
      padding: EdgeInsets.zero,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(
            color: color??Color.fromARGB(255, 202, 202, 202), // Keret színe
            width: 1.5, // Keret vastagsága,

          ),
          borderRadius: BorderRadius.circular(8), // Lekerekítés
          color: color??Colors.white,
        ),
        child: width==null? Text(
            text,
            style: TextStyle(color: (disable==true)?Colors.grey:(color!=null)?Colors.white: Colors.black, fontSize: 14),
          ): SizedBox(
          width: width!,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(color: (disable==true)?Colors.grey: (color!=null)?Colors.white:Colors.black, fontSize: 14),
          ),
        ),
      ),
      onPressed: (disable==true)?null:onPressed,
    );
  }
}