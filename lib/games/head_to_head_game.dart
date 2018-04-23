import 'package:meta/meta.dart';
import 'package:flutter/material.dart';
import 'single_game.dart';

class HeadToHeadGame extends StatefulWidget {
  final String gameName;
  final GameMode gameMode;
  final int gameCategoryId;

  HeadToHeadGame(this.gameName,
      {this.gameMode = GameMode.iterations, @required this.gameCategoryId});

  @override
  HeadToHeadGameState createState() {
    return new HeadToHeadGameState();
  }
}

class HeadToHeadGameState extends State<HeadToHeadGame> {
  int _myScore = 0;
  int _otherScore = 0;

  setMyScore(int score) {
    _myScore = score;
  }

  setOtherScore(int score) {
    _otherScore = score;
  }

  onGameEnd(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    showDialog<String>(
        context: context,
        child: new AlertDialog(
            content: media.size.height > media.size.width
                ? new Column(
                    children: <Widget>[
                      new Expanded(
                          child: new RotatedBox(
                        child: new Text('$_otherScore'),
                        quarterTurns: 2,
                      )),
                      new Expanded(child: new Text('$_myScore'))
                    ],
                  )
                : new Row(
                    children: <Widget>[
                      new Expanded(
                          child: new Center(child: new Text('$_otherScore'))),
                      new Expanded(
                          child: new Center(child: new Text('$_myScore')))
                    ],
                  ))).then<Null>((String s) {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData media = MediaQuery.of(context);
    final myGame = new SingleGame(
      widget.gameName,
      key: new GlobalObjectKey('SingleGame.my'),
      gameMode: widget.gameMode,
      gameDisplay: GameDisplay.myHeadToHead,
      gameCategoryId: widget.gameCategoryId,
      onScore: setMyScore,
      onGameEnd: onGameEnd,
    );
    return media.size.height > media.size.width
        ? new Column(
            children: <Widget>[
              new Expanded(
                  child: new RotatedBox(
                      child: new SingleGame(widget.gameName,
                          key: new GlobalObjectKey('SingleGame.other'),
                          gameMode: widget.gameMode,
                          gameDisplay: GameDisplay.otherHeadToHead,
                          gameCategoryId: widget.gameCategoryId,
                          onScore: setOtherScore,
                          onGameEnd: onGameEnd,
                          isRotated: true),
                      quarterTurns: 2)),
              new Expanded(child: myGame)
            ],
          )
        : new Row(children: <Widget>[
            new Expanded(
                child: new SingleGame(widget.gameName,
                    key: new GlobalObjectKey('SingleGame.other'),
                    gameDisplay: GameDisplay.otherHeadToHead,
                    gameMode: widget.gameMode,
                    gameCategoryId: widget.gameCategoryId,
                    onScore: setOtherScore,
                    onGameEnd: onGameEnd)),
            new Expanded(child: myGame)
          ]);
  }
}
