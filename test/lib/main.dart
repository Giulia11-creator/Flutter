import 'package:test/Description.dart';
import 'package:test/info.dart';
import 'secondscreen.dart';
import 'package:flutter/material.dart';
import 'todo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bertoli list',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Bertoli list'),
      // Define here the routes for the other app screens:
      routes: {
        '/secondscreen': (ctx) => SecondScreen(),
        '/Description': (ctx) => Description(),
        '/info': (ctx) => info(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // Simil overloading:
  MyHomePage.myconstr({required this.title});
  // final boh = MyHomePage.myconstr(title: 'Pippo',);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;

  // Lista elementi
  final List<Todo> todos = [];

  void OpenSecondScreen(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final Todo newTodo = await Navigator.push(
      context,
      // Create the SelectionScreen in the next step.
      MaterialPageRoute(builder: (context) => const SecondScreen()),
    );
    setState(() {
      todos.add(newTodo);
      final snackBar = SnackBar(
        content: Text(newTodo.title.toString() + ' added'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bertoli list"),
        backgroundColor: Colors.indigo,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed('/info');
              },
              child: Icon(
                Icons.info_outline,
                color: Color.fromARGB(255, 153, 10, 167).withOpacity(0.75),
                size: 27.0,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            onTap: () {
              Navigator.of(context).pushNamed('/Description', arguments: {
                'todo': todos[index],
              });
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Stack(
        fit: StackFit.expand,
        children: [
          Positioned(
            bottom: 20,
            right: 30,
            child: FloatingActionButton(
              heroTag: 'next',
              onPressed: () {
                OpenSecondScreen(context);
              },
              child: Icon(
                Icons.add,
                size: 33,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
