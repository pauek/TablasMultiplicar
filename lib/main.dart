import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:vector_math/vector_math_64.dart' as vmath;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multiplicacions',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Multiplicacions'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Multiplication {
  final int a, b, result;
  Multiplication(this.a, this.b) : result = a * b;
}

class _MyHomePageState extends State<MyHomePage> {
  static math.Random _rng = new math.Random();
  Multiplication _multiplication;
  int _good, _bad;
  String _answer;
  List<Multiplication> _multiplication_list = [];

  static int _rand(int a, int b) {
    return _rng.nextInt(b - a + 1) + a;
  }

  _generateMultiplications() {
    _multiplication_list = [
      for (int a = 2; a <= 9; a++)
        for (int b = 2; b <= 9; b++) Multiplication(a, b)
    ];
    _multiplication_list.shuffle();
  }

  _MyHomePageState() {
    _good = 0;
    _bad = 0;
    _newMultiplication();
  }

  _newMultiplication() {
    if (_multiplication_list.isEmpty) {
      _generateMultiplications();
    }
    _multiplication = _multiplication_list[0];
    _multiplication_list.removeAt(0);
    _answer = "";
  }

  _nextMultiplication() {
    setState(_newMultiplication);
  }

  _addNumber(n) {
    setState(() {
      if (_answer.length < 2) {
        _answer += '$n';
      }
      print(_answer);
    });
  }

  _clearNumber() {
    setState(() {
      _answer = '';
    });
  }

  _check() {
    setState(() {
      if (int.parse(_answer) == _multiplication.result) {
        _good++;
        _nextMultiplication();
      } else {
        _bad++;
        _answer = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var multTextStyle = Theme.of(context).textTheme.display3;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Score(
                    score: _bad,
                    color: Colors.red,
                    icon: Icons.close,
                  ),
                  Score(
                    score: _good,
                    color: Colors.green,
                    icon: Icons.check,
                  ),
                ]),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${_multiplication.a} × ${_multiplication.b} = ',
                      style: multTextStyle,
                    ),
                    Text(_answer, style: multTextStyle),
                    Text('_', style: multTextStyle),
                  ],
                ),
              ),
            ),
            NumberButtons(
              onTapNumber: _addNumber,
              onClear: _clearNumber,
              onCheck: _check,
            ),
          ],
        ),
      ),
    );
  }
}

class Score extends StatefulWidget {
  final int score;
  final Color color;
  final IconData icon;

  Score({
    @required this.score,
    @required this.color,
    @required this.icon,
  });

  @override
  _ScoreState createState() => _ScoreState();
}

class _ScoreState extends State<Score>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  Matrix4 _transform;

  @override
  void initState() {
    final Matrix4 doublesize =
        Matrix4.diagonal3(vmath.Vector3(1.5, 1.5, 1.5));
    final Matrix4 normalsize =
        Matrix4.diagonal3(vmath.Vector3(1, 1, 1));

    _transform = doublesize;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = _controller.drive(
      Matrix4Tween(begin: doublesize, end: normalsize),
    );
    _controller.forward();
    _controller.addListener(() {
      setState(() {
        _transform = _animation.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: _transform,
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(9, 7, 9, 7),
          child: Row(
            children: <Widget>[
              Icon(widget.icon, color: Colors.white, size: 30),
              Text(
                ' ${widget.score}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NumberButtons extends StatelessWidget {
  final Function onTapNumber, onClear, onCheck;

  NumberButtons({this.onTapNumber, this.onClear, this.onCheck});

  _button(n, context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: OutlineButton(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            '$n',
            style: Theme.of(context).textTheme.display1,
          ),
        ),
        onPressed: () {
          this.onTapNumber(n);
        },
      ),
    );
  }

  _buttonRow(BuildContext context, int from, int to) {
    return List<Widget>.generate(
        to - from + 1, (i) => _button(i + from, context));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Table(
        children: [
          TableRow(children: _buttonRow(context, 7, 9)),
          TableRow(children: _buttonRow(context, 4, 6)),
          TableRow(children: _buttonRow(context, 1, 3)),
          TableRow(children: [
            FlatButton(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Icon(Icons.delete,
                        size: 40, color: Colors.grey)),
                onPressed: () {
                  this.onClear();
                }),
            _button(0, context),
            FlatButton(
                child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Icon(Icons.check,
                        size: 40, color: Colors.green)),
                onPressed: () {
                  this.onCheck();
                }),
          ])
        ],
      ),
    );
  }
}
