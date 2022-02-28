// This app gets data from Firebase RealTime database through http requests
// https://pub.dev/packages/http

import 'dart:convert';

import 'package:firstassignment/models/question.dart';
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
  
  // Sample url:
  final baseurl = "https://opentdb.com/api.php?amount=10";
  
  List<Question>? _questions = null; // questions data structure
  List<String>? _answers = null; // answers list
  var _index = 0;

  // Go to next question:
  void next() {
    if(_questions == null || _questions!.length == 0)
      return;
    setState(() {
      if(_index < _questions!.length - 1)
        _index++;
      else
        _index = 0;
      // update answers:
      _answers = List.from(_questions![_index].incorrect);
      _answers!.add(_questions![_index].correct);
      _answers!.shuffle();
    });
  }

  // Get data
  void doGet() {
    
    http.get(Uri.parse(baseurl)).then( (response) {
      var jsondata = json.decode(response.body);
      var questions = jsondata['results'];

      // create data structure with questions
      setState(() {
        _questions = questions.map<Question>((val) =>  Question.fromJson(val)).toList();
        // initialize answer list:
        _answers = List.from(_questions![_index].incorrect);
        _answers!.add(_questions![_index].correct);
        _answers!.shuffle();
      });
      
      // debug
      print("First question: "+questions[0]['question']);
      print("First question: "+questions[0]['correct_answer']);
      print("category: "+questions[0]['category']);
    });
  }

  // Post data to Firebase
  void doPost(String postUrl) {
    http.post(Uri.parse(postUrl), 
      body: json.encode({
        'name': "Pluto",
        'email': "pluto@whitehouse.gov",
        'zipcode': 12364,
        'id' : 0
      })
    ).then( (response) {
      var jsondata = json.decode(response.body);
      
      // debug
      print("Server response: "+response.statusCode.toString());
    });
  }

  // Check if the answer is correct and display an AlertDialog:
  void _checkAnswer(String ans) {
    String msg = "Sorry, but the correct answer was "+_questions![_index].correct;
    if(ans == _questions![_index].correct)
      msg = "Congratulation! The correct answer was "+_questions![_index].correct;
    showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text('Result'),
            content: Text(msg),
            actions: <Widget> [
              FlatButton(
                autofocus: true,
                child: Text('OK'),
                onPressed: () => Navigator.of(ctx).pop(true),
                )
            ] ,
          )
       );

  }

  // Return a list of buttons with the answers to put in the screen:
  List<Widget> _buildAnswerButtons(List<String> ans) {

    return ans.map<Button>((e) => Button(selectHandler: () => _checkAnswer(e), buttonText: e, color: Colors.orange)).toList();
    /*
    List<Button> buttonList = List<Button>.filled(0, Button(selectHandler: () {}, buttonText: ''), growable: true);
    for (int i = 0; i < ans.length; i++) {
      buttonList.add(new Button(selectHandler: () => _checkAnswer(ans[i]), buttonText: ans[i], color: Colors.orange));
    }
    return buttonList;
    */
  }

  // Load data from Open Trivia DB at the beginning:
  void initState() {
    doGet();
    //assert(_debugLifecycleState == _StateLifecycle.created);
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
              (_questions != null && _questions![0] != null) ? _questions![_index].question: 'none',
            ),
            if(_answers!= null && _buildAnswerButtons(_answers!)!=null) 
              ... _buildAnswerButtons(_answers!)
            else 
              const CircularProgressIndicator(), //Text('Load Quiz!'),
            /*
            Button(() {}, (_questions != null && _questions![_index] != null) ? _questions![_index].correct: 'none',),
            Button(() {}, (_questions != null && _questions![_index] != null) ? _questions![_index].incorrect[0]: 'none',),
            Button(() {}, (_questions != null && _questions![_index] != null) ? _questions![_index].incorrect[1]: 'none',),
            Button(() {}, (_questions != null && _questions![_index] != null) ? _questions![_index].incorrect[2]: 'none',), */
            Button(selectHandler: next, buttonText : 'next'),
            Button(selectHandler: doGet, buttonText : 'reload'),                      
          ],
        ),      
    );
  }
}