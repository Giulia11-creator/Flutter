import 'package:flutter/material.dart';

//import './textdisplay.dart';
//import './button.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get parameters from the previous screen:
    final routeArgs = ModalRoute.of(context)!.settings.arguments as Map<String, String>; //MyClass;
    // Get title and text parameters:
    final title = routeArgs['title'].toString();
    final texttoshow = routeArgs['text'].toString();

    // Use the Todo to create the UI.
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(texttoshow),
      ),
    );
  }
}