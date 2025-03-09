import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowTextContent extends StatelessWidget {
  RowTextContent({
    super.key,
    required this.title,
    this.details,
    this.onPressed,
    this.isRequired,
    this.icon,
    this.iconBackground,
    this.prefixIcon,
    this.innerOnPressed,
    this.outerOnPressed,
  });
  final String title;
  String? details;
  Function()? onPressed;
  bool? isRequired;
  Icon? icon;
  Icon? prefixIcon;
  Color? iconBackground;
  Function? innerOnPressed;
  Function? outerOnPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(255, 235, 235, 235), width: 0.5)),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 2),
          child: ListTile(
            leading: prefixIcon,
            title: Row(
              children: [
               (isRequired==true)?
               Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.normal, overflow: TextOverflow.ellipsis),),
                      details==null? Container(): Text(details!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.normal,overflow: TextOverflow.ellipsis, color: Color(0xFF797979))),
                    ],
                  )
               : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.normal, overflow: TextOverflow.ellipsis),),
                      details==null? Container(): Text(details!,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.normal,overflow: TextOverflow.ellipsis, color: Color(0xFF797979))),
                    ],
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                (isRequired == true)
                    ? Text("*",
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                            color: Colors.red))
                    : Container(),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                (innerOnPressed==null)?Container(): CupertinoButton(
                  padding:  EdgeInsets.zero,
                  onPressed:(){
                    if(innerOnPressed!=null)
                      innerOnPressed!();
                  },
                  child: Container(
                    height: 50,
                    width: 50,
                    child: Icon(Icons.restore, color: Colors.white),
                            decoration: BoxDecoration(color: Colors.redAccent, borderRadius: BorderRadius.circular(50)),
                            ),
                ),
                (innerOnPressed==null)?Container(): SizedBox(width: 10,),
                CupertinoButton(
                  padding:  EdgeInsets.zero,
                  onPressed:(){
                    if(outerOnPressed!=null)
                      outerOnPressed!();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Container(
                                height: iconBackground==null?20:50,
                                width: iconBackground==null?20:50,
                                child: onPressed == null && outerOnPressed== null
                        ? null
                        : icon==null?Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 15):icon,
                                          decoration: BoxDecoration(color: (icon==null)?Colors.transparent: iconBackground, borderRadius: BorderRadius.circular(50)),
                                        ),
                  ),
                ),
              ],
            ),
            contentPadding: EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}
