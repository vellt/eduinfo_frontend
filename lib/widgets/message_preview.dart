import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagePreview extends StatelessWidget {
  MessagePreview({
    super.key,
    required this.image,
    required this.name,
    required this.message,
    required this.formattedDate,
    required this.dontAnswered,
    required this.onPressed,
  });

  String image;
  String name;
  String message;
  String formattedDate;
  bool dontAnswered;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
          padding: EdgeInsets.zero,
          onPressed:onPressed,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromARGB(255, 235, 235, 235),
                width: 0.5,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
              child:Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: image, 
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                        placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                    ),
                    SizedBox(width: 20), // Távolság a kép és a szöveg között
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(name,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)),
                                  SizedBox(height: 5,),
                          Row(
                            children: [
                              (dontAnswered)?Padding(
                                padding: EdgeInsets.only(right: 10, left: 4),
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    color: Color(0xFF17A436)
                                  ),
                                ),
                              ):Container(),
                              Expanded(
                                child: Text(message,
    style: TextStyle(
        fontSize: 16,overflow: TextOverflow.ellipsis, fontWeight: FontWeight.normal, color:Colors.grey)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Text(formattedDate, style: TextStyle(color: Colors.grey, fontSize: 14),),
                  ],
                ),
            ),
          ),
        );
  }
}