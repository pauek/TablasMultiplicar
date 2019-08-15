import 'package:flutter/material.dart';
import 'package:tablas_multiplicar/model.dart';

class _InheritedSessionContainer extends InheritedWidget {
  final SessionState session;

  _InheritedSessionContainer({
    Key key,
    @required this.session,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;
}

class SessionContainer extends StatefulWidget {
  final Widget child;
  final PracticeSession session;

  SessionContainer({
    @required this.child,
    @required this.session,
  });

  @override
  SessionState createState() => SessionState();

  static SessionState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(
            _InheritedSessionContainer) as _InheritedSessionContainer)
        .session;
  }
}

class SessionState extends State<SessionContainer> {
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

  double get itemsPerSecond => _session.perItem;

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
    return _InheritedSessionContainer(
      session: this,
      child: widget.child,
    );
  }
}
