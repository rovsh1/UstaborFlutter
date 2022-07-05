import 'package:flutter/material.dart';
import 'build_dot.dart';

class Dots extends StatelessWidget {
  final int index;

  Dots({required this.index});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        BuildDot(isActive: index >= 0),
        BuildDot(isActive: index >= 1),
        BuildDot(isActive: index >= 2),
        BuildDot(isActive: index >= 3),
      ],
    );
  }
}
