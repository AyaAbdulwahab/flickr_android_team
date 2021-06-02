import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Widgets/faves_and_comments.dart';
import 'package:flickr/Widgets/comments.dart';
import 'package:flickr/Views/photo_onclicking.dart';
import 'package:http/http.dart' as http;
import 'package:flickr/Constants/constants.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class Post extends StatefulWidget {
  Post({
    @required this.photoID,
    @required this.token,
  });

  String photoID;
  String userID;
  String userImage;
  String postImage;
  String userName;
  String userRealName;
  String caption; //also title
  String postDate;
  String postFaves;
  bool privacy;
  int safety;
  String views;
  String token;
  String description;
  String dateTaken;

  List<dynamic> postComments;
  List<dynamic> tags;
  // String likers;
  // String commenter;
  String comment1;
  String commenter;
  String fave1;
  String fave2;
  int commentNumber;

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> {
  Map<String, dynamic> info;

  ///The function getDetails gets the photo information using the photo [id]
  void getDetails() async {
    var req2 = await http
        .get((Uri.parse(EndPoints.mockBaseUrl + '/photo/' + widget.photoID)));
    if (req2.statusCode == 200) {
      String data = req2.body;
      print(data);
      info = jsonDecode(data)['data'];
      setState(() {
        widget.userID = info['userId']['_id'];
        widget.userName = info['userId']['displayName'];
        widget.userRealName = info['userId']['firstName'];
        widget.userImage = 'https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80';
        widget.postImage = info['sizes']['size']['original']['url'];
        widget.tags= info['tags'];
        widget.caption = info['title'];
        widget.description = info['description'];
        widget.postDate =
            DateFormat.yMd().format(DateTime.parse(info['dateUploaded']));
        widget.dateTaken = info['dateTaken'];
        widget.privacy=info['permissions']['public'];
        widget.safety=info['safetyLevel'];
        // print(widget.postDate);
        widget.postFaves = info['favourites'].toString();
        widget.views = info['views'].toString();
        widget.postComments = info['comments'];
        widget.comment1 = info['comments'][0]['body'];
        widget.commenter = info['comments'][0]['userId']['displayName'];
        widget.commentNumber = (widget.postComments).length;
      });
    }
  }
  //
  // ///The function getUserName gets  the username using the user id
  // void getUserName() async {
  //   var req2 = await http.get((Uri.parse(
  //       EndPoints.mockBaseUrl + '/user/' + widget.userID + '/disp-name')));
  //   if (req2.statusCode == 200) {
  //     String data = req2.body;
  //     print(data);
  //     info = jsonDecode(data)['data'];
  //     setState(() {
  //       widget.userName = info['displayName'];
  //       //USER PROFILE PICTURE!
  //       widget.userImage =
  //       'https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80';
  //     });
  //   }
  // }
  //
  // ///The function getUserRealName gets the user's real name using the user id
  // void getUserRealName() async {
  //   var req2 = await http.get((Uri.parse(
  //       EndPoints.mockBaseUrl + '/user/' + widget.userID + '/real-name')));
  //   if (req2.statusCode == 200) {
  //     String data = req2.body;
  //     print(data);
  //     info = jsonDecode(data)['data'];
  //     setState(() {
  //       widget.userRealName = info['firstName'];
  //     });
  //   }
  // }


  ///The function getFaves gets the photo faves using the photo id
  void getFaves() async {
    var req2 = await http.get((Uri.parse(
        EndPoints.mockBaseUrl + '/photo/' + widget.photoID + '/faves')));
    if (req2.statusCode == 200) {
      String data = req2.body;
      print(data);
      info = jsonDecode(data)['data'];
      setState(() {
        widget.fave1 = info['usernamelist'][0].toString();
        widget.fave2 = info['usernamelist'][1].toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getDetails();
    getFaves();
  }

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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhotoOnClicking(
                          image: widget.postImage,
                          userImage: widget.userImage,
                          username: widget.userName,
                          userID: widget.userID,
                          userRealName: widget.userRealName,
                          privacy: widget.privacy,
                          safety: widget.safety,
                          views: widget.views,
                          dateTaken: widget.dateTaken,
                          caption: widget.caption,
                          description: widget.description,
                          tags: widget.tags,
                          faves: widget.postFaves,
                          comments: widget.postComments.toString())),
                );
              },
            ),
            margin: EdgeInsets.all(5.0),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 23.0,
              // backgroundImage: NetworkImage(widget.userImage),
            ),
            title: Text(
              widget.userName,
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
                FavesAndComments(
                    chosenIcon: Icon(Icons.star_border_outlined),
                    faves: widget.postFaves,
                    photoID: widget.photoID,
                    token: widget.token,
                    userID: widget.userID),
                Comments(
                    chosenIcon: Icon(Icons.comment),
                    faves: widget.commentNumber.toString()),
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
                  // title: Text('people faved'),
                  title: Text(widget.fave1+', '+widget.fave2+' and '+(((int.parse(widget.postFaves))-2)).toString()+' others faved'),
                ),
                ListTile(
                  isThreeLine: true,
                  leading: Icon(
                    Icons.mode_comment,
                    size: 20.0,
                  ),
                  title: Text(widget.commenter),
                  subtitle: Text(
                      widget.comment1
                  ),
                  trailing: Text('1 of ' + widget.commentNumber.toString()),
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
