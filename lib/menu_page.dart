import 'package:flutter/material.dart';
import 'package:tablas_multiplicar/session_container.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50, vertical: 150),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
          children: <Widget>[
            for (var n in [5, 10, 30, 50, 100]) MenuButton(n),
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
    return FlatButton(
      child: Text(
        '$mults',
        style: TextStyle(
          fontSize: 60,
          color: Colors.white,
        ),
      ),
      color: Color.fromARGB(255, 160, 180, 255),
      onPressed: () {
        SessionState session = StateContainer.of(context);
        session.reset(mults);
        Navigator.of(context).pushNamed('/practice');
      },
    );
  }
}
