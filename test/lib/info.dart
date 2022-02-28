import 'package:flutter/material.dart';
import 'todo.dart';

class info extends StatelessWidget {
  const info({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get parameters from the previous screen:
   
    return Scaffold(
        appBar: AppBar(
          title: Text("Info"),
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
                child: Center(child:Text("App relaized by Bertoli Giulia"),),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // radius of 10
                    color: Colors.white))
          ]),
        ));
  }
}