import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduinfo/widgets/flat_bordered_button.dart';
import 'package:flutter/material.dart';

class publicHeader extends StatelessWidget {
  publicHeader({
    super.key,
    required this.avatarImage,
    required this.bannerImage,
    required this.title,
    required this.followers,
    this.onFollowing,
    this.onMessage,
    required this.followed,
  });

  String avatarImage;
  String bannerImage;
  String title;
  int followers;
  Function()? onFollowing;
  Function()? onMessage;
  bool followed;


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
            color: Color.fromARGB(255, 235, 235, 235),
            width: 0.5)),
      child: Column(
        children: [
          SizedBox(
            height: 170,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white, // Keret színe
                      width: 4.0, // Keret vastagsága
                    ),

                  ),
                  child:   CachedNetworkImage(
                        imageUrl: bannerImage, 
                        width: double.infinity,
                        height: 100,
                        fit: BoxFit.cover,
                        placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Color(0xFFE7E7E7), // Keret színe
                        width: 4.0, // Keret vastagsága
                      ),
                    ),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                        avatarImage,
                      ),
                      backgroundColor: Colors.white,
                      radius: 60,
                    ),
                  ),
                ),
              ]
            ),
          ),
          SizedBox(height: 10),
          Text(title,  style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
          SizedBox(height: 5),
          Text(followers.toString(),style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900)),
          Text("Követő"),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatBorderedButton(
                text: "Követés",
                width: 80,
                color:  followed==true?Color(0xFF17A436):null,
                disable: onFollowing==null,
                onPressed: onFollowing==null ? () { } : onFollowing!,
              ),
              SizedBox(width: 30,),
              FlatBorderedButton(
                text: "Üzenet",
                width: 80,
                disable: onMessage==null,
                onPressed: onMessage==null ? () { } : onMessage!,
              ),
            ],
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }
}