import 'package:flickr/Models/photo_model.dart';
import 'package:flickr/Models/user_model.dart';
import 'package:flickr/View_Model/search_view_model.dart';
import 'package:flickr/Widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

String username = 'Someone'; //////////username??
int limit = 5;
int page = 1;
String photoID = 'a12345';
List<String> images = [];
List<String> photoURLs = [];


/// The [Home] class displays the explore posts on the user's home page
/// Consists of a list of [Post] widgets that is updated on scrolling
/// The [Home] sends the [photoID] to each [Post]
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> info;

  List<PhotosIDs> _ids = [];
  List<PhotosIDs> _fetchedIDs = [];
  int _threshold = 2;
  bool _error = false;
  bool _hasMore = false;
  bool _loading;
  int _page = 1;
  int _postsPerPage = 4;

  // ///Function getPhotoIDs gets the photo IDs of explore photos
  // void getPhotoIDs() async {
  //   var req2 = await http.get(
  //     (Uri.parse(EndPoints.mockBaseUrl + '/photo/explore')),
  //   );
  //   if (req2.statusCode == 200) {
  //     String data = req2.body;
  //     info = jsonDecode(data)['data'];
  //     print(data);
  //     setState(() {
  //       images = info['_id'];
  //       //   for(int i=0; i<images.length; i++)
  //       //   {
  //       //     images[i]=info[i]['_id'];
  //       //     print(images[i]);
  //       //   }
  //     });
  //   }
  // }

  // void getPhotoURLs() async {
  //   for(int i=0; i<images.length; i++)
  //   {
  //     // print(i);
  //     // print(images[i]);
  //     var req2 = await http.get(
  //       (Uri.parse(EndPoints.baseUrl + '/photo/'+images[i])),
  //     );
  //     if (req2.statusCode == 200) {
  //       String data = req2.body;
  //       // print(data);
  //       // info = jsonDecode(data)['data'];
  //       // // print(jsonDecode(data)['data']['photourl']);
  //       // // setState(() {
  //       //   photoURLs[i]= info['photourl'];
  //       // });
  //     }
  //   }
  // }
  @override
  void initState() {
    super.initState();
    getIDs();
    // getPhotoURLs();
  }

  getIDs() async {
    try {
      _fetchedIDs = await explore(_page, _postsPerPage);
      setState(() {
        _ids.addAll(_fetchedIDs);

        _loading = false;
        _page = _page + 1;
        return 1;
      });
    } catch (e) {
      print(e);
      _loading = false;
      _error = true;
    }
  }

  Post post;

  Widget build(BuildContext context) {
    final user = Provider.of<MyModel>(context, listen: false);
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          // height: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.height,
          child: Expanded(
            child: new ListView.builder(
              // padding: const EdgeInsets.all(16),
              // itemCount: _ids.length + (_hasMore ? 1 : 0),
              itemBuilder: (BuildContext context, int index) {
                if (_ids.length == 0)
                  return Container(
                    height: 10.0,
                  );
                if (index >= _ids.length) {
                  if (_error) {
                    return Center(
                        child: InkWell(
                      onTap: () {
                        setState(() {
                          _loading = true;
                          _error = false;
                          print("Error");
                          getIDs();
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                            "Error while loading photos, tap to try again"),
                      ),
                    ));
                  } else {
                    return Center(
                        child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: CircularProgressIndicator(),
                    ));
                  }
                } else {
                  return Post(photoID: _ids[index].id, token: user.getToken());
                }
                // print(_ids[index].id);
              },
            ),
          ),
        ),
      ),
    );
  }
}
