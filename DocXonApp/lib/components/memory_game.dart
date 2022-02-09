import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import '../components/dialog_util.dart';
import '../components/info_card.dart';
import '../components/dialog_util.dart';
import 'app_utils.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/countdown_controller.dart';
import 'dart:async';
import 'dart:math';

class GamePage extends StatefulWidget {
  @override
  _MyGamePageState createState() => _MyGamePageState();
}

class _MyGamePageState extends State<GamePage> {
  TextStyle whiteText = TextStyle(color: Colors.white);
  bool hideTest = false;
  Game _game = Game();
  DialogUtil dialog = DialogUtil();

  int tries = 0;
  int score = 0;

  Random random = new Random();

  late Timer _timer;
  int _start = 30;
  String message = '';
  void startTimer() {
    int randomNumber = random.nextInt(10) + 12;
    _start = randomNumber;
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (_start == 0 || score == 600) {
          if (score == 600) {
            dialog.showGameDialog(context, "Congratulations 👏", "$score");
            setState(() {
              timer.cancel();
            });
          } else {
            dialog.showGameDialog(context, "Sorry Try Again 😫", "$score");
            setState(() {
              timer.cancel();
            });
          }
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }

  void openDoorAtTheStart() {
    _game.cards_list.asMap().forEach((index, value) {
      _game.gameImg![index] = _game.cards_list[index]['url'];
    });
  }

  void closeDoors() {
    _game.cards_list.asMap().forEach((index, value) {
      _game.gameImg![index] = _game.hiddenCardpath;
    });
  }

  @override
  void initState() {
    super.initState();
    _game.cards_list.shuffle();
    _game.initGame();
    startTimer();
    openDoorAtTheStart();
    closeDoorse();
  }

  Future<void> closeDoorse() {
    // Imagine that this function is fetching user info from another service or database.
    return Future.delayed(const Duration(seconds: 1), () => closeDoors());
  }

  void updateListProperty(int first, int second) {
    _game.cards_list[first]['isSelect'] = true;
    _game.cards_list[second]['isSelect'] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Center(
                child: Text(
                  "Memory Game",
                  style: TextStyle(
                    fontSize: 40.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  info_card("Tries", "$tries"),
                  info_card("Time", "$_start"),
                  info_card("Score", "$score"),
                ],
              ),
              SizedBox(
                  height: 450,
                  width: 400,
                  child: GridView.builder(
                      // itemCount: _game.gameImg!.length,
                      itemCount: (_game.gameImg!.length),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      padding: EdgeInsets.all(16.0),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            // print('taped');
                            // print(_game.matchCheck);
                            setState(() {
                              //incrementing the clicks

                              tries++;
                              _game.gameImg![index] =
                                  _game.cards_list[index]['url'];
                            });
                            // handle already clicked event
                            if (_game.cards_list[index]['isSelect'] == false) {
                              if (_game.matchCheck.length == 1) {
                                // if that same index is not in the match list
                                if (_game.matchCheck[0].containsKey(index) ==
                                    false) {
                                  _game.matchCheck.add(
                                      {index: _game.cards_list[index]['url']});

                                  if (_game.matchCheck[0].values.first ==
                                      _game.matchCheck[1].values.first) {
                                    // print("true");
                                    // update card-list property
                                    updateListProperty(
                                        _game.matchCheck[0].keys.first,
                                        _game.matchCheck[1].keys.first);

                                    //incrementing the score
                                    score += 100;
                                    _game.matchCheck.clear();
                                  } else {
                                    // print("false");

                                    Future.delayed(Duration(milliseconds: 250),
                                        () {
                                      // print(_game.gameColors);
                                      setState(() {
                                        _game.gameImg![_game.matchCheck[0].keys
                                            .first] = _game.hiddenCardpath;
                                        _game.gameImg![_game.matchCheck[1].keys
                                            .first] = _game.hiddenCardpath;
                                        _game.matchCheck.clear();
                                      });
                                    });
                                  }
                                }
                              } else {
                                _game.matchCheck.add(
                                    {index: _game.cards_list[index]['url']});
                              }
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.black12,
                              borderRadius: BorderRadius.circular(8.0),
                              image: DecorationImage(
                                image: AssetImage(_game.gameImg![index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ],
      ),
    );
  }
}
