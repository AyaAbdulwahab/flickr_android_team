import 'package:flickr/Models/user_model.dart';
import 'package:flickr/View_Model/photo_view_model.dart';
import 'package:flickr/Views/loading.dart';
import 'package:flickr/Views/you.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Views/photo_details.dart';
import 'package:provider/provider.dart';

///The [PhotoOnClicking] class displays the photo and all the needed information about it
///It takes the required data about the photo when it is clicked from the [Post] widget
///When clicking on the more info icon, it navigates to [PhotoDetails]
class PhotoOnClicking extends StatefulWidget {
  String photoID,
      image,
      userImage,
      username,
      userRealName,
      userID,
      description,
      dateTaken,
      caption,
      views,
      comments;
  int safety, faves;
  bool privacy;
  List<dynamic> tags;
  PhotoOnClicking(
      {@required this.photoID,
      @required this.image,
      @required this.userImage,
      @required this.username,
      @required this.userID,
      @required this.userRealName,
      @required this.privacy,
      @required this.safety,
      @required this.views,
      @required this.dateTaken,
      @required this.caption,
      @required this.description,
      @required this.tags,
      @required this.faves,
      @required this.comments});
  Icon s = Icon(
    Icons.star_border_outlined,
    color: Colors.white,
  );
  @override
  _PhotoOnClickingState createState() => _PhotoOnClickingState();
}

class _PhotoOnClickingState extends State<PhotoOnClicking> {
  int faves;
  bool first = true;

  @override
  void initState() {
    super.initState();
    faves = widget.faves;
    first = true;
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyModel>(context, listen: false);

    String token = user.getToken();
    return FutureBuilder(
        future: isFaved(widget.userID, widget.photoID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            bool a = snapshot.data;
            print(a);
            if (first)
              widget.s = a
                  ? Icon(Icons.star, color: Colors.white)
                  : Icon(
                      Icons.star_border_outlined,
                      color: Colors.white,
                    );
            first = false;

            return Scaffold(
              body: SafeArea(
                child: Container(
                  color: Colors.black,
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    YouPage(id: widget.userID)),
                          );
                        },
                        leading: CircleAvatar(
                          radius: 23.0,
                          backgroundImage: NetworkImage(widget.userImage),
                        ),
                        title: Text(
                          widget.username,
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                        trailing: IconButton(
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey[200],
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                      ),
                      Expanded(
                        child: Image(
                          image: NetworkImage(widget.image),
                        ),
                      ),
                      ListTile(
                        title: Text(widget.caption,
                            style: TextStyle(color: Colors.white)),
                      ),
                      Divider(height: 1.0, color: Colors.grey[200]),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                IconButton(
                                    icon: widget.s,
                                    onPressed: () {
                                      setState(() {
                                        if (widget.s.icon ==
                                            Icons.star_border_outlined) {
                                          widget.s = Icon(Icons.star,
                                              color: Colors.white);
                                          faves++;
                                          addFave(widget.photoID, token);
                                        } else if (widget.s.icon ==
                                            Icons.star) {
                                          widget.s = Icon(
                                              Icons.star_border_outlined,
                                              color: Colors.white);
                                          faves--;
                                          removeFave(widget.photoID, token);
                                          print(faves.toString());
                                        }
                                      });
                                    }),
                                IconButton(
                                    icon: Icon(Icons.comment,
                                        color: Colors.white),
                                    onPressed: () {}),
                                IconButton(
                                    icon: Icon(Icons.share_outlined,
                                        color: Colors.white),
                                    onPressed: () {}),
                                IconButton(
                                    icon: Icon(Icons.info_outline,
                                        color: Colors.white),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PhotoDetails(
                                                  title: widget.caption,
                                                  description:
                                                      widget.description,
                                                  userRealName: widget.username,
                                                  userID: widget.userID,
                                                  dateTaken: widget.dateTaken,
                                                  tags: widget.tags,
                                                  privacy: widget.privacy,
                                                  views: widget.views,
                                                  safety: widget.safety,
                                                )),
                                      );
                                    }),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Text(
                              faves.toString() +
                                  ' faves\n' +
                                  widget.comments +
                                  ' comments',
                              style: TextStyle(color: Colors.white),
                              textAlign: TextAlign.end,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else
            return LoadingPage();
        });
  }
}
