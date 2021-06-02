import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flickr/Views/photo_onclicking.dart';
import 'package:http/http.dart' as http;
import 'package:flickr/Constants/constants.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0';
String id = '608d55c7e512b74ee00791de';
int imagesNo=0;
List<String> images = [];

///Class [Public] displays all the public images from the user's camera roll
class Public extends StatefulWidget {
  @override
  _PublicState createState() => _PublicState();
}

class _PublicState extends State<Public> {

  ///Function getPublic gets all the public images from the user's camera roll using his/her [id]
  void getPublic() async {
    Map<String, dynamic> info;
    var req2 = await http.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + id + '/stream')),
    );
    if (req2.statusCode == 200) {
      String data = req2.body;
      info = jsonDecode(data)['data'];
      setState(() {
        images = info['photos']['photos']['_id'];
        imagesNo = images.length;
      });
    }
  }

  void initState() {
    super.initState();
    getPublic();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SafeArea(
        child: Scaffold(
            body: ImagesGrid(images: images)),
      ),
    );
  }
}

class ImagesGrid extends StatelessWidget {
  ImagesGrid({@required this.images});
  List<String> images;
  String userID;
  String userName;
  String userRealName;
  String userImage;
  String postImage;
  List<dynamic>tags;
  String caption;
  String description;
  String postDate;
  String dateTaken;
  String postFaves;
  bool privacy;
  int safety;
  String views;
  List<dynamic>postComments;
  String comment1;
  int commentNumber;

  @override
  ///The function getDetails gets the photo information using the photo [id]
  void getDetails(String id) async {
    Map<String, dynamic> info;
    var req2 = await http.get((Uri.parse(EndPoints.mockBaseUrl + '/photo/' + id)));
    if (req2.statusCode == 200) {
      String data = req2.body;
      print(data);
      info = jsonDecode(data)['data'];
        userID = info['userId']['_id'];
        userName = info['userId']['displayName'];
        userRealName = info['userId']['firstName'];
        userImage = 'https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80';
        postImage = info['sizes']['size']['original']['url'];
        tags= info['tags'];
        caption = info['title'];
        description = info['description'];
        postDate = DateFormat.yMd().format(DateTime.parse(info['dateUploaded']));
        dateTaken = info['dateTaken'];
        privacy=info['permissions']['public'];
        safety=info['safetyLevel'];
        // print(widget.postDate);
        postFaves = info['favourites'].toString();
        views = info['views'].toString();
        postComments = info['comments'];
        comment1 = info['comments'][0]['body'];
        // commenter = info['comments'][0]['userId']['displayName'];
        commentNumber = (postComments).length;
    }
  }


  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: imagesNo, // list of images
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          getDetails(images[index]);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PhotoOnClicking(
                  image: postImage,
                  userImage: userImage,
                  username: userName,
                  userID: userID,
                  userRealName: userRealName,
                  privacy: privacy,
                  safety: safety,
                  views: views,
                  dateTaken: dateTaken,
                  caption: caption,
                  description: description,
                  tags: tags,
                  faves: postFaves,
                  comments: postComments.toString())),
          );
        },
        child: Container(
          child: Image.network(images[index]),
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    );
  }
}
