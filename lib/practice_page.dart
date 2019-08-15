import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as vmath;
import 'package:tablas_multiplicar/session_container.dart';

class PracticePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SessionState session = StateContainer.of(context);
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/fondo.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ProgressBar(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ScoreBox(
                    score: session.wrong,
                    color: Colors.red,
                    icon: Icons.close,
                    offset: Offset(0, 0),
                  ),
                  ScoreBox(
                    score: session.correct,
                    color: Colors.green,
                    icon: Icons.check,
                    offset: Offset(80, 10),
                  ),
                ],
              ),
              Expanded(
                child: new QuestionBox(),
              ),
              NumberButtons(
                onTapNumber: session.addNumber,
                onClear: session.clearNumber,
                onCheck: () {
                  session.checkAnswer(ifComplete: () {
                    Navigator.of(context).pushReplacementNamed('/results');
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SessionState state = StateContainer.of(context);
    final MediaQueryData data = MediaQuery.of(context);
    final double width = (data.size.width / state.target.toDouble()) *
        state.total.toDouble();
    return Container(
      height: 10,
      width: data.size.width,
      color: Color.fromARGB(255, 70, 70, 70),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Container(
          height: 10,
          width: width,
          color: Colors.blue,
        ),
      ),
    );
  }
}

class QuestionBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SessionState session = StateContainer.of(context);

    final MediaQueryData queryData = MediaQuery.of(context);
    final double digitsSize =
        (queryData.size.width > 400.0 ? 52 : 42);
    final double symbolsSize = digitsSize / 1.33;
    if (session.multiplication == null) {
      return Container();
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/${session.multiplication.a}.png',
            width: digitsSize,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Image.asset(
              'assets/x.png',
              width: symbolsSize,
            ),
          ),
          Image.asset(
            'assets/${session.multiplication.b}.png',
            width: digitsSize,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15),
            child: Image.asset(
              'assets/eq.png',
              width: symbolsSize,
            ),
          ),
          Expanded(
            child: Container(
              height: 120,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Color.fromARGB(30, 255, 255, 255),
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < session.answer.length; i++)
                    Image.asset(
                      'assets/${session.answer[i]}.png',
                      width: digitsSize,
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ScoreBox extends StatefulWidget {
  final int score;
  final Color color;
  final IconData icon;
  final Offset offset; // HACK TOTAL!

  ScoreBox({
    @required this.score,
    @required this.color,
    @required this.icon,
    @required this.offset,
  });

  @override
  _ScoreBoxState createState() => _ScoreBoxState();
}

class _ScoreBoxState extends State<ScoreBox>
    with SingleTickerProviderStateMixin {
  int _score;
  AnimationController _controller;
  Animation _animation;
  Matrix4 _transform;

  @override
  void initState() {
    _score = widget.score;

    final Matrix4 doublesize =
        Matrix4.diagonal3(vmath.Vector3(1.8, 1.8, 1.8));
    final Matrix4 normalsize =
        Matrix4.diagonal3(vmath.Vector3(1, 1, 1));

    _transform = doublesize;
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _animation = _controller
        .drive(Matrix4Tween(begin: doublesize, end: normalsize));
    _controller.forward();
    _controller.addListener(() {
      setState(() {
        _transform = _animation.value;
      });
    });
    super.initState();
  }

  @override
  void didUpdateWidget(ScoreBox oldWidget) {
    if (widget.score != _score) {
      _controller.reset();
      _controller.forward();
      _score = widget.score;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
      origin: widget.offset,
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
        borderSide: BorderSide(
          color: Color.fromARGB(100, 255, 255, 255),
          width: 2,
        ),
        shape: StadiumBorder(),
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Text(
            '$n',
            style: TextStyle(
              fontSize: 40,
              color: Color.fromARGB(200, 255, 255, 255),
            ),
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
                child: Icon(
                  Icons.delete,
                  size: 40,
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                this.onClear();
              },
            ),
            _button(0, context),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FlatButton(
                color: Colors.green,
                shape: StadiumBorder(),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.check,
                    size: 48,
                    color: Colors.white,
                  ),
                ),
                onPressed: () {
                  this.onCheck();
                },
              ),
            ),
          ])
        ],
      ),
    );
  }
}
