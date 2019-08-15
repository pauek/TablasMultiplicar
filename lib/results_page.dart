import 'package:flutter/material.dart';
import 'package:tablas_multiplicar/session_container.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SessionState session = SessionContainer.of(context);
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 220, 220, 220),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text('Items per second: ${session.itemsPerSecond}'),
            RaisedButton(
              child: Text('Restart'),
              onPressed: () {
                // TODO: Save session data!
                session.reset();
                Navigator.of(context).popAndPushNamed('/practice');
              },
            ),
          ],
        ),
      ),
    );
  }
}
