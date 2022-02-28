import 'dart:convert';
import 'package:flutter/material.dart';

class TextPoints extends StatelessWidget {
  final String myText;
  final String myText2;
  final String myText3;
  final String myText4;

  TextPoints(this.myText,this.myText2,this.myText3,this.myText4);

  @override
  Widget build(BuildContext context) {
    return Container(
              height: 70,
              width: 140,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  border: Border.all(color: Colors.purple)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(myText),
                  Text(myText2),
                  Text(myText3),
                  Text(myText4),
                ],
              ),
            );
  }
}
