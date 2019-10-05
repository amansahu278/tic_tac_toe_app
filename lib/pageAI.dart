import 'package:flutter/material.dart';

import 'dart:math';

import 'game_button.dart';
import 'custom_dialog.dart';

class Page2 extends StatefulWidget {
  Page2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Page2State createState() => _Page2State();
}

class _Page2State extends State<Page2> {

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
      int n = checkWinner();
      if(n == -1){
        if(activePlayer == 2){
          autoPlay();
        }
      }
    });
  }

    int checkWinner() {
      var winner = -1;

      if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
        winner = 1;
      }
      if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
        winner = 1;
      }
      if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
        winner = 1;
      }
      if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
        winner = 1;
      }
      if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
        winner = 1;
      }
      if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
        winner = 1;
      }
      if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
        winner = 1;
      }
      if (player1.contains(3) && player1.contains(5) && player1.contains(5)) {
        winner = 1;
      }
      if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
        winner = 2;
      }
      if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
        winner = 2;
      }
      if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
        winner = 2;
      }
      if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
        winner = 2;
      }
      if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
        winner = 2;
      }
      if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
        winner = 2;
      }
      if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
        winner = 2;
      }
      if (player2.contains(3) && player2.contains(5) && player2.contains(5)) {
        winner = 2;
      }


      if (winner != -1) {
        if (winner == 1) {
          showDialog(
            context: context,
            builder: (_) =>
                CustomDialog(
                  'Player X wins!!', 'Press Home to go back to menu',),
          );
        } else {
          showDialog(
            context: context,
            builder: (_) =>
                CustomDialog(
                    'Player O wins!!', 'Press Home to go back to menu',
                    context),
          );
        }
      }
      return winner;
    }

  void autoPlay(){
    var emptyCells = new List();
    var list = List.generate(9,(i)=>i+1);
    for(var cellID in list){
      if(!(player1.contains(cellID) || player2.contains(cellID))){
        emptyCells.add(cellID);
      }
    }
    var random = Random();
    var randIndex = random.nextInt(emptyCells.length-1);
    var cellID = emptyCells[randIndex];
    int i = buttonslist.indexWhere((p)=> p.id == cellID);
    playGame(buttonslist[i]);
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
          child: Text('Reset',),
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
