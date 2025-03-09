
import 'package:eduinfo/widgets/event_header.dart';
import 'package:eduinfo/widgets/flat_bordered_button.dart';
import 'package:flutter/material.dart';

class RowEvent extends StatelessWidget {
  RowEvent({
    super.key,
    required this.title,
    required this.coverImage,
    required this.avatarImage,
    required this.month,
    required this.day,
    required this.formattedTimeInterval,
    required this.onPressed,
    this.padding,
  });

  String title;
  String coverImage;
  String avatarImage;
  String month;
  String day;
  String formattedTimeInterval;
  Function() onPressed;
  EdgeInsetsGeometry? padding;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  padding?? EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                  color: Color.fromARGB(255, 202, 202, 202),
                  width: 0.5)),
          child: Column(
            children: [
              EventHeader(coverImage: coverImage, avatarImage: avatarImage, month: month, day: day),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title==""?"Névtelen esemény":title, style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16
                        ),),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            Icon(Icons.access_time, size: 17,color: Colors.grey,),
                            SizedBox(width: 5,),
                            Text(formattedTimeInterval, style: TextStyle(color: Colors.grey, fontSize: 15),)
                          ],
                        )
                      ],
                    ),
                  ),
                  
                ],
              )
            ],
          )),
      ),
    );
  }
}
