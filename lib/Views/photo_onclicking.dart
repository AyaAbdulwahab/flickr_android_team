import 'package:flickr/Widgets/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flickr/Widgets/faves_and_comments.dart';
import 'package:flickr/Views/photo_details.dart';

/////HOW TO USE THE FUNCTIONS WITHIN A DIFFERENT CLASS (ADD AND REMOVES FAVES)

///The [PhotoOnClicking] takes the required data about the photo and views the photo
class PhotoOnClicking extends StatefulWidget {
  String image, userImage, username, userRealName, userID, description, dateTaken, caption, views, faves, comments;
  int safety;
  bool privacy;
  List<dynamic> tags;
  PhotoOnClicking(
      {@required this.image,
        @required this.userImage,
        @required this.username,
        @required this.userID,
        @required this.userRealName,
        @required this.privacy,
        @required this.safety,
        @required this.views,
        @required this.dateTaken,
        @required this.caption,
        @required this.description,
        @required this.tags,
        @required this.faves,
        @required this.comments});
  Icon s=Icon(Icons.star_border_outlined, color: Colors.white,);
  @override
  _PhotoOnClickingState createState() => _PhotoOnClickingState();
}

class _PhotoOnClickingState extends State<PhotoOnClicking> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                leading: CircleAvatar(
                  radius: 23.0,
                  backgroundImage: NetworkImage(widget.userImage),
                ),
                title: Text(
                  widget.username,
                  style: TextStyle(fontSize: 18.0, color: Colors.white),
                ),
                trailing: IconButton(
                    icon: Icon(
                      Icons.close,
                      color: Colors.grey[200],
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    }),
              ),
              Expanded(
                child: Image(
                  image: NetworkImage(widget.image),
                ),
              ),
              ListTile(
                title:
                Text(widget.caption, style: TextStyle(color: Colors.white)),
              ),
              Divider(height: 1.0, color: Colors.grey[200]),
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    child: Row(
                      children: [
                        IconButton(
                            icon:
                            widget.s,
                            onPressed: () {
                              setState(() {
                                if (widget.s.icon==Icons.star_border_outlined)
                                {
                                  widget.s=Icon(Icons.star, color: Colors.white);
                                  // addFave();
                                }
                                else if (widget.s.icon==Icons.star){
                                  widget.s=Icon(Icons.star_border_outlined, color: Colors.white);
                                  // removeFave();
                                }
                              });
                            }),
                        IconButton(
                            icon: Icon(Icons.comment, color: Colors.white),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.share_outlined, color: Colors.white),
                            onPressed: () {}),
                        IconButton(
                            icon: Icon(Icons.info_outline, color: Colors.white),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PhotoDetails(title: widget.caption,
                                      description: widget.description,
                                      userRealName:widget.userRealName,
                                      userID:widget.userID,
                                      dateTaken: widget.dateTaken,
                                      tags:widget.tags,
                                      privacy:widget.privacy,
                                      views:widget.views,
                                      safety:widget.safety,)),
                              );
                            }),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.faves + ' faves\n' + widget.comments + ' comments',
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
