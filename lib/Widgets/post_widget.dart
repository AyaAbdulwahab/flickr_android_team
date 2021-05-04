import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          //Flickr FAQs bar
          // Container(
          //   color: Colors.white,
          //   width: double.infinity,
          //   height: 50.0,
          //   child: Row(
          //     children: [
          //       Padding(
          //         padding: const EdgeInsets.all(10.0),
          //         child: OutlinedButton(
          //           child: Center(
          //             child: Row(children: [
          //               Text(
          //                 'flick',
          //                 style: TextStyle(
          //                     color: Colors.blue,
          //                     fontFamily: 'Righteous-Regular.ttf', fontSize: 20.0),
          //               ),
          //               Text(
          //                 'r ',
          //                 style: TextStyle(
          //                     color: Colors.pink,
          //                     fontFamily: 'Righteous-Regular.ttf', fontSize: 20.0),
          //               ),
          //               Text(
          //                 'FAQs',
          //                 style: TextStyle(
          //                   color: Colors.black,
          //                   fontFamily: 'OpenSansCondensed-Light300.ttf', fontSize: 15.0, ),
          //                 // textAlign: Alignment.bottomCenter,
          //               ),
          //             ]),
          //           ),
          //           onPressed: () {},
          //         ),
          //       ),
          //       SizedBox(
          //         width: 8.0,
          //       ),
          //       Text('Sharing on Flickr.'),
          //     ],
          //   ),
          // ),
          //
          Container(
            child: Image(
              image: NetworkImage(widget.postImage),
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
              children: [
                Icon(
                  Icons.star_border_outlined,
                  size: 25.0,
                  color: Colors.grey,
                ),
                Text(
                  widget.postFaves,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  width: 125.0,
                ),
                Icon(
                  Icons.comment,
                  size: 25.0,
                  color: Colors.grey,
                ),
                Text(
                  widget.postComments,
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(
                  width: 125.0,
                ),
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
