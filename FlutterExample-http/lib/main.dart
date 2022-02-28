// This app gets data from Firebase RealTime database through http requests
// https://pub.dev/packages/http

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './textdisplay.dart';
import './button.dart';
import 'mynubutton.dart';

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
        primarySwatch: Colors.amber,
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
  
  // Sample uri:
  final baseurl = "https://fir-test-8ae6e-default-rtdb.firebaseio.com/messages/";
  final postUrl = Uri.parse("https://fir-test-8ae6e-default-rtdb.firebaseio.com/messages.json");
  final _defaultID = "-MQmNoWqFz_28AZuZgT8";
  var _message = "";
  var _author = "";
  var _id = "";
  void _setMessage(String msg, String author) {
    setState(() {
      _message = msg;
      _author = author;
      
    });
    print("Message from $author: $msg");
  }

  // Get last posted data
  void doGet() {
    if(_id.length==0)
      _id = _defaultID;
    http.get(Uri.parse(baseurl+_id+".json")).then( (response) {
      var jsondata = json.decode(response.body);
      if(jsondata['message'] != null)
        _setMessage(jsondata['message'], jsondata['author']);
      else 
        _setMessage(jsondata['name'], jsondata['email']);
      _id = "";
    });
  }

  // Post data to Firebase
  void doPost() {
    http.post(postUrl, 
      body: json.encode({
        'name': "Pluto",
        'email': "pluto@whitehouse.gov",
        'zipcode': 12364,
        'id' : 0
      })
    ).then( (response) {
      var jsondata = json.decode(response.body);
      _id = jsondata['name'];  // save id of the new document
      _setMessage(jsondata['name'], response.statusCode.toString());
    });
  }

  var _index = 0;

  var _displayMessages = [
      'Hello World',
      'Ciao Mondo',
      'Hallo Welt',
      'Bonjour le Monde',
      'Hola Mundo',
      'Saluton mondo',
      'Cowabungaaaa',
    ];
  
  var _colors = [Colors.amber, 
    Colors.blue, 
    Colors.brown, 
    Colors.deepOrange,
    Colors.deepPurple,
    Colors.green,
    Colors.yellow,
    Colors.grey
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
              _message,
            ),
            TextDisplay(
              _author,
            ),
            Button(doGet, 'http get'),
            Button(doPost, 'http post'), 
            //MyNuButton('Change Color', _changeMessage, _colors[_index]),           
          ],
        ),      
    );
  }
}