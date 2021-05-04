// import 'package:email_validator/email_validator.dart';
// import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flickr/Views/current_city.dart';
import 'package:flickr/Views/email.dart';
import 'package:flickr/Views/description.dart';
import 'package:flickr/Views/occupation.dart';
import 'package:flickr/Views/facebook.dart';
import 'package:flickr/Views/hometown.dart';
import 'package:flickr/Views/instagram.dart';
import 'package:flickr/Views/pinterest.dart';
import 'package:flickr/Views/tumblr.dart';
import 'package:flickr/Views/twitter.dart';
import 'package:flickr/Views/website.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _About_testState createState() => _About_testState();
}

class _About_testState extends State<About> {
  String occupation = 'Add Occupation... ';
  String description = 'Add Description... ';
  String currentCity = 'Add Current city...';
  String hometown = 'Add Hometown...';
  String facebook = 'Add Facebook...';
  String instagram = 'Add Instagram...';
  String pinterest = 'Add Pinterest...';
  String tumblr = 'Add Tumblr...';
  String twitter = 'Add Twitter...';
  String website = 'Add Website...';
  String visibleTo = 'Anyone';
  String visibleToEmail = 'Anyone';
  String email = 'Aalaasalaheldin.99@gmail.com';
  String oc;
  String v;
  String d;
  String h;
  String f;
  String i;
  String p;
  String t;
  String tw;
  String w;

  List<String> data = ['', ''];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                      title: Text(
                        '0 Photos',
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                        title: Text(
                          'Description',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          description,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          setState(
                                () async {
                              description = await (Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Description(
                                      description: d,
                                    )),
                              ));
                              setState(() {
                                d = description;
                              });
                            },
                          );
                        }),
                  ),
                  Card(
                    child: ListTile(
                        title: Text(
                          'Hometown',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          hometown,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          setState(
                                () async {
                              hometown = await (Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Hometown(
                                      hometown: h,
                                    )),
                              ));
                              setState(() {
                                h = hometown;
                              });
                            },
                          );
                        }),
                  ),
                  Card(
                    child: ListTile(
                        title: Text(
                          'Occupation',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          occupation,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          setState(
                            () async {
                              occupation = await (Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Occupation(
                                          occupation: oc,
                                        )),
                              ));
                              setState(() {
                                oc = occupation;
                              });
                            },
                          );
                        }),
                  ),
                  Card(
                      child: ListTile(
                    isThreeLine: true,
                    title: Text(
                      'Current city',
                      style: TextStyle(fontSize: 18.0, color: Colors.black),
                    ),
                    subtitle: Text(
                      currentCity + '\nVisible to: ' + visibleTo,
                      style: TextStyle(fontSize: 18.0, color: Colors.grey),
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right_rounded),
                    onTap: () {
                      setState(() async {
                        data = await (Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrentCity(
                                  currentCity: currentCity,
                                  visibleTo: visibleTo)),
                        ));
                        setState(() {
                          currentCity = data[0];
                          visibleTo = data[1];
                        });
                      });
                    },
                  )),
                  Card(
                    child: ListTile(
                        title: Text(
                          'Website',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          website,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          setState(
                                () async {
                              website = await (Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Website(
                                      website: w,
                                    )),
                              ));
                              setState(() {
                                w = website;
                              });
                            },
                          );
                        }),
                  ),
                  Card(
                    child: ListTile(
                        title: Text(
                          'Tumblr',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          tumblr,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          setState(
                                () async {
                              tumblr = await (Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Tumblr(
                                      tumblr: t,
                                    )),
                              ));
                              setState(() {
                                t = tumblr;
                              });
                            },
                          );
                        }),
                  ),
                  Card(
                    child: ListTile(
                        title: Text(
                          'Facebook',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          facebook,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          setState(
                                () async {
                              facebook = await (Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Facebook(
                                      facebook: f,
                                    )),
                              ));
                              setState(() {
                                f = facebook;
                              });
                            },
                          );
                        }),
                  ),
                  Card(
                    child: ListTile(
                        title: Text(
                          'Twitter',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          twitter,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          setState(
                                () async {
                              twitter = await (Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Twitter(
                                      twitter: tw,
                                    )),
                              ));
                              setState(() {
                                tw = twitter;
                              });
                            },
                          );
                        }),
                  ),
                  Card(
                    child: ListTile(
                        title: Text(
                          'Instagram',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          instagram,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          setState(
                                () async {
                              instagram = await (Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Instagram(
                                      instagram: i,
                                    )),
                              ));
                              setState(() {
                                i = instagram;
                              });
                            },
                          );
                        }),
                  ),
                  Card(
                    child: ListTile(
                        title: Text(
                          'Pinterest',
                          style: TextStyle(fontSize: 18.0, color: Colors.black),
                        ),
                        subtitle: Text(
                          pinterest,
                          style: TextStyle(fontSize: 18.0, color: Colors.grey),
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right_rounded),
                        onTap: () {
                          setState(
                                () async {
                              pinterest = await (Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Pinterest(
                                      pinterest: p,
                                    )),
                              ));
                              setState(() {
                                p = pinterest;
                              });
                            },
                          );
                        }),
                  ),
                  Card(
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(
                        'Email',
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      subtitle: Text(
                        email + '\nVisible to: ' + visibleToEmail,
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right_rounded),
                      onTap: () {
                        setState(() async {
                          v = await (Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Email(
                                      email: email,
                                      visibleTo: visibleToEmail,
                                    )),
                          ));
                          setState(() {
                            visibleToEmail = v;
                          });
                        });
                      },
                    ),
                  ),
                  Card(
                    child: ListTile(
                      title: Text(
                        'Date Joined',
                        style: TextStyle(fontSize: 18.0, color: Colors.black),
                      ),
                      subtitle: Text(
                        'Month Year',
                        style: TextStyle(fontSize: 18.0, color: Colors.grey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
