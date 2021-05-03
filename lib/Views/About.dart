// import 'package:email_validator/email_validator.dart';
// import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flickr/Views/current_city.dart';
import 'package:flickr/Views/email.dart';
import 'package:flickr/Views/description.dart';
import 'package:flickr/Views/facebook.dart';
import 'package:flickr/Views/hometown.dart';
import 'package:flickr/Views/instagram.dart';
import 'package:flickr/Views/occupation.dart';
import 'package:flickr/Views/pinterest.dart';
import 'package:flickr/Views/tumblr.dart';
import 'package:flickr/Views/twitter.dart';
import 'package:flickr/Views/website.dart';
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

class About extends StatefulWidget {
  @override
  _About_testState createState() => _About_testState();
}

class _About_testState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      backgroundColor: Colors.white,
    ),
      body: SafeArea(
        child: Container(
          color: Colors.grey[400],
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListView(
              children: <Widget>[
                Card(
                  child: ListTile(
                    title: Text('0 Photos',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Description',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Description...',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Description()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Hometown',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Hometown...',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Hometown()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Occupation',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Occupation...',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Occupation()),
                    );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    isThreeLine: true,
                    title: Text('Current City',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Current City...\nVisible to: Anyone',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CurrentCity()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Hometown',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Hometown...',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Hometown()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Website',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Website...',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Website()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text(
                      'Tumblr', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Tumblr...',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Tumblr()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Facebook',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Facebook...',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Facebook()),
                      );
                    },
                  ),
                ),
                Card(
                    child: ListTile(
                      title: Text('Twitter',
                        style: TextStyle(fontSize: 18.0, color: Colors.black),),
                      subtitle: Text('Add Twitter...',
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Twitter(),
                          ),
                        );
                      },
                    ),
                  ),
                Card(
                  child: ListTile(
                    title: Text('Instagram',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Instagram...',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Instagram()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Pinterest',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Add Pinterest...',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Pinterest()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      'Email', style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('example@gmail.com\nVisible to: People You Follow',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Email()),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    title: Text('Date Joined',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),),
                    subtitle: Text('Month Year',
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),),
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

