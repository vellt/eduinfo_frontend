import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RowTab extends StatelessWidget {
  RowTab({
    super.key,
    this.tabController,
    required this.tabs,
    this.tabAlignment,
    this.color,
  });
  TabController? tabController;
  List<Widget> tabs;
  TabAlignment? tabAlignment;
  Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
                decoration: BoxDecoration(
            border: Border.all(
                color: Color.fromARGB(255, 235, 235, 235),
                width: 0.5)),
      child: TabBar(
        controller: tabController,
        tabAlignment: tabAlignment?? TabAlignment.start,
        isScrollable: true,
        padding: EdgeInsets.only(left: 15),
        dividerColor: Colors.transparent,
        labelColor: color?? Colors.black, // Kijelölt szöveg színe
        automaticIndicatorColorAdjustment: false,
        indicatorColor: Colors.transparent,
        overlayColor: WidgetStateProperty.all(Colors.transparent),
        labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        unselectedLabelColor: Colors.grey, // Nem kijelölt szöveg színe
        tabs: tabs,
      ),
    );
  }
}