import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/View_Model/photo_view_model.dart';
import 'package:flickr/Views/loading.dart';
import 'package:flickr/Views/you.dart';
import 'package:flickr/Models/user_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Widgets/faves_and_comments.dart';
import 'package:flickr/Widgets/comments.dart';
import 'package:flickr/Views/photo_onclicking.dart';
import 'package:provider/provider.dart';

import '../Models/photo_model.dart';
import '../Views/photo_details.dart';
// import '../Views/photo_details.dart';
// import '../Views/photo_details.dart';
// import '../Views/photo_details.dart';
import '../Views/photo_details.dart';
import '../Views/photo_onclicking.dart';

/// The [Post] class takes the Photo [id] from the [Home] class and uses it to get all the required information for the post itself
/// The user is navigated to [PhotoOnClicking] class when the photo is clicked, with all the required information about the photo
class Post extends StatefulWidget {
  Post({
    @required this.photoID,
    @required this.token,
  });

  String photoID;
  String token;
  String fave1 = "person1";
  String fave2 = "person2";

  @override
  _PostState createState() => _PostState();
}

class _PostState extends State<Post> with AutomaticKeepAliveClientMixin {
  PhotoDetails _photo;

  var userImage =
      'https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80';

  ///The function getFaves gets the photo faves using the photo id
  getFaves() async {
    // var req2 = await http.get((Uri.parse(
    //     EndPoints.mockBaseUrl + '/photo/' + widget.photoID + '/faves')));
    // if (req2.statusCode == 200) {
    //   String data = req2.body;
    //   print(data);
    //   info = jsonDecode(data)['data'];
    setState(() {
      // info['usernamelist'][0].toString();

      // info['usernamelist'][1].toString();
    });
    // }
  }

  Future<int> callFunction() async {
    final user = Provider.of<MyModel>(context, listen: false);
    _photo = await getPhotoDetails(widget.photoID, user.getToken());

    return 1;
    // await getDetails();
    // await getFaves();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: callFunction(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return LoadingPage();
          } else {
            print(snapshot.data);
            return Container(
              color: Colors.white,
              height: MediaQuery.of(context).size.height * 0.65,
              width: 20.0,
              child: Column(
                children: [
                  Container(
                    height: 100.0,
                    child: GestureDetector(
                      // child: Image.asset("assets/zootopia.jpg"),
                      child: Image(
                        image: NetworkImage(_photo.postImage),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PhotoOnClicking(
                                  photoID: widget.photoID,
                                  image: _photo.postImage,
                                  userImage: userImage,
                                  username: _photo.userName,
                                  userID: _photo.userID,
                                  userRealName: _photo.userRealName,
                                  privacy: false,
                                  safety: 0,
                                  views: _photo.views.toString(),
                                  dateTaken: _photo.dateTaken,
                                  caption: _photo.caption,
                                  description: _photo.description,
                                  tags: _photo.tags,
                                  faves: _photo.postFaves,
                                  comments: _photo.commentsCount.toString())),
                        );
                      },
                    ),
                    margin: EdgeInsets.all(5.0),
                  ),
                  Card(
                    elevation: 0.0,
                    // shape: ShapeBorder,
                    margin: EdgeInsets.zero,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      leading: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      YouPage(id: _photo.userID)));
                        },
                        child: CircleAvatar(
                          radius: 23.0,
                          backgroundImage: NetworkImage(userImage),
                        ),
                      ),
                      // ),
                      title: Text(
                        _photo.userName,
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.04,
                            color: Colors.black),
                      ),
                      subtitle: Text(
                        "caption",
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                      trailing: Text(_photo.postDate),
                    ),
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
                            chosenIcon: Icon(Icons.star_border_outlined,
                                color: Colors.grey),
                            faves: _photo.postFaves,
                            photoID: widget.photoID,
                            token: widget.token,
                            userID: _photo.userID),
                        Comments(
                            chosenIcon: Icon(Icons.comment, color: Colors.grey),
                            faves: _photo.commentsCount.toString()),
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
                        if (_photo.postFaves > 0)
                          Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              leading: Icon(
                                Icons.star,
                                size: 20.0,
                              ),
                              // title: Text('people faved'),
                              title: Text(
                                "fave1" +
                                    ', ' +
                                    (_photo.postFaves == 1
                                        ? ""
                                        : "fave2" +
                                            (_photo.postFaves > 2
                                                    ? (" and " +
                                                        _photo.postFaves
                                                            .toString() +
                                                        " others faved")
                                                    : "")
                                                .toString()),
                              ),
                            ),
                          ),
                        if (_photo.commentsCount > 0)
                          Card(
                            margin: EdgeInsets.zero,
                            child: ListTile(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero),
                              isThreeLine: true,
                              leading: Icon(
                                Icons.mode_comment,
                                size: 20.0,
                              ),
                              title: Text('commenter'),
                              subtitle: Text("DA COMMENT"),
                              trailing: Text(
                                  '1 of ' + _photo.commentsCount.toString()),
                            ),
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
        });
  }
}
