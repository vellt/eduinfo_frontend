import 'package:flutter/material.dart';

class DateTimePickerText extends StatelessWidget {
  DateTimePickerText({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
  });

  Function() onPressed;
  IconData icon;
  String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 15),
          decoration: BoxDecoration(
            color: Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(29),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(text, style: TextStyle(fontSize: 17),),
              SizedBox(width: 10,),
              Icon(icon, size: 20,),
          ],
          ),
        ),
      ),
    );
  }
}