import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EditAvatarImage extends StatelessWidget {
  EditAvatarImage({
    super.key,
    required this.title,
    required this.onPressed,
    required this.image,
  });

  String title;
  String image;
  Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(color: const Color.fromARGB(255, 235, 235, 235), width: 0.5)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,style:TextStyle(fontSize: 18, fontWeight: FontWeight.normal),),
              SizedBox(height: 10,),
              CupertinoButton(
                onPressed: onPressed,
                child: Align(
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      ClipRRect(borderRadius:BorderRadius.circular(100),child:  CachedNetworkImage(
                        imageUrl: image, 
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                        placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )),
                      Container(
                        height: 50,
                        width: 50,
                        child: Icon(Icons.edit,color: Colors.white,),
                        decoration: BoxDecoration(color: Color(0xFF17A436), borderRadius: BorderRadius.circular(50)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
      ),
    );
  }
}