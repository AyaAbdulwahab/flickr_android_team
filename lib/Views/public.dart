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
  String id;
  Public({this.id});

  @override
  _PublicState createState() => _PublicState();
}

class _PublicState extends State<Public> {
  List<PhotoDetails> _photos = [];
  List<PhotosIDsPublic> _iDs;

  getIDs() async {
    final user = Provider.of<MyModel>(context, listen: false);
    _iDs = await public(widget.id, user.getToken());
    print(_iDs[0].id);
    for (int i = 0; i < _iDs.length; i++) {
      _photos.add(await getPhotoDetails(_iDs[i].id, user.getToken()));
    }
    print('GetIDS');
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: getIDs(),
        builder: (context, snapshot) {
          print(_photos);
          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: SafeArea(
              child: Scaffold(body: ImagesGrid(images: _photos, iDs: _iDs)),
            ),
          );
        });
  }
}

class ImagesGrid extends StatefulWidget {
  ImagesGrid({@required this.images, this.iDs});
  List<PhotoDetails> images;
  List<PhotosIDsPublic> iDs;

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
          print(widget.iDs[index].id);
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
                    privacy: widget.images[index].permissions,
                    safety: 3,
                    views: widget.images[index].views.toString(),
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
