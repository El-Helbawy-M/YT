import 'package:flutter/material.dart';

class LogButton extends StatelessWidget {
  const LogButton(this.title, this.onPressed);
  final Function onPressed;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextButton(
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 8),
          child: Center(child: Text(title, style: TextStyle(color: Colors.white, fontSize: 20))),
        ),
        style: TextButton.styleFrom(backgroundColor: Colors.green),
      ),
    );
  }
}
