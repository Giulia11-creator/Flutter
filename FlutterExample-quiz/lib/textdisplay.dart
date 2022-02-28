import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart' as htmlParser;  // to print html chars

class TextDisplay extends StatelessWidget {
  final String myText;

  TextDisplay(this.myText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(10),
      child: Text(
        htmlParser.DocumentFragment.html(myText).text.toString(),
        style: TextStyle(fontSize: 28),
        textAlign: TextAlign.center,
      ),
    );
  }
}
