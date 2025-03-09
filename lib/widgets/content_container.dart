import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  ContentContainer({
    super.key,
    required this.noContentWidget,
    required this.children,
  });
  Widget noContentWidget;
  List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: (children.length==0)
        ? [ noContentWidget ]
        : children,
      ),
    );
  }
}