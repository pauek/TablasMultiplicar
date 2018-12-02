import 'package:flutter/material.dart';
import 'dart:math';

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

class _MyHomePageState extends State<MyHomePage> {
  static Random _rng = new Random();
  int _a, _b, _result, _good, _bad;
  String _answer;

  static int _rand(int a, int b) {
    return _rng.nextInt(b - a + 1) + a;
  }

  _MyHomePageState() {
    _good = 0;
    _bad = 0;
    _newMultiplication();
  }

  _newMultiplication() {
    var _lasta = _a, _lastb = _b;
    while (_lasta == _a && _lastb == _b) {
      _a = _rand(2, 9);
      _b = _rand(2, 9);
    }
    _result = _a * _b;
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
    setState(() { _answer = ''; });
  }

  _check() {
    setState(() {
      if (int.parse(_answer) == _result) {
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
                Result(result: _bad, color: Colors.red), 
                Result(result: _good, color: Colors.green),
              ]
            ),
            Expanded(
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                  Text('$_a × $_b = ', style: multTextStyle),
                  Text(_answer, style: multTextStyle),
                  Text('_', style: multTextStyle),
                ]))),
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

class Result extends StatelessWidget {
  final int result;
  final Color color;

  Result({ this.result, this.color });

  @override
  Widget build(BuildContext context) {
    final TextStyle resultTextStyle = Theme.of(context).textTheme.body2.copyWith(
      color: Colors.white,
      fontSize: 18,
    );
    return Padding(
      padding: EdgeInsets.all(6), 
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Container(
          color: color,
          child: Padding(
            padding: EdgeInsets.fromLTRB(9, 7, 9, 7),
            child: Text('$result', style: resultTextStyle)
          )
        )
      ),
    );
  }
}

class NumberButtons extends StatelessWidget {

  final Function onTapNumber, onClear, onCheck;

  NumberButtons({ this.onTapNumber, this.onClear, this.onCheck });

  _button(n, context) {
    return FlatButton(
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
        child: Text('$n', style: Theme.of(context).textTheme.display1)
      ),
      onPressed: () { this.onTapNumber(n); },
    );
  }

  _buttonRow(BuildContext context, int from, int to) {
    return List<Widget>.generate(to-from+1, (i) => _button(i+from, context));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          
        ]),
        Table(
          children: [
            TableRow(children: _buttonRow(context, 7, 9)),
            TableRow(children: _buttonRow(context, 4, 6)),
            TableRow(children: _buttonRow(context, 1, 3)),
            TableRow(children: [
              FlatButton(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20), 
                  child: Icon(Icons.delete, size: 40, color: Colors.grey)
                ), 
                onPressed: () { this.onClear(); }
              ),
              _button(0, context),
              FlatButton(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20), 
                  child: Icon(Icons.check, size: 40, color: Colors.green)
                ),
                onPressed: () { this.onCheck(); }
              ),
            ])
          ],
        )
      ]
    );
  }
}