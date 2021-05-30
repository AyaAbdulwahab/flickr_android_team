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
  Timer _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 3), (time) {
      setState(() {
        change = !change;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
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
            top: MediaQuery.of(context).size.height / 2 -
                MediaQuery.of(context).size.height * 0.03,
            left: change
                ? (width / 2 + width * 0.04)
                : (width / 2 - width * 0.04),
            child: Container(
              height: 30.0,
              width: 30.0,
              decoration:
                  BoxDecoration(color: Colors.pink, shape: BoxShape.circle),
            )),
        AnimatedPositioned(
            duration: Duration(milliseconds: 500),
            top: MediaQuery.of(context).size.height / 2 -
                MediaQuery.of(context).size.height * 0.03,
            left: change
                ? (width / 2 - width * 0.04)
                : (width / 2 + width * 0.04),
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
