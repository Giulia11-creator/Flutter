import 'package:flutter/material.dart';

class MyNuButton extends StatelessWidget {

  MyNuButton(this.text, this.clickHandler, this.color);

  final String text;
  final Function() clickHandler;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(text),
        color: color,
        onPressed: clickHandler,
        ),
    );
  }

}