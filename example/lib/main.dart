import 'package:flutter/material.dart';
// Package Import Statement
import 'package:fc_loaders/fc_loaders.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const <Widget> [
            FCBallBounce(),
            FCBallBounce(
              loaderBallColor: Colors.amber, 
              duration: Duration(milliseconds: 100)
            )
          ],
        )
      ),
    );
  }
}

