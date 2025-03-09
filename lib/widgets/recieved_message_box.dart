import 'package:flutter/material.dart';

class RecievedMessageBox extends StatelessWidget {
  RecievedMessageBox({
    super.key,
    required this.message,
    required this.formattedDate,
  });
  String message;
  String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 80, top: 0, bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xFFF1F1F1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0), 
                topRight: Radius.circular(29),
                bottomLeft: Radius.circular(29),
                bottomRight: Radius.circular(29),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(fontSize: 16),
            ),
          ),
          SizedBox(height: 5,),
          Text(formattedDate, style: TextStyle(color: Colors.grey,))
        ],
      ),
    );
  }
}