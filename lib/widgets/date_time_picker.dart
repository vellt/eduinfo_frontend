import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DateTimePicker extends StatelessWidget {
  DateTimePicker({
    super.key,
    required this.initialDateTime,
    required this.onDateTimeChanged,
    required this.mode,
    required this.height,
  });

  final DateTime initialDateTime;
  Function(DateTime) onDateTimeChanged;
  CupertinoDatePickerMode mode;
  double height;
  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(
                    border: Border.all(
                        color: Color.fromARGB(255, 255, 255, 255),
                        width: 0.5)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 0, vertical: 14),
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(29),
                    ),
                    child: SizedBox(
                      height: height,
                      child: CupertinoDatePicker(
                                    initialDateTime: initialDateTime,
    
                                    mode: mode,
                                    dateOrder: DatePickerDateOrder.ymd,
    
                                    use24hFormat: true,
                                    onDateTimeChanged: onDateTimeChanged,
                                  ),
                    ),
                              ),
                  
                ),
              );
  }
}