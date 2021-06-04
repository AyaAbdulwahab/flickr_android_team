import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/View_Model/photo_view_model.dart';
import 'package:flickr/View_Model/user_func_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flickr/Views/photo_onclicking.dart';
import 'package:flickr/Models/user_model.dart';
import 'package:provider/provider.dart';

int imagesNo = 0;

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

  Future<int> callFunction(String token) async {
    for (int i = 0; i < _iDs.length; i++) {
      _photos.add(await getPhotoDetails(_iDs[i].id, token));
    }
    setState(() {
      _photos = _photos;
    });
    print('ana ba3d el for');
    return 1;
  }

  void callTheFunctions() async {
    final user = Provider.of<MyModel>(context, listen: false);
    await getIDs();
    await callFunction(user.getToken());
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
  int postFaves;
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
                    username: "userName",
                    userID: widget.images[index].userID,
                    userRealName: widget.images[index].userRealName,
                    privacy: false,
                    safety: 0,
                    views: "views",
                    dateTaken: widget.images[index].dateTaken,
                    caption: widget.images[index].caption,
                    description: widget.images[index].description,
                    tags: widget.images[index].tags,
                    faves: widget.postFaves,
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
