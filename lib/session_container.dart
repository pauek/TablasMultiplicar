import 'package:flutter/material.dart';
import 'package:tablas_multiplicar/model.dart';

class _InheritedStateContainer extends InheritedWidget {
  final SessionState session;

  _InheritedStateContainer({
    Key key,
    @required this.session,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class StateContainer extends StatefulWidget {
  final Widget child;
  final PracticeSession session;

  StateContainer({
    @required this.child,
    @required this.session,
  });

  @override
  SessionState createState() => SessionState();

  static SessionState of(BuildContext context) {
    return (context
            .dependOnInheritedWidgetOfExactType<_InheritedStateContainer>())
        .session;
  }
}

class SessionState extends State<StateContainer> {
  PracticeSession _session;
  Multiplication _multiplication;
  String _answer;

  initState() {
    super.initState();
    _session = widget.session;
  }

  int get target => _session.target;
  int get correct => _session.correct;
  int get wrong => _session.wrong;
  int get total => _session.total;

  String get secondsPerMultiplication => _session.perItem.toStringAsFixed(2);

  int get percentageCorrect {
    if (total == 0) {
      return 0;
    }
    return (100.0 * (correct.toDouble() / total.toDouble())).toInt();
  }

  String get answer => _answer;
  Multiplication get multiplication => _multiplication;

  checkAnswer({Function ifComplete}) {
    setState(() {
      if (int.parse(_answer) == _multiplication.result) {
        _session.incrementCorrect();
        _multiplication = _session.next();
      } else {
        _session.incrementWrong();
      }
      _answer = '';
    });
    if (_session.isComplete) {
      _session.finish();
      ifComplete();
    }
  }

  addNumber(n) {
    if (_answer.length < 2) {
      setState(() => _answer += '$n');
    }
  }

  clearNumber() {
    setState(() => _answer = '');
  }

  reset(int mults) {
    setState(() {
      _session.reset(mults);
      _multiplication = _session.next();
      _answer = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedStateContainer(
      session: this,
      child: widget.child,
    );
  }
}
