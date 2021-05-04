import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  // isCollapsed: true,
  // border: InputBorder.none,
  contentPadding: EdgeInsets.fromLTRB(8.0, 26.0, 0.0, 4.0),
  enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
  focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 0.5)),
  errorBorder:
      OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.red)),
  focusedErrorBorder:
      OutlineInputBorder(borderSide: BorderSide(width: 0.5, color: Colors.red)),
);

Widget addText(String data, bool hyperlink) {
  return Text(
    data,
    style: TextStyle(
      fontSize: 13.0,
      color: hyperlink ? Colors.blue[800] : Colors.grey,
    ),
  );
}
