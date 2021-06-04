import 'package:flickr/Views/you.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PhotoDetails extends StatefulWidget {
  PhotoDetails(
      {@required this.title,
      @required this.description,
      @required this.userRealName,
      @required this.userID,
      @required this.dateTaken,
      @required this.tags,
      @required this.privacy,
      @required this.views,
      @required this.safety});
  String title;
  String description;
  String userID;
  String userRealName;
  String dateTaken;
  List<dynamic> tags;
  bool privacy;
  String public;
  String safe;
  String views;
  int safety;
  List<Widget> t = [];
  Icon s, p;

  @override
  _PhotoDetailsState createState() => _PhotoDetailsState();
}

class _PhotoDetailsState extends State<PhotoDetails> {
  Icon public = Icon(
    Icons.lock_open_rounded,
    color: Colors.white,
  );
  Icon private = Icon(
    Icons.lock_outline_rounded,
    color: Colors.white,
  );
  Icon safe = Icon(
    Icons.check_circle_outline_rounded,
    color: Colors.white,
  );
  Icon unsafe = Icon(
    Icons.dangerous,
    color: Colors.white,
  );

  Icon getPrivacy() {
    if (widget.privacy == false) {
      widget.public = 'Private';
      return private;
    } else {
      widget.public = 'Public';
      return public;
    }
  }

  Icon getSafety() {
    if (widget.safety == 1) {
      widget.safe = 'Restricted';
      return unsafe;
    } else if (widget.safety == 2) {
      widget.safe = 'Moderate';
      return unsafe;
    } else {
      widget.safe = 'Safe';
      return safe;
    }
  }

  ///Function getTags creates the list of tag buttons
  void getTags() {
    for (int i = 0; i < widget.tags.length; i++) {
      widget.t.add(ElevatedButton(
        onPressed: () {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //       builder: (context) => Tags(tag: (widget.tags[i]).toString(),)),
          // );
        },
        child: Text(
          (widget.tags[i]).toString(),
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (states) => Colors.transparent),
          shape: MaterialStateProperty.all(
            ContinuousRectangleBorder(
              side: BorderSide(color: Colors.white, width: 1.0),
            ),
          ),
        ),
      ));
    }
  }

  @override
  void initState() {
    super.initState();
    widget.p = getPrivacy();
    widget.s = getSafety();
  }

  @override
  Widget build(BuildContext context) {
    // print(_)
    getTags();
    return SafeArea(
      child: Scaffold(
        body: Container(
          color: Colors.grey[900],
          child: ListView(
            children: [
              ListTile(
                title: Text(
                  'TITLE',
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
                subtitle: Text(
                  widget.title,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
              ListTile(
                isThreeLine: true,
                title: Text(
                  'DESCRIPTION',
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
                subtitle: Text(
                  widget.description,
                  style: TextStyle(color: Colors.white, fontSize: 14.0),
                ),
              ),
              ListTile(
                title: Text(
                  'TAKEN BY',
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
                subtitle: InkWell(
                  child: Text(
                    widget.userRealName,
                    style: TextStyle(color: Colors.blue, fontSize: 14.0),
                  ),
                  onTap: () {
                    ///////////////////////////////////////USER PROFILE/////////////////////////////////////////////////
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => YouPage(id: widget.userID)),
                    );
                  },
                ),
              ),
              ListTile(
                  title: Text(
                    'TAGS',
                    style: TextStyle(color: Colors.white, fontSize: 11.0),
                  ),
                  subtitle: Wrap(
                    spacing: 5.0,
                    children: widget.t,
                  )),
              ListTile(
                title: Text(
                  'LICENCE',
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
                subtitle: Row(
                  children: [
                    Icon(
                      Icons.copyright_rounded,
                      color: Colors.white,
                    ),
                    GestureDetector(
                      child: Text(
                        'All rights reserved',
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'MORE',
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
                subtitle: Column(
                  children: [
                    Row(
                      children: [
                        Row(
                          children: [
                            widget.p,
                            Text(
                              ' ' + widget.public,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 50.0,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.remove_red_eye,
                              color: Colors.white,
                            ),
                            Text(
                              ' ' + widget.views,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 14.0),
                            ),
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: [
                        widget.s,
                        Text(
                          ' ' + widget.safe,
                          style: TextStyle(color: Colors.white, fontSize: 14.0),
                        ),
                      ],
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text(
                  'REPORT ABUSE',
                  style: TextStyle(color: Colors.white, fontSize: 11.0),
                ),
                subtitle: GestureDetector(
                  child: Text(
                    'Flag this photo',
                    style: TextStyle(color: Colors.white, fontSize: 14.0),
                  ),
                  onTap: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
