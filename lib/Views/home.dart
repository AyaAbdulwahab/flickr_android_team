import 'package:flickr/Views/photo_onclicking.dart';
import 'package:flickr/Widgets/post_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flickr/Constants/constants.dart';
import 'dart:convert';

String token = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0';
String id = '608d55c7e512b74ee00791de';
String username = 'Someone'; //////////username??
int limit = 5;
int page = 1;
String photoID = 'a12345';
List <String> images=[];
// List <String> photoURLs=[];


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Map<String, dynamic> info;

  ///Function getPhotoIDs gets the photo IDs of explore photos
  void getPhotoIDs() async {
    var req2 = await http.get(
      (Uri.parse(EndPoints.mockBaseUrl + '/photo/explore')),
    );
    if (req2.statusCode == 200) {
      String data = req2.body;
      info = jsonDecode(data)['data'];
      print(data);
      setState(() {
        images = info['_id'];
      //   for(int i=0; i<images.length; i++)
      //   {
      //     images[i]=info[i]['_id'];
      //     print(images[i]);
      //   }
      });
    }
  }
  //
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

  void initState() {
    super.initState();
    getPhotoIDs();
  }

  List <Post> postList = [Post(photoID: photoID, token: token,
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
    Post(photoID: photoID, token: token,
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
    Post(photoID: photoID, token: token,
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
    Post(photoID: photoID, token: token,
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
    Post(photoID: photoID, token: token,
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
    ),];
  Post post;

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
            color: Colors.black,
            child: Column(
              children: [
                Expanded(
                  child: new ListView.builder(
                    itemCount: postList.length,
                    itemBuilder:(BuildContext context, int index)
                    {
                      post=postList[index];
                      return postList[index];
                    },
                  ),
                ),
              ],
            )
        ),
      ),
    );
  }
}
