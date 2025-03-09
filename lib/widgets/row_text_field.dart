import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowTextField extends StatelessWidget {
  RowTextField({
    super.key,
    required this.controller,
    this.obscureText,
    required this.hintText,
    this.icon,
    this.textInputType,
    this.focusNode,
  });

  TextEditingController controller;
  bool? obscureText;
  String hintText;
  IconData? icon;
  TextInputType? textInputType;
  FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromARGB(255, 235, 235, 235),
              width: 0.5)),
      child: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Container(
          padding:
              EdgeInsets.symmetric(horizontal: (icon==null)?15:10, vertical: 0),
          decoration: BoxDecoration(
            color: Color(0xFFF1F1F1),
            borderRadius: BorderRadius.circular(29),
          ),
          child: TextField(
            obscureText: obscureText??false,
            keyboardType: textInputType,
            focusNode: focusNode,
            controller: controller,
            style: TextStyle(
              fontWeight: FontWeight.normal,
              
            ),
            decoration: InputDecoration(
              prefixIcon: icon==null?null:Icon(icon),
              prefixIconColor: Colors.grey,
              contentPadding: EdgeInsets.all(11.5),
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.grey),
              border: InputBorder.none,

            ),
          ),
        ),
      ),
    );
  }
}

