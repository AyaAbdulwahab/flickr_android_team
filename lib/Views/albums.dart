import 'package:flickr/Models/albums_model.dart';
import 'package:flickr/View_Model/albums_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Models/user_model.dart';
import 'package:flutter/cupertino.dart';

/// The list of albums for the current user
List<UserAlbum> userAlbums = [];

/// The [Albums] page is a tab in the user Profile where it displays their current albums with numbers of photos for each album
class Albums extends StatefulWidget {
  String id;
  Albums({this.id});

  @override
  _AlbumsState createState() => _AlbumsState();
}

class _AlbumsState extends State<Albums> {
  @override
  void initState() {
    super.initState();
    sendAlbumsRequest();
  }

  sendAlbumsRequest() async {
    try {
      final user = Provider.of<MyModel>(context, listen: false);
      userAlbums = await getUserAlbums(
          user.getID() == widget.id, widget.id, user.getToken());
      setState(() {
        userAlbums = userAlbums;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.separated(
        itemCount: userAlbums.length,
        // padding: const EdgeInsets.all(8),
        itemBuilder: (BuildContext context, int index) {
          return AlbumCard(index: index);
        },
        separatorBuilder: (BuildContext context, int index) =>
            SizedBox(height: 10),
      ),
    );
  }
}

class AlbumCard extends StatelessWidget {
  AlbumCard({@required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          print("Album pressed");
        },
        child: Card(
          elevation: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          image: DecorationImage(
                              image:
                                  NetworkImage(userAlbums[index].primaryPhoto),
                              fit: BoxFit.fill),
                        ),
                      ),
                      SizedBox(width: 10.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(height: 7.0),
                            Text(userAlbums[index].albumName,
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            SizedBox(height: 50.0),
                            Text(userAlbums[index].photoCount + " photos",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600)),
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
