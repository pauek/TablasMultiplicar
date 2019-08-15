import 'package:flutter/material.dart';
import 'package:tablas_multiplicar/session_container.dart';
import 'package:tablas_multiplicar/colored_button.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SessionState session = StateContainer.of(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 220, 220),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 120,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Molt bé!',
                style: TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                '${session.percentageCorrect}% correctes',
                style: TextStyle(
                  fontSize: 26,
                ),
              ),
              Text(
                '${session.secondsPerMultiplication} segons per multiplicació',
                style: TextStyle(
                  fontSize: 18,
                  fontStyle: FontStyle.italic,
                ),
              ),
              Expanded(child: Container()),
              ColoredButton(
                text: 'Una altra vegada',
                color: Colors.green,
                onPressed: () {
                  session.reset(session.target);
                  Navigator.of(context).popAndPushNamed('/practice');
                },
              ),
              ColoredButton(
                text: 'Torna al menú',
                color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
