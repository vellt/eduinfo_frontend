import 'package:eduinfo/widgets/nav_bar_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class AppBody extends StatelessWidget {
  AppBody({
    super.key,
    required this.child,
    required this.isFloatingButton,
    this.floatingActionButtonPressed,
    this.floatingActionButtonIcon,
    this.floatingActionButtonPadding,
  });

  Widget child;
  bool isFloatingButton;
  EdgeInsets? floatingActionButtonPadding;
  Function()? floatingActionButtonPressed;
  IconData? floatingActionButtonIcon;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: Padding(
        padding: floatingActionButtonPadding?? const EdgeInsets.symmetric(vertical: 100),
        child: (isFloatingButton)
            ? FloatingActionButton(
                onPressed: floatingActionButtonPressed,
                backgroundColor: Color(0xFF17A436),
                child: Icon(
                  floatingActionButtonIcon ?? Icons.add,
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(50), // Lekerekített forma
                ),
              )
            : null,
      ),
      body: SafeArea(
        child: child,
      ),
    );
  }
}
