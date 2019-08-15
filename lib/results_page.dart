import 'package:flutter/material.dart';
import 'package:tablas_multiplicar/session_container.dart';
import 'package:tablas_multiplicar/colored_button.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SessionState session = SessionContainer.of(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 220, 220),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'Has fet una multiplicació cada ${session.itemsPerSecond} segons',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
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
                    Navigator.of(context)
                        .popAndPushNamed('/');
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

