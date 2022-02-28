import 'package:flutter/material.dart';
import 'todo.dart';

class Description extends StatelessWidget {
  const Description({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get parameters from the previous screen:
    final routeArgs = ModalRoute.of(context)!.settings.arguments
        as Map<String, Todo>; //MyClass;
    // Get todo parameters:
    final todo = routeArgs['todo'] as Todo;

    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text(todo.title),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                      "https://wallpaperaccess.com/full/1781487.jpg"),
                  fit: BoxFit.cover)),
          padding: EdgeInsets.only(top: 50.0),
          child: Column(children: [
            Container(
                height: 180,
                width: 300,
                child: Center(child:Text(todo.description),),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // radius of 10
                    color: Colors.white))
          ]),
        ));
  }
}
