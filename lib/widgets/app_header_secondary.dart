import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppHeaderSecondary extends StatelessWidget {
  AppHeaderSecondary({
    super.key,
    required this.text,
    required this.backPressed,
    this.actions,
    this.image
  });
  String text;
  List<Widget>? actions;
  Function() backPressed;
  String? image;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border(bottom: BorderSide(color: Color.fromARGB(255, 235, 235, 235), width: 0.5))),
      child: Padding(
        padding: EdgeInsets.only(right: 25, left: 25, bottom: 12, top: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                IconButton(onPressed: backPressed, icon: Icon(Icons.arrow_back_ios_new)),
                if(image!=null)
                 ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                   child: CachedNetworkImage(
                          imageUrl: image!, 
                          width: 35,
                          height: 35,
                          fit: BoxFit.cover,
                          placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                 ),
                SizedBox(width: 10),
                Text(text, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900))
              ],
            ),
            if (actions!=null)Row(children: actions!),
          ],
        ),
      ),
    );
  }
}