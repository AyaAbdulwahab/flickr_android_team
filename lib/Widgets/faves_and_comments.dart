import 'package:flickr/View_Model/photo_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/////THE DATA FOR ADD AND REMOVE FAVES!!
class FavesAndComments extends StatefulWidget {
  FavesAndComments(
      {@required this.chosenIcon,
      @required this.faves,
      @required this.photoID,
      @required this.token,
      @required this.userID});
  Icon chosenIcon;
  int faves;
  String photoID;
  String userID;
  String token;
  @override
  _FavesAndCommentsState createState() => _FavesAndCommentsState();
}

class _FavesAndCommentsState extends State<FavesAndComments> {
  int faves = 0;

  @override
  Widget build(BuildContext context) {
    if (faves == 0) faves = widget.faves;
    print("FAVES:" + faves.toString());
    print("WIDGET FAVES:" + widget.faves.toString());
    return Container(
      child: Row(
        children: [
          IconButton(
              icon: widget.chosenIcon,
              onPressed: () {
                setState(() {
                  if (widget.chosenIcon.icon == Icons.star_border_outlined) {
                    widget.chosenIcon = Icon(Icons.star, color: Colors.grey);
                    faves++;

                    addFave(widget.photoID, widget.token);
                  } else if (widget.chosenIcon.icon == Icons.star) {
                    widget.chosenIcon =
                        Icon(Icons.star_border_outlined, color: Colors.grey);
                    removeFave(widget.photoID, widget.token);
                    faves--;
                  }
                });
              }),
          Text(
            faves.toString(),
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
