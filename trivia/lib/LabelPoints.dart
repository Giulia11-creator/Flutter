import 'dart:convert';
import 'package:flutter/material.dart';

class LabelPoints extends StatelessWidget {
  final String myText;

  LabelPoints(this.myText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Text(
        myText,
        style: TextStyle(
            fontSize: 20,
            color: Colors.purple,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            fontFamily: 'Open Sans'),
        textAlign: TextAlign.center,
      ),
    );
  }
}
