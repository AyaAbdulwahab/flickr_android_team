import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Widgets/faves_and_comments.dart';
import 'package:flickr/Views/photo_onclicking.dart';

class Post extends StatefulWidget {
  Post({
    @required this.userImage,
    @required this.postImage,
    @required this.username,
    @required this.caption,
    @required this.postDate,
    @required this.postFaves,
    @required this.postComments,
    @required this.likers,
    @required this.commenter,
    @required this.comment,
    @required this.commentNumber,
  });

  final String userImage;
  final String postImage;
  final String username;
  final String caption;
  final String postDate;
  final String postFaves;
  final String postComments;
  final String likers;
  final String commenter;
  final String comment;
  final String commentNumber;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            child: GestureDetector(
              child: Image(
                image: NetworkImage(widget.postImage),
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhotoOnClicking(image:widget.postImage,userImage:widget.userImage, username: widget.username, caption: widget.caption, faves: widget.postFaves, comments: widget.postComments)),
                );
              },
            ),
            margin: EdgeInsets.all(5.0),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 23.0,
              backgroundImage: NetworkImage(widget.userImage),
            ),
            title: Text(
              widget.username,
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            ),
            subtitle: Text(
              widget.caption,
              style: TextStyle(fontSize: 18.0, color: Colors.grey),
            ),
            trailing: Text(widget.postDate),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: 20.0,
            child: Divider(
              color: Colors.grey,
              height: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 5.0, 20.0, 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FavesAndComments(chosenIcon: Icon(Icons.star_border_outlined), faves:  widget.postFaves),
                FavesAndComments(chosenIcon: Icon(Icons.comment), faves:  widget.postComments),
                Icon(
                  Icons.share_outlined,
                  size: 25.0,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
            child: Column(
              children: [
                ListTile(
                  leading: Icon(
                    Icons.star,
                    size: 20.0,
                  ),
                  title: Text(widget.likers),
                ),
                ListTile(
                  isThreeLine: true,
                  leading: Icon(
                    Icons.mode_comment,
                    size: 20.0,
                  ),
                  title: Text(widget.commenter),
                  subtitle: Text(widget.comment),
                  trailing: Text(widget.commentNumber),
                ),
                SizedBox(
                  height: 20.0,
                  child: Container(color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
