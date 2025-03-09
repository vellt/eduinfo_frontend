import 'package:eduinfo/widgets/nav_bar_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class RowNavbarView extends StatelessWidget {
  RowNavbarView({
    super.key,
    required this.controller,
    required this.children,
  });
  NavBarController controller;
  List<Widget> Function(int index) children;

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: controller,
      builder: (_) {
        return Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: children(controller.index),
          ),
        );
      }
    );
  }
}