import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowImageContent extends StatelessWidget {
  RowImageContent({
    super.key,
    required this.text,
    this.onPressed,
    required this.isAccepted,
    required this.isDisabled,
    required this.image,
    this.description,
    this.disableSecondLine,
  });
  final String text;
  final Function()? onPressed;
  bool isAccepted;
  bool isDisabled;
  String image;
  String? description;
  bool? disableSecondLine;

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      onPressed: onPressed,
      child: Container(
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(text,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.normal)),
                    if(disableSecondLine!=true)
                      SizedBox(height: 2,),
                    if(disableSecondLine!=true)
                    description!=null?
                    Text(description!, style: TextStyle(color: Colors.grey),):
                    
                    Row(
                      children: [
                        Icon(Icons.do_disturb_alt_outlined, size: 15,color: isDisabled?Colors.red: Colors.grey,),
                        SizedBox(width: 5,),
                        Icon(Icons.check_circle_outlined, size: 15,color:isAccepted?Colors.green: Colors.grey,),
                      ],
                    )
                    
                  ],
                )
              ],
            ),
            trailing: onPressed == null
                ? null
                : Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 15),
                ),
            contentPadding: EdgeInsets.zero,
          ),
        ),
      ),
    );
  }
}
