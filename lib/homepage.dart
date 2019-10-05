import 'dart:math';

import 'package:flutter/material.dart';
import 'game_button.dart';
import 'custom_dialog.dart';

class Page1 extends StatefulWidget {
  Page1({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Page1State createState() => _Page1State();
}

class _Page1State extends State<Page1> {


  List<GameButton> buttonslist;
  var player1;
  var player2;
  var activePlayer = 1;

  @override
  void initState() {
    super.initState();
    buttonslist = doInit();
  }

  List<GameButton> doInit() {
    player1 = List();
    player2 = List();

    var gamebuttons = <GameButton>[
      GameButton(id: 1),
      GameButton(id: 2),
      GameButton(id: 3),
      GameButton(id: 4),
      GameButton(id: 5),
      GameButton(id: 6),
      GameButton(id: 7),
      GameButton(id: 8),
      GameButton(id: 9),
    ];
    return gamebuttons;
  }

  void playGame(GameButton button) {
    setState(() {
      if (activePlayer == 1) {
        button.text = "X";
        button.bg = Colors.red;
        activePlayer = 2;
        player1.add(button.id);
      } else {
        button.text = "0";
        button.bg = Colors.black;
        activePlayer = 1;
        player2.add(button.id);
      }
      button.enabled = false;
      checkWinner();
    });
  }

  void checkWinner() {
    var winner = -1;
    int flag = 0;
    var wincases = [
      [1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [1, 4, 7],
      [2, 5, 8],
      [3, 6, 9],
      [1, 5, 9],
      [3, 5, 7]
    ];
    for (int i = 0; i < wincases.length; i++) {
      int counter1 = 0;
      int counter2 = 0;
      var case1 = wincases[i];

      for (int j = 0; j < case1.length; j++) {
        int digit = case1[j];
        if (player1.contains(digit) && player1.length >= 3) {
          counter1 += 1;
        }
        if (player2.contains(digit) && player2.length >= 3) {
          counter2 += 1;
        }
      }
      if (counter1 == 3) {
        winner = 1;
      } else if (counter2 == 3) {
        winner = 2;
      }
    }
    if (player1.length >= 3 || player2.length >= 3) {
      if (winner != -1) {
        if (winner == 1) {
          showDialog(
            context: context,
            builder: (_) =>
                CustomDialog(
                  'Player X wins!!', 'Press Reset to go back to menu',),
          );
        } else {
          showDialog(
            context: context,
            builder: (_) =>
                CustomDialog(
                  'Player O wins!!', 'Press Reset to go back to menu',context),
          );
        }
      } else if(winner == -1 && player1.length+player2.length ==9){
        showDialog(
          context: context,
          builder: (_) =>
              CustomDialog('It is a draw', 'Press Reset to go back to menu',),
        );
      }
  }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
        backgroundColor: Colors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 90),
        child: GridView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: buttonslist.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 9,
            mainAxisSpacing: 9,
          ),
          itemBuilder: (context, i) =>
              SizedBox(
                width: 100,
                height: 100,
                child: RaisedButton(
                  padding: EdgeInsets.all(10.0),
                  onPressed: buttonslist[i].enabled ? () =>
                      playGame(buttonslist[i]) : null,
                  child: Text(buttonslist[i].text,
                    style: TextStyle(color: Colors.white, fontSize: 60.0),),
                  color: buttonslist[i].bg,
                  disabledColor: buttonslist[i].bg,
                  splashColor: Colors.blue,
                ),
              ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Text('Reset',style: TextStyle(
            fontSize: 15,
            color: Colors.white
          ),),

          onPressed: () {
            setState(() {
              buttonslist = doInit();
              activePlayer = 1;
            });
          }
      ),
    );
  }
}
