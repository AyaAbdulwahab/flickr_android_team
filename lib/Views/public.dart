import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flickr/Views/photo_onclicking.dart';
import 'package:http/http.dart' as http;
import 'package:flickr/Constants/constants.dart';
import 'package:flickr/Models/user_model.dart';
import 'package:flickr/View_Model/user_view_model.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0';
// String id = '608d55c7e512b74ee00791de';
int imagesNo = 0;

// void main() {
//   return runApp(
//       MaterialApp(
//           home: Public()
//       )
//   );
// }

///Class [Public] displays all the public images from the user's camera roll
class Public extends StatefulWidget {
  @override
  _PublicState createState() => _PublicState();
}

class _PublicState extends State<Public> {
  List<PhotoDetails> _photos = [];
  List<PhotosIDsPublic> _iDs;

  getIDs() async {
    final user = Provider.of<MyModel>(context, listen: false);
    _iDs = await public(user.getID());
    print('GetIDS');
    return 1;
  }

  Future<int> callFunction() async {
    for (int i = 0; i < _iDs.length; i++) {
      _photos.add(await getPhotoDetails(_iDs[i].id));
    }
    setState(() {
      _photos = _photos;
    });
    print('ana ba3d el for');
    return 1;
  }

  void callTheFunctions() async {
    await getIDs();
    await callFunction();
  }

  void initState() {
    super.initState();
    callTheFunctions();
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
        child: Scaffold(body: ImagesGrid(images: _photos)),
      ),
    );
  }
}

class ImagesGrid extends StatefulWidget {
  ImagesGrid({@required this.images});
  List<PhotoDetails> images;
  List<PhotosIDsPublic> iDs;
  String userID;
  String userName;
  String userRealName;
  String userImage;
  String postImage;
  List<dynamic> tags;
  String caption;
  String description;
  String postDate;
  String dateTaken;
  String postFaves;
  bool privacy;
  int safety;
  String views;
  List<dynamic> postComments;
  String comment1;
  int commentNumber;
  @override
  _ImagesGridState createState() => _ImagesGridState();
}

class _ImagesGridState extends State<ImagesGrid> {
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: widget.images.length,
      // list of images
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PhotoOnClicking(
                    photoID: widget.iDs[index].id,
                    image: widget.images[index].postImage,
                    userImage: widget.images[index].userImage,
                    username: widget.images[index].userName,
                    userID: widget.images[index].userID,
                    userRealName: widget.images[index].userRealName,
                    privacy: widget.images[index].privacy,
                    safety: widget.images[index].safety,
                    views: widget.images[index].views,
                    dateTaken: widget.images[index].dateTaken,
                    caption: widget.images[index].caption,
                    description: widget.images[index].description,
                    tags: widget.images[index].tags,
                    faves: widget.images[index].postFaves,
                    comments: (widget.images[index].commentsCount).toString())),
          );
        },
        child: Container(
          child: Image.network(widget.images[index].postImage),
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    );
  }
}
