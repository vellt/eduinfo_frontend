import 'package:flutter/material.dart';

class BigTextInput extends StatelessWidget {
  BigTextInput({
    super.key,
    required this.controller,
    required this.hintText,
  });
  TextEditingController controller;
  String hintText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(border: InputBorder.none,  hintText: hintText, hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400)),
        style: TextStyle(
          fontSize: 18,
          color: const Color.fromARGB(255, 90, 90, 90) 
        ),
        autofocus: true,
        maxLines: null,
        autocorrect: false,
        expands: true,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}
