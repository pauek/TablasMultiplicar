import 'package:flutter/widgets.dart';

class Multiplication {
  final int a, b, result;
  Multiplication(this.a, this.b) : result = a * b;
}

class PracticeSession extends ChangeNotifier {
  int _correct = 0, _wrong = 0;
  List<Multiplication> _list = [];

  int get correct => _correct;
  int get wrong => _wrong;

  void incrementCorrect({int amount = 1}) => _correct += amount;
  void incrementWrong({int amount = 1}) => _wrong += amount;

  PracticeSession() {
    _generate();
  }

  _generate() {
    _list = [
      for (int a = 2; a <= 9; a++)
        for (int b = 2; b <= 9; b++) Multiplication(a, b)
    ];
    _list.shuffle();
  }

  Multiplication next() {
    if (_list.isEmpty) {
      _generate();
    }
    Multiplication m = _list[0];
    _list.removeAt(0);
    return m;
  }
}
