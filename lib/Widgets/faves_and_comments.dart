import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FavesAndComments extends StatelessWidget {
  FavesAndComments({@required this.chosenIcon, @required this.faves});
  final Icon chosenIcon;
  final String faves;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
       chosenIcon,
        Text(
          faves,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
