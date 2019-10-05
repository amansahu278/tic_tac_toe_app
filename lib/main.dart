import 'dart:io';

import 'package:flutter/material.dart';
import 'homepage.dart';
import 'pageAI.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Tic Tac Toe'),
      routes: <String,WidgetBuilder>{
        '/screenAI' : (BuildContext context) => new Page2(title: "vs Computer",),
        '/screenPlayer' : (BuildContext context) => new Page1(title: "vs Friend",),
      }
    );
  }
}

/*
* Further plans include:
* 1. Adding a home page which asks whether you want to play against computer or another player
* 2. Add routes to those
* 3. Configure the Navigator and contexts for the dialog box which appears after a round ends.
* */
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: Center(
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Text('TIC \nTAC \nTOE', style: TextStyle(
                  fontSize: 70.0,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.bold,
                ),),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0, bottom: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/screenAI');
                      },
                      child: Text('Play Against \nComputer', style: TextStyle(fontSize: 20),),
                    ),
                    RaisedButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed('/screenPlayer');
                      },
                      child: Text('Play With \nFriend', style: TextStyle(fontSize: 20),),
                    ),

                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: RaisedButton(
                    onPressed: ()=> exit(0),
                    child: Text('EXIT'),
                  ),
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}
