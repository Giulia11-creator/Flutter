import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './textdisplay.dart';
import './button.dart';
import '/PointsBox.dart';
import 'LabelPoints.dart';
import 'SecondScreen.dart';
import 'question.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

//void main() => runApp(MyQuiz());

class MyQuiz extends StatelessWidget {
  // This widget is the root of your application.

 final String UrlPass;
 final String nicks;
  MyQuiz(this.UrlPass,this.nicks);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Quiz',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyQuizPage(title:'Trivia Flutter',URL: UrlPass,NICK: nicks,),
    
    );
  }
}

class MyQuizPage extends StatefulWidget {
  MyQuizPage({Key? key, required this.title, required this.URL,required this.NICK}) : super(key: key);

  final String title;
  final String URL;
  final String NICK;

  @override
  _MyQuizPageState createState() => _MyQuizPageState(URL,NICK);
}

class _MyQuizPageState extends State<MyQuizPage> {

 _MyQuizPageState(this.url,this.nickname);
  final String url;
  final String nickname;
  //final baseurl = url;
  int points = 0;
  double right=0;


  List<Question>? _questions = null; // questions data structure
  List<String>? _answers = null; // answers list
  var _index = 0;


// Go to next question:
  void next() {
    int pointAcc;
    double rightTot;
    double wrongTot;
    int dim= _questions!.length;
    double Perc;
    
    if (_questions == null || _questions!.length == 0) return;
    setState(() {
      if (_index < _questions!.length - 1)
        _index++;
      else {
        _index = 0;
        pointAcc=points;
        rightTot=right;
        wrongTot=dim-rightTot;
        Perc=((right/dim)*100);
        showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
                  title: Text('Result'),
                  content: Text("You finished the game!!!"),
                  actions: <Widget>[
                    FlatButton(
                        autofocus: true,
                        child: Text('OK'),
                        onPressed: () {
                          Navigator.of(ctx).pop(true);
                          Navigator.push(context, MaterialPageRoute(builder:(context)=>SecondRoute(pointAcc,rightTot,wrongTot,nickname,Perc)),);
                          
                          //doGet();
                        })
                  ],
                ));
      }

      // update answers:
      _answers = List.from(_questions![_index].incorrect);
      _answers!.add(_questions![_index].correct);
      _answers!.shuffle();
    });
  }

  // Get data
  void doGet() {
    points = 0;
    right=0;
    print("Request"+url);
    http.get(Uri.parse(url)).then((response) {
      var jsondata = json.decode(response.body);
      var questions = jsondata['results'];
      print("Response"+questions.toString());

      // create data structure with questions
      setState(() {
        _questions =
            questions.map<Question>((val) => Question.fromJson(val)).toList();
        // initialize answer list:
        _answers = List.from(_questions![_index].incorrect);
        _answers!.add(_questions![_index].correct);
        _answers!.shuffle();
      });

      // debug
      print("First question: " + questions[0]['question']);
      print("First question: " + questions[0]['correct_answer']);
      print("category: " + questions[0]['category']);
    });
  }

  // Check if the answer is correct and display an AlertDialog:
  void _checkAnswer(String ans) {
    String msg =
        "Sorry, but the correct answer was " + _questions![_index].correct;
    if (ans == _questions![_index].correct) {
      msg = "Congratulation! The correct answer was " +
          _questions![_index].correct;
      points += 50;
      right++;
    }

    showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
              title: Text('Result'),
              content: Text(msg),
              actions: <Widget>[
                FlatButton(
                  autofocus: true,
                  child: Text('OK'),
                  onPressed: () => Navigator.of(ctx).pop(true),
                )
              ],
            ));
  }

  // Return a list of buttons with the answers to put in the screen:
  List<Widget> _buildAnswerButtons(List<String> ans) {
    return ans
        .map<Button>((e) => Button(
            selectHandler: () => _checkAnswer(e),
            buttonText: e,
            color: Colors.purple))
        .toList();
  }

  // Load data from Open Trivia DB at the beginning:
  void initState() {
    doGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          LabelPoints("Player: "+nickname),
          TextDisplay(
            (_questions != null && _questions![0] != null)
                ? _questions![_index].question
                : 'none',
          ),
          if (_answers != null && _buildAnswerButtons(_answers!) != null)
            ..._buildAnswerButtons(_answers!)
          else
            const CircularProgressIndicator(),
          SizedBox(
            height: 30,
          ),
          Button(
              selectHandler: next,
              buttonText: 'next',
              color: Colors.pinkAccent),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
          LabelPoints("Points"),
          TextPoints("",points.toString(),"","")
        ],
      ),
    );
  }
}
