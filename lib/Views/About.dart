import 'package:flickr/Models/user_model.dart';
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
import 'package:http/http.dart' as http;
import 'package:flickr/Constants/constants.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

///The [About] class allows the user to view his information and update it through directing the user to the chosen field's page
class About extends StatefulWidget {
  bool isImmutable;
  String id;
  About({this.isImmutable, this.id});
  @override
  _AboutTestState createState() => _AboutTestState();
}

class _AboutTestState extends State<About> {
  Map<String, dynamic> info;
  int photoCount = 0; //get it from camera roll
  String occupation = 'Add Occupation...';
  String oc = 'Add Occupation...';
  String description = 'Add Description...';
  String d = 'Add Description...';
  String currentCity = 'Add Current city...';
  String hometown = 'Add Hometown...';
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
  String country = ' ';
  String visibleToEmail = 'Anyone';
  String email = 'Aalaasalaheldin.99@gmail.com';
  String dateJoined = 'May 21';
  // String token =
  // 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYwOGQ1NWM3ZTUxMmI3NGVlMDA3OTFkYiIsImlhdCI6MTYyMTUwOTY5NywiZXhwIjoxNjI5Mjg1Njk3fQ.3WLVIdzDgIGpru3ybIxqWj9A9ROvtLG90dFuzHowuk0';
  // String id = '608d55c7e512b74ee00791de';

  // List<String> data= [];

  /// This function gets the user information using the user [id] and [token]
  void getData() async {
    final user = Provider.of<MyModel>(context, listen: false);
    print(user.getID());
    print(user.getToken());
    var req2 = await http.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + widget.id)),
      headers: {"authorization": "Bearer " + user.getToken()},
    );
    if (req2.statusCode == 200) {
      String data = req2.body;
      int vC, vE;
      info = jsonDecode(data)['data'];
      // print("INFOOOOOOO: " + data);
      setState(() {
        photoCount = info["photoCount"] ?? 0;
        occupation = info["occupation"];
        oc = '';
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
        email = info['email'];
        country = info['country'];
        vC = info['privacySettings']['global']['infoVisibility']['currentCity'];
        vE = info['privacySettings']['global']['infoVisibility']['email'];
        /////current city visibility
        if (vC == 1) {
          visibleTo = 'Any Flickr member';
        } else if (vC == 2) {
          visibleTo = 'People you follow';
        } else if (vC == 3) {
          visibleTo = 'Friends and family';
        } else {
          visibleTo = 'Anyone';
        }
        /////email visibility
        if (vE == 1) {
          visibleToEmail = 'Any Flickr member';
        } else if (vE == 2) {
          visibleToEmail = 'People you follow';
        } else if (vE == 3) {
          visibleToEmail = 'Friends and family';
        } else {
          visibleToEmail = 'Anyone';
        }
        String date =
            DateFormat.yMMMM('en_US').format(DateTime.parse(info['joinDate']));
        dateJoined = date.toString();
      });
    }
  }

  ///This function gets the user's description using the user's [id] and [token]
  void getDescription() async {
    final user = Provider.of<MyModel>(context, listen: false);
    var req2 = await http.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + widget.id + '/about-me')),
    );
    if (req2.statusCode == 200) {
      String data = req2.body;
      info = jsonDecode(data)['data'];
      setState(() {
        description = info["aboutMe"];
        d = '';
      });
    }
  }

  ///This function gets the user's photoCount using the user's [id] and [token]
  void getPhotoCount() async {
    final user = Provider.of<MyModel>(context, listen: false);
    var req2 = await http.get(
      (Uri.parse(EndPoints.baseUrl + '/user/' + widget.id + '/about-me')),
    );
    if (req2.statusCode == 200) {
      String data = req2.body;
      info = jsonDecode(data)['data'];
      setState(() {
        description = info["aboutMe"];
        d = '';
      });
    }
  }

  ///This function updates the user info and it is called whenever a field is edited using the user's [token]
  ///Contains two patch requests; one for the description and the other for the rest of the data
  Future<Map<String, dynamic>> updateInfo(String oc, String h, String c,
      String d, String cV, String eV, String country) async {
    try {
      int visibilityC, visibilityE;
      ///////currentCityVisibility
      if (cV == 'Anyone') {
        visibilityC = 1;
      } else if (cV == 'Any Flickr member') {
        visibilityC = 1;
      } else if (cV == 'People you follow') {
        visibilityC = 2;
      } else if (cV == 'Friends and family') {
        visibilityC = 3;
      }
      ///////emailVisibility
      if (eV == 'Anyone') {
        visibilityE = 1;
      } else if (eV == 'Any Flickr member') {
        visibilityE = 1;
      } else if (eV == 'People you follow') {
        visibilityE = 2;
      } else if (eV == 'Friends and family') {
        visibilityE = 3;
      }
      print(oc);
      print(h);
      print(c);

      final user = Provider.of<MyModel>(context, listen: false);
      Map<String, dynamic> n = {
        "occupation": oc ?? "",
        "hometown": h ?? "",
        "currentCity": c ?? "",
        "country": country ?? "",
        "emailVisibility": visibilityE.toString() ?? "0",
        "currentCityVisibility": visibilityC.toString() ?? "0"
      };
      final response = await http.patch(Uri.parse(EndPoints.baseUrl + '/user'),
          headers: {"authorization": "Bearer " + user.getToken()}, body: n);
      Map<String, dynamic> mm = {"aboutMe": d};
      final response2 = await http.patch(
          Uri.parse(EndPoints.baseUrl + '/user/about-me'),
          headers: {"authorization": "Bearer " + user.getToken()},
          body: {"aboutMe": d});
    } catch (error) {
      print(error);
    }
  }


  @override
  void initState() {
    super.initState();
    getData();
    getDescription();
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
                  photoCount.toString() + ' Photos',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                  key: Key("description-tile"),
                  title: Text(
                    'Description',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    (description == null || description.trim() == '')
                        ? 'Add Description...'
                        : description,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: widget.isImmutable
                      ? () {
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
                                updateInfo(
                                    occupation,
                                    hometown,
                                    currentCity,
                                    description,
                                    visibleTo,
                                    visibleToEmail,
                                    country);
                              });
                            },
                          );
                        }
                      : () {}),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                  key: Key("hmtwn-tile"),
                  title: Text(
                    'Hometown',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    (hometown == null || hometown.trim() == '')
                        ? 'Add Hometown...'
                        : hometown,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: widget.isImmutable
                      ? () {
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
                                updateInfo(
                                    occupation,
                                    hometown,
                                    currentCity,
                                    description,
                                    visibleTo,
                                    visibleToEmail,
                                    country);
                              });
                              //call the edit info request function
                            },
                          );
                        }
                      : () {}),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                  key: Key("ocp-tile"),
                  title: Text(
                    'Occupation',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    (occupation == null || occupation.trim() == '')
                        ? 'Add Occupation...'
                        : occupation,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: widget.isImmutable
                      ? () {
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
                                updateInfo(
                                    occupation,
                                    hometown,
                                    currentCity,
                                    description,
                                    visibleTo,
                                    visibleToEmail,
                                    country);
                              });
                            },
                          );
                        }
                      : () {}),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                key: Key("crn-city-tile"),
                isThreeLine: true,
                title: Text(
                  'Current city',
                  style: TextStyle(fontSize: 18.0, color: Colors.black),
                ),
                subtitle: Text(
                  ((currentCity == null || currentCity.trim() == '')
                          ? 'Add Current City...'
                          : currentCity) +
                      '\nVisible to: ' +
                      visibleTo,
                  style: TextStyle(fontSize: 18.0, color: Colors.grey),
                ),
                trailing: Icon(Icons.keyboard_arrow_right_rounded),
                onTap: widget.isImmutable
                    ? () {
                        setState(() async {
                          List temp;
                          temp = await (Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CurrentCity(
                                  currentCity: currentCity,
                                  visibleTo: visibleTo),
                            ),
                          ));
                          setState(() {
                            currentCity = temp[0];
                            visibleTo = temp[1];
                            updateInfo(
                                occupation,
                                hometown,
                                currentCity,
                                description,
                                visibleTo,
                                visibleToEmail,
                                country);
                          });
                          // print(currentCity);
                        });
                      }
                    : () {},
              ),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                  key: Key("wbst-tile"),
                  title: Text(
                    'Website',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    (website == null || website.trim() == '')
                        ? 'Add Website...'
                        : website,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: widget.isImmutable
                      ? () {
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
                        }
                      : () {}),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                  key: Key("tmblr-tile"),
                  title: Text(
                    'Tumblr',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    (tumblr == null || tumblr.trim() == '')
                        ? 'Add Tumblr...'
                        : tumblr,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: widget.isImmutable
                      ? () {
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
                        }
                      : () {}),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                  key: Key("fb-tile"),
                  title: Text(
                    'Facebook',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    (facebook == null || facebook.trim() == '')
                        ? 'Add Facebook...'
                        : facebook,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: widget.isImmutable
                      ? () {
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
                        }
                      : () {}),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                  key: Key("twtr-tile"),
                  title: Text(
                    'Twitter',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    (twitter == null || twitter.trim() == '')
                        ? 'Add Twitter...'
                        : twitter,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: widget.isImmutable
                      ? () {
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
                        }
                      : () {}),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                  key: Key("instgm-tile"),
                  title: Text(
                    'Instagram',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    (instagram == null || instagram.trim() == '')
                        ? 'Add Instagram...'
                        : instagram,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: widget.isImmutable
                      ? () {
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
                        }
                      : () {}),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                  key: Key("pntrst-tile"),
                  title: Text(
                    'Pinterest',
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  subtitle: Text(
                    (pinterest == null || pinterest.trim() == '')
                        ? 'Add Pinterest...'
                        : pinterest,
                    style: TextStyle(fontSize: 18.0, color: Colors.grey),
                  ),
                  trailing: Icon(Icons.keyboard_arrow_right_rounded),
                  onTap: widget.isImmutable
                      ? () {
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
                        }
                      : () {}),
              Divider(
                color: Colors.grey[300],
                thickness: 1.0,
              ),
              ListTile(
                key: Key("eml-tile"),
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
                onTap: widget.isImmutable
                    ? () {
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
                            updateInfo(
                                occupation,
                                hometown,
                                currentCity,
                                description,
                                visibleTo,
                                visibleToEmail,
                                country);
                          });
                        });
                      }
                    : () {},
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
      ),
    );
  }
}
