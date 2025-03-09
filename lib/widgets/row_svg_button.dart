import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RowSvgButton extends StatelessWidget {
  RowSvgButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.image,
    this.details,
  });
  final String text;
  String? details;
  final Function() onPressed;
  String image;

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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
          child: ListTile(
            title: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: SvgPicture.asset(
                    image, // Az elérési útvonal
                    width: 30,
                    height: 30,
                  ),
                ),
                SizedBox(width: 20), // Távolság a kép és a szöveg között
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(text,
                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, overflow: TextOverflow.ellipsis,)),
                        details==null? Container(): Text(details!,
                        style:
                            TextStyle(fontSize: 16, fontWeight: FontWeight.normal,overflow: TextOverflow.ellipsis, color: Color(0xFF797979))),
                      ],
                    ),
                )
                          
              ],
            ),
            trailing: Padding(
                  padding: EdgeInsets.only(right: 2),
                  child: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 15),
                ),
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 5),
          ),
        ),
      ),
    );
  }
}
