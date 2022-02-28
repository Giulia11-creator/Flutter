import 'package:flutter/material.dart';
/*
The snackbar should be in a separate 
widget.
 */
class SnackbarButton extends StatelessWidget {
  final String snackbarText;
  final String buttonText;

  SnackbarButton(this.snackbarText, this.buttonText);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
                onPressed: () {
                  // print('snackBar');
                  final snackbar = SnackBar(
                    duration: Duration(seconds: 3),
                    content: Text(snackbarText),
                    action: SnackBarAction(
                        label: 'undo',
                        onPressed: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    ),
                  );
                  ScaffoldMessenger.of(context).showSnackBar(snackbar);
                }, 
                child: Text(buttonText)),
    );
  }
}
