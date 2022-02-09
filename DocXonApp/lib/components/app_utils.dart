import 'package:flutter/material.dart';

class Game {
  final Color hiddenCard = Colors.red;
  List<Color>? gameColors;
  List<String>? gameImg;
  List<Color> cards = [
    Colors.green,
    Colors.yellow,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.blue
  ];
  final String hiddenCardpath = "images/hidden.png";
  // List<Map> cards_list = [
  //   "images/new1.png",
  //   "images/new4.png",
  //   "images/new2.png",
  //   "images/new4.png",
  //   "images/new7.png",
  //   "images/new1.png",
  //   "images/new7.png",
  //   "images/new2.png",
  //   "images/new3.png",
  //   "images/new5.png",
  //   "images/new3.png",
  //   "images/new5.png",
  // ];

  List<Map> cards_list = [
    {
      "url": "images/new1.png",
      "isSelect": false,
    },
    {
      "url": "images/new4.png",
      "isSelect": false,
    },
    {
      "url": "images/new2.png",
      "isSelect": false,
    },
    {
      "url": "images/new4.png",
      "isSelect": false,
    },
    {
      "url": "images/new7.png",
      "isSelect": false,
    },
    {
      "url": "images/new1.png",
      "isSelect": false,
    },
    {
      "url": "images/new7.png",
      "isSelect": false,
    },
    {
      "url": "images/new2.png",
      "isSelect": false,
    },
    {
      "url": "images/new3.png",
      "isSelect": false,
    },
    {
      "url": "images/new5.png",
      "isSelect": false,
    },
    {
      "url": "images/new3.png",
      "isSelect": false,
    },
    {
      "url": "images/new5.png",
      "isSelect": false,
    },
  ];

  final int cardCount = 12;
  List<Map<int, String>> matchCheck = [];

  //methods
  void initGame() {
    gameColors = List.generate(cardCount, (index) => hiddenCard);
    gameImg = List.generate(cardCount, (index) => hiddenCardpath);
  }
}
