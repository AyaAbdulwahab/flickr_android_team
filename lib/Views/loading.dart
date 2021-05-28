import 'dart:async';

import 'package:flutter/material.dart';

/// [LoadingPage] is the page that appears to the user while
/// waiting for the data to be fetched from the backend
class LoadingPage extends StatefulWidget {
  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  /// A boolean to change the state of the app through it
  bool change = true;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 3), (time) {
      setState(() {
        change = !change;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /// Get the width of the screen
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
      children: [
        AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            top: MediaQuery.of(context).size.height / 2,
            left: change ? (width / 2 + 25.0) : (width / 2 - 25.0),
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration:
                  BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
            )),
        AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            top: MediaQuery.of(context).size.height / 2,
            left: change ? (width / 2 - 25.0) : (width / 2 + 25.0),
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ))
      ],
    ));
  }
}