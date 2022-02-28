import 'package:flutter/material.dart';
import 'todo.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Title = TextEditingController();
    final description = TextEditingController();

    @override
    void dispose() {
      // Clean up the controller when the widget is disposed.
      Title.dispose();
      description.dispose();
    }

    // Use the Todo to create the UI.
    return Scaffold(
        appBar: AppBar(
          title: Text('Add a new item'),
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
                width: 350,
                child: Column(children: [
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 60,
                    width: 200,
                    child: TextFormField(
                      controller: Title, // TextEditingController
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Insert a title for the todo:',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 60,
                    width: 200,
                    child: TextFormField(
                      controller: description, // TextEditingController
                      decoration: const InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: 'Insert a description:',
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                      width: 230,
                      child: RaisedButton(
                        color: Colors.indigo,
                        padding: EdgeInsets.fromLTRB(50, 15, 50, 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          "Add",
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontFamily: 'Open Sans',
                              fontSize: 12,
                              color: Colors.white),
                        ),
                        onPressed: () => Navigator.pop(
                            context, Todo(Title.text, description.text)),
                      )),
                  SizedBox(
                    height: 30,
                  ),
                ]),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // radius of 10
                    color: Colors.white)),
          ]),
        ));
  }
}
