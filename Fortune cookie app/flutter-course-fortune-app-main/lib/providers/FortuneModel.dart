import 'dart:math';

import 'package:flutter/material.dart';

class FortuneModel with ChangeNotifier {
  String _currentFortune = "";

  final _fortuneList = [
    "You will find a new friend",
    "You will find a new friend tomorrow",
    "A truly rich life contains love and art in abundance.",
    "Accept something that you cannot change, and you will feel better.",
    "Adventure can be real happiness.",
    "Advice is like kissing. It costs nothing and is a pleasant thing to do.",
    "Advice, when most needed, is least heeded.",
  ];

  String get currentFortune => _currentFortune;

  FortuneModel() {
    _generateRandomFortune();
  }

  void _generateRandomFortune() {
    var random = Random();
    int randNum = random.nextInt(_fortuneList.length);
    _currentFortune = _fortuneList[randNum];

    notifyListeners();
  }

  // Method to get a new random fortune
  void getNewFortune() {
    _generateRandomFortune();
  }
}
