import 'package:flutter/material.dart';

class ColoredButton extends StatelessWidget {
  final Color color;
  final String text;
  final Function onPressed;

  ColoredButton({
    Key key,
    this.text,
    this.color = Colors.blue,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      child: TextButton(
        style: TextButton.styleFrom(
          shape: StadiumBorder(),
          backgroundColor: color,
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
            ),
          ),
        ),
        onPressed: onPressed,
      ),
    );
  }
}
