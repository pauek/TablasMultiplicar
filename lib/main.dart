import 'package:flutter/material.dart';
import 'package:tablas_multiplicar/menu_page.dart';
import 'package:tablas_multiplicar/model.dart';
import 'package:tablas_multiplicar/results_page.dart';
import 'package:tablas_multiplicar/session_page.dart';
import 'package:tablas_multiplicar/session_container.dart';

void main() {
  runApp(MyApp());
}

var routes = {
  '/': (context) => MenuPage(),
  '/practice': (context) => PracticePage(),
  '/results': (context) => ResultsPage(),
};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SessionContainer(
      session: PracticeSession(),
      child: MaterialApp(
        title: 'Multiplicacions',
        routes: routes,
        initialRoute: '/',
      ),
    );
  }
}
