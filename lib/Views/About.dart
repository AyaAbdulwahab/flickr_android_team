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
  int photoCount =0;
  String occupation ='Add Occupation...';
  String oc = 'Add Occupation...';
  String description = 'Add Description...';
  String d = 'Add Description...';
  String currentCity = 'Add Current city...';
  String hometown  = 'Add Hometown...';
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
  // List<String> data= [];

  void getData()async{
    NetworkHelper req2 = new NetworkHelper(EndPoints.mockBaseUrl+'/getinfo');
    var res2 = await req2.getData();
    if (res2.statusCode == 200)
    {
      String data=res2.body;
      info = jsonDecode(data)['data'];
      setState(() {
        photoCount = info["photoCount"]??0;
        occupation = info["occupation"];
        oc = '';
        description = info["description"];
        d = '';
        currentCity = info['currentCity'];
        hometown = info['hometown'];
        h = '';
        facebook = info['facebook'];
        f = '';
        instagram = info['instagram'];
        i = '';
        pinterest = info['pinterest'];
        p = '';
        tumblr = info['tumblr'];
        t = '';
        twitter = info['twitter'];
        tw = '';
        website = info['website'];
        w = '';
        visibleTo = info['visibleTo']??'Anyone';
        v = 'Anyone';
        visibleToEmail = info['visibleToEmail']??'Anyone';
        email = info['email'];
        String date = (info['joinDate'].split('T'))[0];
        String m =date.split('-')[1];
        String y =date.split('-')[0];
        // String year = (int.parse(y)%100).toString();
        String month;
        switch(m){
          case '1':
            {
              month = 'January';
              break;
            }
          case '2':
            {
              month = 'February';
              break;
            }
          case '3':
            {
              month = 'March';
              break;
            }
          case '4':
            {
              month = 'April';
              break;
            }
          case '5':
            {
              month = 'May';
              break;
            }
          case '6':
            {
              month = 'June';
              break;
            }
          case '7':
            {
              month = 'July';
              break;
            }
          case '8':
            {
              month = 'August';
              break;
            }
          case '9' :
            {
              month = 'September';
              break;
            }
          case '10':
            {
              month = 'October';
              break;
            }
          case '11':
            {
              month = 'November';
              break;
            }
          case '12':
            {
              month = 'December';
              break;
            }
        }
        dateJoined = (month+' '+y)??' ';
        // data = info['currentCity']??['Add Current city...', 'Anyone'];
      });
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
                  photoCount.toString()+' Photos',
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
                    (description == null || description.trim() == '')?'Add Description...':description,
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
                    (hometown == null || hometown.trim() == '')?'Add Hometown...':hometown,
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
                                    hometown: hometown,
                                  )),
                        ));
                        setState(() {
                          h = hometown;
                        });
                        //call the edit info request function
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
                      (occupation == null || occupation.trim() == '')?'Add Occupation...':occupation,
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
                                    occupation: occupation,
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
                  ((currentCity == null || currentCity.trim() == '')?'Add Current City...':currentCity) + '\nVisible to: ' + visibleTo,
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
                trailing: Icon(Icons.keyboard_arrow_right_rounded),
                onTap: () {
                  setState(() async {
                    List temp;
                    temp = await (Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CurrentCity(
                            currentCity: currentCity, visibleTo: visibleTo),
                      ),
                    ));
                    setState(() {
                      currentCity=temp[0];
                      visibleTo = temp[1];
                    });
                    // print(currentCity);
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
                      (website == null || website.trim() == '')?'Add Website...':website,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: () {
                    setState(
                      () async {
                        String temp;
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
                      (tumblr == null || tumblr.trim() == '')?'Add Tumblr...':tumblr,
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
                      (facebook == null || facebook.trim() == '')?'Add Facebook...':facebook,
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
                      (twitter == null || twitter.trim() == '')?'Add Twitter...':twitter,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: () {
                    setState(
                      () async {
                        twitter = await (Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context, ) => Twitter(
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
                      (instagram == null || instagram.trim() == '')?'Add Instagram...':instagram,
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
                      (pinterest == null || pinterest.trim() == '')?'Add Pinterest...':pinterest,
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
