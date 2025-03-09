import 'package:flutter/material.dart';

class LoadingContainer extends StatelessWidget {
  LoadingContainer({
    super.key,
    required this.child,
    required this.startLoading,
  });

  Widget child;
  bool startLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      child:(startLoading)?Center(child: CircularProgressIndicator()): child
    );
  }
}