import 'package:flutter/material.dart';

class QuestionMarkAnimation extends StatelessWidget {
  final double? width;
  const QuestionMarkAnimation({this.width, super.key});

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.question_mark,
      size: width,
    );
  }
}
