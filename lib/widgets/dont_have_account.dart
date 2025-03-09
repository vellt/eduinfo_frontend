import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DontHaveAccount extends StatelessWidget {
  DontHaveAccount({
    super.key,
    required this.onPressed,
  });

  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromARGB(255, 235, 235, 235),
              width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Még nincs fiókod?',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey[700], // Gray color
              ),
            ),
            CupertinoButton(
              onPressed:onPressed,
              child: Text(
                'Készíts egyet',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.green, // Green color for the link
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

