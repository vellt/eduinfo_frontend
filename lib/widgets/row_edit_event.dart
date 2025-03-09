
import 'package:eduinfo/widgets/event_header.dart';
import 'package:eduinfo/widgets/flat_bordered_button.dart';
import 'package:flutter/material.dart';

class RowEditEvent extends StatelessWidget {
  RowEditEvent({
    super.key,
    required this.title,
    required this.coverImage,
    required this.avatarImage,
    required this.month,
    required this.day,
    required this.formattedTimeInterval,
    required this.onEditPressed,
    required this.onDeletePressed,
    required this.onPressed,
  });

  String title;
  String coverImage;
  String avatarImage;
  String month;
  String day;
  String formattedTimeInterval;
  Function() onEditPressed;
  Function() onDeletePressed;
  Function() onPressed;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: FlatBorderedButton(
                        text: "Szerkesztés",
                        width: 80,
                        onPressed: onEditPressed,
                        ),
                      ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 10),
                      child: SizedBox(
                        child: FlatBorderedButton(
                          text: "Törlés",
                          width: 80,
                          onPressed:onDeletePressed,
                        ),
                      ),
                    )
                    ],
                  )
                ],
              )
            ],
          )),
      ),
    );
  }
}
