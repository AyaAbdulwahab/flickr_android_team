import 'package:flickr/Views/photo_onclicking.dart';
import 'package:flickr/Widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flickr/Constants/constants.dart';
import 'dart:convert';

import '../Models/user_model.dart';
import '../View_Model/user_view_model.dart';

String token =
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0';
String id = '608d55c7e512b74ee00791de';
String username = 'Someone'; //////////username??
int limit = 5;
int page = 1;
String photoID = 'a12345';
List<String> images = [];
List<String> photoURLs = [];

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

  ///Function getPhotoIDs gets the photo IDs of explore photos
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
    // _ids=await explore(_page,_postsPerPage);
    // setState(() {
    //   _ids= _ids;
    // });
    try {
      print("---------------------->  getIDs()");
      _fetchedIDs = await explore(_page, _postsPerPage);
      print(_fetchedIDs);
      //
      setState(() {
        _ids.addAll(_fetchedIDs);
        // _hasMore = fetchedPhotos.length == _defaultPhotosPerPageCount;

        _loading = false;
        _page = _page + 1;
        print("----------------> Returning from getIDs()");
        // notifyListeners();
        return 1;
      });
    } catch (e) {
      print(e);
      _loading = false;
      _error = true;
    }
  }

  List<Post> postList = [
    Post(
      photoID: photoID, token: token,
      // userImage:
      // 'https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80',
      // username: 'User1',
      // postImage:
      // 'https://media.istockphoto.com/photos/landscape-with-milky-way-night-starry-sky-universe-picture-id538595858?k=6&m=538595858&s=170667a&w=0&h=g24svdogmqZ75YwJGcIOebtmTFujPQ78yzdw552BkJk=',
      // // photoURLs[0],
      // postComments: '40',
      // postDate: '1mo',
      // postFaves: '100',
      // caption: 'insert caption',
      // comment: 'comment',
      // commenter: 'commenter',
      // commentNumber: '40 of 40',
      // likers: 'Person 1, Person 2 and 98 others faved',
    ),
    Post(
      photoID: photoID, token: token,
      //   userImage:
      //   'https://static.onecms.io/wp-content/uploads/sites/9/2018/03/jenne-claiborne-ft-blog0318.jpg',
      //   username: 'User2',
      //   postImage:
      //   'https://fivmagazine.com/wp-content/uploads/2017/06/blogger-fashion-style-outfit-beauty-travel-instagram-influencer-streetstyle-girl-hat-lace-1030x515.jpg',
      //   // photoURLs[1],
      //   postComments: '40',
      //   postDate: '1mo',
      //   postFaves: '100',
      //   caption: 'insert caption',
      //   comment: 'comment',
      //   commenter: 'commenter',
      //   commentNumber: '40 of 40',
      //   likers: 'Person 1, Person 2 and 98 others faved',
    ),
    Post(
      photoID: photoID, token: token,
      // userImage:
      // 'https://i.pinimg.com/736x/90/d1/02/90d10264c0fbc29ede6a9bdd729a6e2c.jpg',
      // username: 'User3',
      // postImage:
      // 'https://www.food.ee/wp-content/uploads/2017/08/foodbloggers.jpg',
      // // photoURLs[2],
      // postComments: '40',
      // postDate: '1mo',
      // postFaves: '100',
      // caption: 'insert caption',
      // comment: 'comment',
      // commenter: 'commenter',
      // commentNumber: '40 of 40',
      // likers: 'Person 1, Person 2 and 98 others faved',
    ),
    Post(
      photoID: photoID, token: token,
      // userImage:
      // 'https://expertphotography.com/wp-content/uploads/2018/10/cool-profile-pictures-retouching-1.jpg',
      // username: 'User4',
      // postImage:
      // 'https://southeastasiabackpacker.com/wp-content/uploads/2017/12/jean-gerber-photography.jpg',
      // // photoURLs[3],
      // postComments: '40',
      // postDate: '1mo',
      // postFaves: '100',
      // caption: 'insert caption',
      // comment: 'comment',
      // commenter: 'commenter',
      // commentNumber: '40 of 40',
      // likers: 'Person 1, Person 2 and 98 others faved',
    ),
    Post(
      photoID: photoID, token: token,
      // userImage:
      // 'https://i.pinimg.com/originals/00/e9/62/00e962900b44ba40dc23d436e12ad8e4.png',
      // username: 'User5',
      // postImage:
      // 'https://image.winudf.com/v2/image1/Y29tLkJlYWNoLkJhbGlCZWFjaFZpZXdzd2FsbHBhcGVyX3NjcmVlbl85XzE1NTQ5MTU1OTRfMDkw/screen-9.jpg?fakeurl=1&type=.jpg',
      // // photoURLs[4],
      // postComments: '40',
      // postDate: '1mo',
      // postFaves: '100',
      // caption: 'insert caption',
      // comment: 'comment',
      // commenter: 'commenter',
      // commentNumber: '40 of 40',
      // likers: 'Person 1, Person 2 and 98 others faved',
    ),
  ];
  Post post;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    // color: Colors.black,
                    height: MediaQuery.of(context).size.height,
                    child: new ListView.builder(
                      itemCount: _ids.length + (_hasMore ? 1 : 0),
                      itemBuilder: (BuildContext context, int index) {
                        if (index == _ids.length - _threshold) {
                          print("Reached end of list");
                          getIDs();
                        }
                        if (index == _ids.length) {
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
                        }
                        return Post(photoID: _ids[index].id, token: token);
                      },
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
