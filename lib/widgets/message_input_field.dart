import 'package:flutter/material.dart';

class MessageInputField extends StatelessWidget {
  MessageInputField({
    super.key,
    required this.textEditingController,
    required this.onPressed,
  });
  TextEditingController textEditingController;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 235, 235, 235),
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 25),
        child: Row(
          children: [
            Flexible(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
                decoration: BoxDecoration(
                  color: Color(0xFFF1F1F1),
                  borderRadius: BorderRadius.circular(29),
                ),
                child: TextField(
                  controller: textEditingController,
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                  ),
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(11.5),
                    hintText: "Üzenet küldése",
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            IconButton(
              onPressed: onPressed,
              icon: Icon(Icons.send, color: Color(0xFF17A436),size: 30,),
            ),
          ],
        ),
      ),
    );
  }
}
