import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///The [Comments] class returns the comments icon and the number of comments on the post
class Comments extends StatelessWidget {
  Comments({@required this.chosenIcon, @required this.faves});
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
