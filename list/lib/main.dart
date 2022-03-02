import 'package:flutter/material.dart';

import 'seconScreen.dart';
import 'todo.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      routes: {
        '/secondscreen': (ctx) => SecondScreen(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void showSnackbar(String? text, int duration) {
    final String message = (text == null? 'invalid message: ' + text.toString(): text.toString());
    final snackbar = SnackBar(
      duration: Duration(seconds: duration),
      content: Text(message),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    );
    if (message != null && message.length > 0) {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  final todos = List.generate(
    //Viene generata la lista dei Todo
    20,
    (i) => Todo(
      'Todo $i',
      'A description of what needs to be done for Todo $i',
    ),
  );

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _deleteItem(Todo t) {
    setState(() {
      todos.remove(t);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),

            ///Titolo di un elemento della lista di tipo [Todo]
            onTap: () {
              Navigator.of(context).pushNamed('/secondscreen', arguments: {
                //Passaggio alla nuova schermata in cui viene passato un oggetto Todo
                'todo': todos[index],
              });
              showDialog(
                  //Show Dialog che visualizza il titolo dell'elemento che hai cliccato
                  context: context,
                  builder: (ctx) => AlertDialog(
                        title: Text(todos[index].title),
                        content: Text('You open the ' + todos[index].title),
                        actions: <Widget>[
                          FlatButton(
                            autofocus: true,
                            child: Text('Delete'),
                            onPressed: () {
                              String item = todos[index].title;
                              _deleteItem(todos[index]);
                              Navigator.of(ctx).pop(true);
                              showSnackbar("Item $item has been deleted", 10);
                            },
                          ),
                          FlatButton(
                            autofocus: true,
                            child: Text('OK'),
                            onPressed: () => Navigator.of(ctx).pop(true),
                          )
                        ],
                      ));
            },
          );
        },
      ),
    );
  }
}
