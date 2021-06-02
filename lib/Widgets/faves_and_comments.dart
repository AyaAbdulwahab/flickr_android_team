import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flickr/Constants/constants.dart';
import 'package:flickr/View_Model/user_view_model.dart';
import 'dart:convert';

/////THE DATA FOR ADD AND REMOVE FAVES!!
class FavesAndComments extends StatefulWidget {
  FavesAndComments({@required this.chosenIcon, @required this.faves, @required this.photoID, @required this.token, @required this.userID});
  Icon chosenIcon;
  String faves;
  String photoID;
  String userID;
  String token;
  @override
  _FavesAndCommentsState createState() => _FavesAndCommentsState();
}

class _FavesAndCommentsState extends State<FavesAndComments> {

  // Map<String, dynamic> info;


  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
            icon:
            widget.chosenIcon,
            onPressed: () {
              setState(() {
                if (widget.chosenIcon.icon==Icons.star_border_outlined)
                {
                  widget.chosenIcon=Icon(Icons.star, color: Colors.white);
                  addFave(widget.photoID,widget.token);
                }
                else if (widget.chosenIcon.icon==Icons.star){
                  widget.chosenIcon=Icon(Icons.star_border_outlined, color: Colors.white);
                  removeFave(widget.photoID,widget.token);
                }
              });
            }),
        Text(
          widget.faves,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
