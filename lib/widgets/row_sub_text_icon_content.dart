import 'package:flutter/material.dart';

class RowSubTextIconContent extends StatelessWidget {
  RowSubTextIconContent({
    super.key,
    required this.icon,
    required this.title
  });

  IconData icon;
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: const Color.fromARGB(255, 235, 235, 235), width: 0.5)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: ListTile(
                leading: Icon(icon, color: Colors.grey,size: 22,),
                title:  Text(title,
    style:
        TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey),),
              ),
            ),
          );
  }
}