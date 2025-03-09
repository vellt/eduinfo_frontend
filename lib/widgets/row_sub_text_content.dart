import 'package:flutter/material.dart';

class RowSubTextContent extends StatelessWidget {
  RowSubTextContent({
    super.key,
    required this.title
  });

  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
            decoration: BoxDecoration(
                border: Border(
    top: BorderSide(
      color: const Color.fromARGB(255, 235, 235, 235),
      width: 0.5,
    ),),),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 2),
              child: ListTile(
                title:  Text(title,
    style:
        TextStyle(fontSize: 17, fontWeight: FontWeight.normal, color: Colors.grey),),
              ),
            ),
          );
  }
}