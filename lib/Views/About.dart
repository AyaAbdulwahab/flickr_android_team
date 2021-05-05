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
import 'package:flickr/View_Model/networking.dart';
import 'package:flickr/Constants/constants.dart';
import 'dart:convert';


class About extends StatefulWidget {
  @override
  _AboutTestState createState() => _AboutTestState();
}


class _AboutTestState extends State<About> {

  Map<String,dynamic> info;
  String occupation ;
  String oc;
  String description ;
  String d ;
  String currentCity ;
  String hometown  ;
  String h = 'Add Hometown...';
  String facebook = 'Add Facebook...';
  String f = 'Add Facebook...';
  String instagram = 'Add Instagram...';
  String i = 'Add Instagram...';
  String pinterest = 'Add Pinterest...';
  String p = 'Add Pinterest...';
  String tumblr = 'Add Tumblr...';
  String t = 'Add Tumblr...';
  String twitter = 'Add Twitter...';
  String tw = 'Add Twitter...';
  String website = 'Add Website...';
  String w = 'Add Website...';
  String visibleTo = 'Anyone';
  String v = 'Anyone';
  String visibleToEmail = 'Anyone';
  String email = 'Aalaasalaheldin.99@gmail.com';
  String dateJoined = 'May 21';
  List<String> data= [];

  void getData()async{
    NetworkHelper req2 = new NetworkHelper(EndPoints.mockBaseUrl+'/getinfo');
    var res2 = await req2.getData();
    if (res2.statusCode == 200)
    {
      String data=res2.body;
      info = jsonDecode(data)['data'];
      occupation = info["occupation"]??'Add Occupation... ';
      oc = info['occupation']??'Add Occupation... ';
      description = 'Add Description... ';
      d = 'Add Description... ';
      currentCity = info['currentCity']??'Add Current city...';
      hometown = info['hometown'];
      h = info['hometown']??'Add Hometown...';
      facebook = info['occupation']??'Add Facebook...';
      f = info['occupation']??'Add Facebook...';
      instagram = info['occupation']??'Add Instagram...';
      i = info['occupation']??'Add Instagram...';
      pinterest = info['occupation']??'Add Pinterest...';
      p = info['occupation']??'Add Pinterest...';
      tumblr = info['occupation']??'Add Tumblr...';
      t = info['occupation']??'Add Tumblr...';
      twitter = info['occupation']??'Add Twitter...';
      tw = info['occupation']??'Add Twitter...';
      website = info['occupation']??'Add Website...';
      w = info['occupation']??'Add Website...';
      visibleTo = info['occupation']??'Anyone';
      v = info['occupation']??'Anyone';
      visibleToEmail = info['occupation']??'Anyone';
      email = info['email']??'Aalaasalaheldin@gmail.com';
      dateJoined = 'May 21';
      data = info['currentCity']??['Add Current city...', 'Anyone'];
      print(info['occupation']);
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[200],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              ListTile(
                contentPadding:
                    EdgeInsets.only(top: 1.0, bottom: 1.0, left: 8.0),
                title: Text(
                  '0 Photos',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
                            currentCity: currentCity, visibleTo: visibleTo),
                      ),
                    ));
                    setState(() {
                      currentCity = data[0];
                      visibleTo = data[1];
                    });
                  });
                },
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
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
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                title: Text(
                  'Date Joined',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                subtitle: Text(
                  dateJoined,
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
            ],
          ),
        ),
        // ],
      ),
    );
  }
}
