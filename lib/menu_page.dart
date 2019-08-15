import 'package:flutter/material.dart';
import 'package:tablas_multiplicar/colored_button.dart';
import 'package:tablas_multiplicar/session_container.dart';

class MenuPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColoredButton(
          text: 'Practice',
          onPressed: () {
            SessionState session = SessionContainer.of(context);
            session.reset();
            Navigator.of(context).pushNamed('/practice');
          },
        ),
      ),
    );
  }
}
