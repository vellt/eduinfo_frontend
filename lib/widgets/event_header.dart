import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class EventHeader extends StatelessWidget {
  EventHeader({
    super.key,
    required this.coverImage,
    required this.avatarImage,
    required this.month,
    required this.day,
  });
  String coverImage;
  String avatarImage;
  String month;
  String day;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        CachedNetworkImage(
          imageUrl: coverImage, 
          width: double.infinity,
          height: 100,
          fit: BoxFit.cover,
          placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Row(
          children: [
            SizedBox(width: 25,),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFFE72A7C),
                border: Border.all(
                  color: Color(0xFFE7E7E7),
                  width: 1), borderRadius: BorderRadius.circular(4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(month, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, ),),
                  Text(day, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 22),)
                ],
              ),
            ),
            SizedBox(width: 20,),
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Color(0xFFC9C9C9),
                  width: 1), borderRadius: BorderRadius.circular(4)),
              child: CachedNetworkImage(
                        imageUrl: avatarImage, 
                        fit: BoxFit.cover,
                        placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
            )
          ],
        )
      ],
    );
  }
}