import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppHeaderPrimary extends StatelessWidget {
  AppHeaderPrimary({
    super.key,
    required this.title,
    this.onLogout,
  });

  String title;
  Function()? onLogout;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                color: Color.fromARGB(255, 235, 235, 235), width: 0.5)),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 25, left: 25, bottom: 20, top: 0),
        child: Row(
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover, // Adjust the image fit
            ),
            SizedBox(width: 20),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
            ),
            onLogout == null
                ? Container()
                : CupertinoButton(
                    onPressed: onLogout,
                    child: Icon(Icons.logout, color: Color(0xFF17A436),), 
                    padding: EdgeInsets.zero,
                    minSize: 40,
                  ),
          ],
        ),
      ),
    );
  }
}
