/* 
  Example on AlertDialog:
  https://api.flutter.dev/flutter/material/AlertDialog-class.html

  Example on SnackBar:
  https://docs.flutter.dev/cookbook/design/snackbars
 */

import 'package:flutter/material.dart';

import './textdisplay.dart';
import './button.dart';
import 'buttonsnackbar.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Test",
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: TestPage(title: 'Dialog Test'),
    );
  }
}

class TestPage extends StatefulWidget {
  TestPage({Key? key, required this.title}) : super(key: key);
  final String title;

  /*
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TestPageState();
  } */

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  var _index = 0;

  var _displayMessages = [
      'Hello World',
      'Ciao Mondo',
      'Hallo Welt',
      'Bonjour le Monde',
      'Hola Mundo',
      'Saluton mondo',
    ];

  void _changeMessage() {
    setState(() {
      if(_index >= _displayMessages.length -1) 
        _index = 0;
      
      else
        _index += 1;
      
    });
    print(_index);
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(
          children: [
            TextDisplay(
              _displayMessages[_index],
            ),
            Button(_changeMessage, 'click me!'), 
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: Text('Dialog Title'),
                      content: Text('This is my content'),
                      actions: <Widget> [
                        FlatButton(autofocus: true,
                          child: Text('OK'),
                          onPressed: () => Navigator.of(ctx).pop(true),
                        )
                    ] ,
                  )
                );
              }, 
              child: Text('ShowDialog')),
            ),  
            SnackbarButton('ShowSnackBar Text', 'ShowSnackBar'),
          ],
        ),      
    );
  }
}