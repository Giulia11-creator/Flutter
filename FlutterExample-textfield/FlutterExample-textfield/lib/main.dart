/*
  Nice example on retrieving content from a TextFiled
  with the TextEditingController:
  https://docs.flutter.dev/cookbook/forms/retrieve-input
 */

import 'package:flutter/material.dart';

import './textdisplay.dart';
import './button.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Luke Flutter Demo',
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
        primarySwatch: Colors.deepOrange,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Luke App'),
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();

  /*
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState(); 
  } */
}

class _MyHomePageState extends State<MyHomePage> {
  
  // TextEditingController: manage changes in the TextField
  final myController = TextEditingController();
  
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

  /* Change the current array element
     with the text inside the TextField
     using TextEditingController
    */
  void _changeText() {
    setState(() {
      _displayMessages[_index] = myController.text;      
      
    });
    print(_index);
  }
  

  // For TextEditingController:
  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
              child: TextFormField(
                controller: myController,  // TextEditingController
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),                  
                  labelText: 'Enter a text..',
                ),
              ),
            ),
            Button(_changeText, 'change text!'),           
          ],
        ),      
    );
  }
}