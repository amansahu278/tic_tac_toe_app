import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {

  final title;
  final content;
  //final VoidCallback callback;
  final actionText;

  CustomDialog(this.title, this.content,[this.actionText="Congratulations!!"]);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        FlatButton(
            onPressed: (){
             Navigator.of(context).pop(true);
             Navigator.pop(context);
            },
            child: Text('Home'),
        ),
        FlatButton(
          onPressed: (){
            Navigator.pop(context);
          },
          child: Text('Back'),
        )
      ],
    );
  }
}
