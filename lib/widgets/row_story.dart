import 'package:cached_network_image/cached_network_image.dart';
import 'package:eduinfo/widgets/flat_bordered_button.dart';
import 'package:flutter/material.dart';

class RowStory extends StatelessWidget {
  RowStory({
    super.key,
    this.onLikePressed,
    required this.likeCount,
    required this.institutionName,
    required this.formattedDate,
    required this.textContent,
    required this.avatarImage,
    this.imageContent,
    required this.liked,
  });

  Function()? onLikePressed;
  int likeCount;
  String institutionName;
  String avatarImage;
  String formattedDate;
  String textContent;
  String? imageContent;
  bool liked;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(
              color: Color.fromARGB(255, 202, 202, 202),
              width: 0.5)),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 25),
              child: ListTile(
                contentPadding: EdgeInsets.all(0),
                leading:  ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: CachedNetworkImage(
                        imageUrl: avatarImage, 
                        width: 35,
                        height: 35,
                        fit: BoxFit.cover,
                        placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
                ),
                title: Text(institutionName, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
                trailing: Text(formattedDate, style: TextStyle(color: Colors.grey),),
              ),
            ),
            Divider(
              height: 0.2,
              color: Color.fromARGB(255, 202, 202, 202),
              thickness: 0.5,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
              child: Text(textContent,textAlign: TextAlign.start,style: TextStyle(color: Colors.black54, fontSize: 14) ),
            ),
            imageContent!=null? Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                        imageUrl: imageContent!, 
                        fit: BoxFit.cover,
                        placeholder: (context, url)=>Center(child: SizedBox(width: 25,height: 25,child: CircularProgressIndicator())),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      )
              ),
            ):Container(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlatBorderedButton(
                    text: "Tetszik",
                    width: 60,
                    color: liked==true?Color(0xFF17A436):null,
                    disable: onLikePressed==null,
                    onPressed: onLikePressed==null?(){}: onLikePressed!,
                  ),
                  Row(
                    children: [
                      Icon(Icons.favorite, color: Color(0xFF17A436),size: 20,),
                      SizedBox(width: 5,),
                      Text(likeCount.toString(), style: TextStyle(
                        color: Color(0xFF17A436)
                      ),),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ));
  }
}
