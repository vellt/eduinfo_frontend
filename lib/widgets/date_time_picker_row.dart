import 'package:eduinfo/widgets/date_time_picker_text.dart';
import 'package:flutter/material.dart';

class DateTimePickerRow extends StatelessWidget {
  DateTimePickerRow({
    super.key,
    required this.row
  });
  List<DateTimePickerText> row;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Color.fromARGB(255, 235, 235, 235),
          width: 0.5)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            child: Row(
              children: [
                row[0],
                SizedBox(width: 10),
                row[1]
        ],
      ),
    ));
  }
}