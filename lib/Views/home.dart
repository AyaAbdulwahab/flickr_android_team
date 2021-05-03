// import 'package:email_validator/email_validator.dart';
// import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:g_captcha/g_captcha.dart';

// class Home extends StatefulWidget {
//   @override
//   _SignUpState createState() => _SignUpState();
// }
//
// class _SignUpState extends State<Home> {
//   bool notRobot = false;
//   final _formKey = GlobalKey<FormState>();
//   String _firstName = "";
//   String _lastName = "";
//   String _age = "";
//   String _email = "";
//   String _password = "";
//   bool _obscureText = true;
//   bool passwordHint=false;
//   String CAPTCHA_SITE_KEY = "6LeePrkaAAAAAF1Tx8KEoVpDqCrHJDfwKPmsX5vX";
String _userImage = "https://images.unsplash.com/photo-1542103749-8ef59b94f47e?ixid=MnwxMjA3fDB8MHxzZWFyY2h8Mnx8cGVyc29ufGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80";
String _postImage = "https://southeastasiabackpacker.com/wp-content/uploads/2017/12/jean-gerber-photography.jpg";
String _username = "Hello";
String _caption = "insert caption";
String _postDate = "1mo";
String _postLikes = "500";
String _postComments = "40";
String _peopleLikes = "Jake Parelta, Ramond Holt and 98 others faved";
String _randomCommenter = "Charles Boyle";
String _randomComment = "GOALS!!!!!!";
String _commentNumber = "42 of 42";

class Post extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: 50.0,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: OutlinedButton(
                    child: Center(
                      child: Row(children: [
                        Text(
                          'flick',
                          style: TextStyle(
                              color: Colors.blue,
                              fontFamily: 'Righteous-Regular.ttf', fontSize: 20.0),
                        ),
                        Text(
                          'r ',
                          style: TextStyle(
                              color: Colors.pink,
                              fontFamily: 'Righteous-Regular.ttf', fontSize: 20.0),
                        ),
                        Text(
                          'FAQs',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSansCondensed-Light300.ttf', fontSize: 15.0, ),
                          // textAlign: Alignment.bottomCenter,
                        ),
                      ]),
                    ),
                    onPressed: () {},
                  ),
                ),
                SizedBox(
                  width: 8.0,
                ),
                Text('Sharing on Flickr.'),
              ],
            ),
          ),
          Container(
            child: Image(
              image: NetworkImage(
                  _postImage),
            ),
            margin: EdgeInsets.all(5.0),
          ),
          ListTile(
            leading: CircleAvatar(
              radius: 23.0,
              backgroundImage: NetworkImage(_userImage),
            ),
            title: Text(_username,
              style: TextStyle(fontSize: 18.0, color: Colors.black),),
            subtitle:  Text(_caption,
              style: TextStyle(fontSize: 18.0, color: Colors.grey),),
            trailing:  Text(_postDate),
          ),
          SizedBox(
            width: 375.0,
            height: 20.0,
            child: Divider(
              color: Colors.grey,
              height: 20.0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0,5.0,20.0,10.0),
            child: Row(
              children: [
                Icon(Icons.star_border_outlined, size: 25.0, color: Colors.grey,),
                Text(_postLikes, style: TextStyle(color: Colors.grey),),
                SizedBox(width: 125.0,),
                Icon(Icons.comment, size: 25.0, color: Colors.grey,),
                Text(_postComments, style: TextStyle(color: Colors.grey),),
                SizedBox(width: 125.0,),
                Icon(Icons.share_outlined, size: 25.0, color: Colors.grey,),
              ],
            ),
          ),
          Container(
            color: Colors.grey[300],
            child: Column(
              children: [
                ListTile(
                  leading: Icon(Icons.star, size: 20.0,),
                  title: Text(_peopleLikes),
                ),
                ListTile(
                  leading: Icon(Icons.mode_comment, size: 20.0,),
                  title: Text(_randomCommenter),
                  subtitle: Text(_randomComment),
                  trailing: Text(_commentNumber),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        actions: <Widget>[
          Container(
            child: Row(
              // mainAxisSize: MainAxisSize.max,
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 40.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.image,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 40.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.search,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 40.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.account_circle,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 40.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.notifications,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      // do something
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(17.0, 10.0, 17.0, 40.0),
                  child: IconButton(
                    icon: Icon(
                      Icons.camera_alt_sharp,
                      color: Colors.grey[400],
                    ),
                    onPressed: () {
                      print('Yes');
                      // do something
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          child: Column(
            children: [
              Post(),
              Post(),
            ],
          ),
        ),
      ),
    );
  }
}

// _openReCaptcha() async {
//   String tokenResult =
//   await GCaptcha.reCaptcha("6LeePrkaAAAAAF1Tx8KEoVpDqCrHJDfwKPmsX5vX");
//   print('tokenResult: $tokenResult');
//   // Fluttertoast.showToast(msg: tokenResult, timeInSecForIosWeb: 4);
//
//   // setState
// }}

const addTextStyle = TextStyle(
  fontSize: 15.0,
  color: Colors.grey,
  fontFamily: 'ProximaNova', fontWeight: FontWeight.bold,
  //letterSpacing: 1.0
);
