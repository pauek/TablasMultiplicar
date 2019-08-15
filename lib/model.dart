import 'package:flutter/widgets.dart';

class Multiplication {
  final int a, b, result;
  Multiplication(this.a, this.b) : result = a * b;
}

class PracticeSession extends ChangeNotifier {
  int _target = 0;
  DateTime _start, _end;
  Duration _duration;
  int _correct, _wrong, _total;

  List<Multiplication> _list = [];

  void reset(int mults) {
    _correct = 0;
    _wrong = 0;
    _total = 0;
    _start = DateTime.now();
    _target = mults;
    _generate();
  }

  bool get isComplete => _correct >= _target;

  _generate() {
    _list = [
      for (int a = 2; a <= 9; a++)
        for (int b = 2; b <= 9; b++) Multiplication(a, b)
    ];
    _list.shuffle();
  }

  int get correct => _correct;
  int get wrong => _wrong;
  int get total => _total;
  int get target => _target;
  double get totalSeconds => _duration.inMilliseconds.toDouble() / 1000.0;

  void incrementCorrect({int amount = 1}) {
    _correct += amount;
    _total += amount;
  }
  void incrementWrong({int amount = 1}) {
    _wrong += amount;
    _total += amount;
  }

  Multiplication next() {
    if (isComplete) {
      return null;
    }
    if (_list.isEmpty) {
      _generate();
    }
    Multiplication m = _list[0];
    _list.removeAt(0);
    return m;
  }

  void finish() {
    _end = DateTime.now();
    _duration = _end.difference(_start);
  }

  double get duration => (_duration.inMilliseconds.toDouble() / 1000.0);
  double get perSecond => _total.toDouble() / duration;
  double get perItem => duration / _total.toDouble();
}
