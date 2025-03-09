import 'package:flutter/cupertino.dart';

class RowSpace extends StatelessWidget {
  const RowSpace({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 202, 202, 202),
                  width: 0.5)),
          child: null),
    );
  }
}