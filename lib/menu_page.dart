import 'package:flutter/material.dart';
import 'package:tablas_multiplicar/colored_button.dart';
import 'package:tablas_multiplicar/session_container.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var n in [1, 5, 10, 30, 50, 100]) MenuButton(n),
          ],
        ),
      ),
    );
  }
}

class MenuButton extends StatelessWidget {
  final int mults;

  MenuButton(this.mults);

  @override
  Widget build(BuildContext context) {
    return ColoredButton(
      text:
          '$mults ${mults > 1 ? 'Multiplicacions' : 'Multiplicació'}',
      onPressed: () {
        SessionState session = SessionContainer.of(context);
        session.reset(mults);
        Navigator.of(context).pushNamed('/practice');
      },
    );
  }
}
