import 'package:flutter/material.dart';
import 'package:html/dom.dart' as htmlParser;  // to print html chars

class Button extends StatelessWidget {
  final Function() selectHandler;
  final String buttonText;
  final Color color;

  Button({required this.selectHandler, required this.buttonText, this.color = Colors.blue});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      child: RaisedButton(
        color: this.color,
        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
        child: Text(htmlParser.DocumentFragment.html(buttonText).text.toString(),
         style: TextStyle(
                fontStyle: FontStyle.italic,
                fontFamily: 'Open Sans',
                fontSize: 12),),
        onPressed: selectHandler,
      ),
      
    );
  }
}
