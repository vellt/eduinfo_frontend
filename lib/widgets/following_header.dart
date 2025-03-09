import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FollowingHeader extends StatelessWidget {
  FollowingHeader({
    super.key,
    required this.name,
    required this.email,
    required this.followerCount,
    required this.image,
    required this.onPressed,
  });
  String name;
  String email;
  int followerCount;
  String image;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(255, 235, 235, 235),
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        child: ListTile(
      title: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
              imageUrl: image, 
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
              errorWidget: (context, url, error) => Icon(Icons.error),
            )
          ),
          SizedBox(width: 20), // Távolság a kép és a szöveg között
          Expanded( // Hely korlátozása a szövegnek
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis, // Ellipsis hozzáadása
                  maxLines: 1, // Maximum 1 sor megengedett
                ),
                Text(
                  email,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis, // Ellipsis hozzáadása
                    fontSize: 14,
                    color: Color(0xFF828384),
                  ),
                  maxLines: 1, // Maximum 1 sor megengedett
                ),
              ],
            ),
          ),
        ],
      ),
      trailing: Padding(
        padding: EdgeInsets.only(right: 15),
        child: CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                followerCount.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Text(
                "Követések",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
      contentPadding: EdgeInsets.zero,
    ),
    
      ),
    );
  }
}