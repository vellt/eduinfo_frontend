import 'package:flutter/material.dart';

class SentMessageBox extends StatelessWidget {
  SentMessageBox({
    super.key,
    required this.message,
    required this.formattedDate,
  });
  String message;
  String formattedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 100, right: 20, top: 0, bottom: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 35, vertical: 16),
            decoration: BoxDecoration(
              color: Color(0xFF17A436),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(29), 
                topRight: Radius.circular(29),
                bottomLeft: Radius.circular(29),
                bottomRight: Radius.circular(0),
              ),
            ),
            child: Text(
              message,
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
          SizedBox(height: 5,),
          Text(formattedDate, style: TextStyle(color: Colors.grey,))
        ],
      ),
    );
  }
}