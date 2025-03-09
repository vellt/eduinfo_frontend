import 'package:eduinfo/widgets/row_svg_button.dart';
import 'package:flutter/material.dart';

class PersonHomeEvents extends StatelessWidget {
  PersonHomeEvents({
    super.key,
    required this.allEventsOnPressed,
    required this.events,
  });
  Function() allEventsOnPressed;
  List<Widget> events;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 235, 235, 235),
          width: 0.5,
        ),
      ),
      child: Column(
        children: [
          if(events.length!=0)
          RowSvgButton(
            text: "Közelgő események", 
            image: "assets/images/calendar.svg",
            onPressed: allEventsOnPressed,
          ),
          SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...events,
                SizedBox(width: 15),
              ],
            ),
          ),
        ],
      ),
    );
  }
}