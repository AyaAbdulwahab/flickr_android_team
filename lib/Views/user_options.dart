import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

/// [UserOptions] widget appears on clicking on a user's profile picture
/// The 3 parameters it takes are:
/// * [isMe] as the options that appears in the user's profile are different from that appears in the others profile.
/// * [userName] because if the user enters anothers profile, he have the option to block him
/// * [isFollower] if the user is following that user he is authorized to choose the relation between them.
class UserOptions extends StatefulWidget {
  bool isMe;
  String userName;
  bool isFollower;
  UserOptions(this.isMe, this.userName, this.isFollower);
  @override
  _UserOptionsState createState() => _UserOptionsState();
}

class _UserOptionsState extends State<UserOptions> {
  final int noOfPhotos = 0;
  bool isFriend = false;
  bool isFamily = false;

  final int limit = 1000;
  // bool isMe = true;
  List<String> options;
  // String otherUserName = "Aya AbdulWahab";

  final List<Function> optionsActions = [() {}, () {}, () {}, () {}];
  @override
  void initState() {
    super.initState();
    if (widget.isMe) {
      options = [
        'Join Pro',
        'Using ${noOfPhotos.toString()} of ${limit.toString()} photos',
        'Edit Profile Photo',
        'Edit Cover Photo'
      ];
    } else {
      options = ['Block ' + widget.userName, 'Report Abuse'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.isMe
        ? ListView.separated(
            padding: EdgeInsets.only(top: 11.0),
            separatorBuilder: (context, index) => Divider(
                  color: widget.isMe ? Colors.grey[300] : Colors.transparent,
                  thickness: widget.isMe ? 2 : 0,
                  indent: 20.0,
                  endIndent: 20.0,
                ),
            itemCount: options.length,
            itemBuilder: (context, index) => ListTile(
                  onTap: () => optionsActions[index],
                  minVerticalPadding: widget.isMe ? 10.0 : 3.0,
                  title: Center(
                    child: (index == 0 && widget.isMe)
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.crown,
                                color: Colors.blue[700],
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              Text(
                                'Join Pro',
                                style: TextStyle(color: Colors.blue[700]),
                              ),
                            ],
                          )
                        : Text(
                            options[index],
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: index != 1 || !widget.isMe
                                    ? FontWeight.w700
                                    : FontWeight.normal,
                                fontFamily: 'ProximaNova'),
                          ),
                  ),
                ))
        : ListView(
            children: [
              if (widget.isFollower)
                Container(
                    height: 40.0,
                    child: Text(
                      "Relationship",
                      style: TextStyle(
                          fontWeight: FontWeight.w700, fontSize: 15.0),
                    )),
              if (widget.isFollower)
                SizedBox(
                  height: 40.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Friend",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFriend = !isFriend;
                          });
                        },
                        icon: isFriend
                            ? Icon(Icons.check_circle, color: Colors.blue)
                            : Icon(
                                Icons.lens_outlined,
                                color: Colors.grey,
                              ),
                      ),
                    ],
                  ),
                ),
              if (widget.isFollower)
                SizedBox(
                  height: 50.0,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Family",
                        style: TextStyle(fontSize: 15.0),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isFamily = !isFamily;
                          });
                        },
                        icon: isFamily
                            ? Icon(Icons.check_circle, color: Colors.blue)
                            : Icon(
                                Icons.lens_outlined,
                                color: Colors.grey,
                              ),
                      ),
                    ],
                  ),
                ),
              if (widget.isFollower) Divider(),
              Container(
                height: 65.0,
                child: Center(
                  child: Text(
                    options[0],
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              Container(
                height: 65.0,
                child: Center(
                    child: Text(
                  options[1],
                  style:
                      TextStyle(color: Colors.red, fontWeight: FontWeight.w700),
                )),
              )
            ],
          );
  }
}
