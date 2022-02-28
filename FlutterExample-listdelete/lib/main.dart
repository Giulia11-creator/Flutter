
/*
  This app example shows a list of element. If you tap on
  an item, an alert dialog is shown. You can then delete
  that element, getting a snackbar which confirms the action. 
 */

/*
  Nice example of sending data to a new screen:
  https://docs.flutter.dev/cookbook/navigation/passing-data
  https://docs.flutter.dev/cookbook/navigation/navigate-with-arguments
 */

import 'package:firstassignment/secondscreen.dart';
import 'package:flutter/material.dart';

import './textdisplay.dart';
import './button.dart';
import 'model/todo.dart';

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
        primarySwatch: Colors.brown,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,        
      ),
      home: MyHomePage(title: 'Luke App'),
      // Define here the routes for the other app screens:
      routes: {
        '/secondscreen' : (ctx) => SecondScreen(),
      } ,
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

  /*
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyHomePageState(); 
  } */
}

class _MyHomePageState extends State<MyHomePage> {
  

  // Show a snackbar: 
  void showSnackbar(String? text, int duration) {
    final String message = (text==null ? 'invalid message: '+text.toString() : text.toString());
    final snackbar = SnackBar(
      duration: Duration(seconds: duration),
      content: Text(message),
      action: SnackBarAction(
        label: 'ok',
        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
      ),
    );   
    if(message!=null && message.length > 0) {
      ScaffoldMessenger.of(context).showSnackBar(snackbar);      
    }
  }

  
  
  var _index = 0;

  var _displayMessages = [
      'Hello World',
      'Ciao Mondo',
      'Hallo Welt',
      'Bonjour le Monde',
      'Hola Mundo',
      'Saluton mondo',
    ];

  // Lista elementi
  final todos = List.generate(
    20,
    (i) => Todo(
    'Todo $i',
    'A description of what needs to be done for Todo $i',
    ),
  );

  void _deleteItem(Todo t) {
    setState( () {
      todos.remove(t);
    });
  }
  
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
        body: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
          return ListTile(
            title: Text(todos[index].title),
            // When a user taps the ListTile, navigate to the DetailScreen.
            // Notice that you're not only creating a DetailScreen, you're
            // also passing the current todo through to it.
            onTap: () {
              /*
              Navigator.of(context).pushNamed(
              '/secondscreen',
                arguments: {
                'todo': todos[index],          
                }
              ); */
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(todos[index].title),
                  content: Text(todos[index].description),
                  actions: <Widget> [
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
                  ] ,
                )
              );

            },
    );
  },
        ),      
    );
  }
}