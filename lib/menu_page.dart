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
            MenuButton(1),
            MenuButton(5),
            MenuButton(10),
            MenuButton(30),
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
      text: '$mults ${mults > 1 ? 'Multiplicacions' : 'Multiplicació'}',
      onPressed: () {
        SessionState session = SessionContainer.of(context);
        session.reset(mults);
        Navigator.of(context).pushNamed('/practice');
      },
    );
  }
}
