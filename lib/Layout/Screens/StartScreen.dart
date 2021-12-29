import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 60, vertical: 60),
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.green,
              ),
              child: FlatButton(
                onPressed: () => Navigator.pushReplacementNamed(context, "MS"),
                child: Center(
                  child: Text("Start",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                ),
              ),
            )
          ],
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage("Icons/Buffalo Burger Egypt.jpg"),
          ),
        ),
      ),
    );
  }
}
