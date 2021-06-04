import 'package:flickr/Models/user_model.dart';
import 'package:flickr/View_Model/user_view_model.dart';
import 'package:flickr/Views/about.dart';
import 'package:flickr/Views/albums.dart';
import 'package:flickr/Views/camera_roll.dart';
import 'package:flickr/Views/loading.dart';
import 'package:flickr/Views/public.dart';
import 'package:flickr/Views/settings.dart';
import 'package:flickr/Views/user_options.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:charcode/charcode.dart';
import 'package:provider/provider.dart';

/// The [YouPage] is where the user can find his own info,
/// the people he/she follows and some tabs such as:
/// * About
/// * Stats (if he is a pro user)
/// * Camera Roll
/// * Publics
/// * Albums
/// * Groups
class YouPage extends StatefulWidget {
  String id;
  YouPage({this.id});
  @override
  _YouPageState createState() => _YouPageState();
}

class _YouPageState extends State<YouPage> with TickerProviderStateMixin {
  bool _isSelected = false;
  String profilePhoto = 'assets/profile_pic.png';
  String coverPhoto = 'assets/cover_photo.jpg';
  int noOfFollowers = 0;
  int noOfFollowering = 1;

  bool isFollowing = false;

  TabController _tabController;
  String _username = "";
  List<String> youBar = [];
  List<String> othersBar = ['Publics', 'Albums', 'Groups', 'About'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: youBar.length, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyModel>(context, listen: false);

    print(user.getFollowers());
    return FutureBuilder(
      future: Future.wait([
        getUsername(widget.id, user.getToken()),
        getNoOfFollowers(widget.id, user.getToken()),
        getFollowers(widget.id, user.getToken())
      ]),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _username = snapshot.data[0] ?? " ";
          noOfFollowering = snapshot.data[1] ?? 0;
          List followers = snapshot.data[2] ?? [];
          print(followers);
          if (user.getID() == widget.id) {
            youBar = [
              'About',
              'Stats',
              'Camera Roll',
              'Publics',
              'Albums',
              'Groups'
            ];
          } else {
            for (var i = 0; i < followers.length; i++) {
              if (followers[i]["_id"] == widget.id) {
                isFollowing = true;
                break;
              }
            }
            youBar = ['Publics', 'Albums', 'Groups', 'About'];
          }
          _tabController = TabController(length: youBar.length, vsync: this);
          return Scaffold(
            body: SafeArea(
              child: Stack(children: [
                NestedScrollView(
                    headerSliverBuilder:
                        (BuildContext context, bool innerBoxIsScrolled) {
                      return <Widget>[
                        SliverAppBar(
                          flexibleSpace: FlexibleSpaceBar(
                              background: Stack(
                            fit: StackFit.expand,
                            children: [
                              Container(
                                height: 100.0,
                                width: MediaQuery.of(context).size.width,
                                child: Image.asset(
                                  coverPhoto,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Container(
                                height: 220.0,
                                color: Colors.black.withOpacity(0.6),
                              ),
                              Positioned(
                                top: MediaQuery.of(context).size.height * 0.04,
                                left: MediaQuery.of(context).size.width * 0.42,
                                child: GestureDetector(
                                  child: ClipRRect(
                                    child:
                                        Image.asset(profilePhoto, height: 50.0),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100)),
                                  ),
                                  onTap: () async {
                                    setState(() {
                                      _isSelected = !_isSelected;
                                    });
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5.0, horizontal: 7.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        (user.getID() == widget.id)
                                            ? SizedBox(
                                                height: MediaQuery.of(context)
                                                            .size
                                                            .height *
                                                        0.05 +
                                                    47,
                                              )
                                            : IconButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                icon: Icon(
                                                  Icons.arrow_back_sharp,
                                                  color: Colors.white,
                                                )),
                                        (user.getID() == widget.id)
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.more_vert,
                                                  size: 25.0,
                                                ),
                                                color: Colors.white,
                                                onPressed: () =>
                                                    showModalBottomSheet(
                                                        context: context,
                                                        builder: (context) {
                                                          return Settings();
                                                        }),
                                              )
                                            : OutlinedButton(
                                                child: isFollowing
                                                    ? Icon(
                                                        Icons.check,
                                                        color: Colors.white,
                                                      )
                                                    : Text("+ Follow",
                                                        style: TextStyle(
                                                            fontSize: 15.0,
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700)),
                                                style: OutlinedButton.styleFrom(
                                                    side: BorderSide(
                                                        color: Colors.white,
                                                        width: 2.0),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .zero)),
                                                onPressed: () {
                                                  setState(() {
                                                    isFollowing = !isFollowing;
                                                  });
                                                },
                                              )
                                      ],
                                    ),
                                    if (user.getID() != widget.id)
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.05,
                                      ),
                                    Text(_username,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'ProximaNova',
                                          fontWeight: FontWeight.w700,
                                          fontSize: 23.0,
                                        )),
                                    SizedBox(height: 8.0),
                                    Text(
                                      '${noOfFollowers.toString()} Followers ' +
                                          String.fromCharCode($mdash) +
                                          ' ${noOfFollowering.toString()} Following',
                                      style: TextStyle(
                                          // fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                          fontSize: 15.0),
                                    )
                                    // ]),
                                  ],
                                ),
                              ),
                            ],
                          )),
                          expandedHeight: 230.0,
                          toolbarHeight: 0.0,
                          backgroundColor: Colors.white,
                          bottom: PreferredSize(
                            preferredSize: Size.fromHeight(56.5),
                            child: Material(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    top: 4.0, bottom: 4.0),
                                child: TabBar(
                                  indicatorPadding:
                                      EdgeInsets.only(bottom: 7.0),
                                  indicatorWeight: 2,
                                  isScrollable: true,
                                  labelPadding:
                                      EdgeInsets.symmetric(horizontal: 14.0),
                                  indicatorSize: TabBarIndicatorSize.label,
                                  labelColor: Colors.black87,
                                  unselectedLabelColor: Colors.grey,
                                  labelStyle: TextStyle(
                                      fontFamily: 'ProximaNova',
                                      fontSize: 17.0,
                                      fontWeight: FontWeight.w700),
                                  indicatorColor: Colors.black87,
                                  controller: _tabController,
                                  tabs: [
                                    for (var i = 0; i < youBar.length; i++)
                                      Tab(text: youBar[i]),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          pinned: true,
                        ),
                      ];
                    },
                    body: (user.getID() == widget.id)
                        ? TabBarView(controller: _tabController, children: [
                            About(
                                isImmutable: user.getID() == widget.id,
                                id: widget.id),
                            Center(
                              child: Text(
                                  'A place holder for the ${youBar[1]} Page'),
                            ),
                            CameraRoll(),
                            Public(),
                            // Center(
                            //   child: Text(
                            //       'A place holder for the ${youBar[3]} Page'),
                            // ),
                            Albums(),
                            Center(
                              child: Text(
                                  'A place holder for the ${youBar[5]} Page'),
                            )
                          ])
                        : TabBarView(controller: _tabController, children: [
                            for (var i = 0; i < 3; i++)
                              Center(
                                child: Text(
                                    'A place holder for the ${youBar[i]} Page'),
                              ),
                            About(
                                isImmutable: user.getID() == widget.id,
                                id: widget.id)
                          ])),
                if (_isSelected)
                  GestureDetector(
                    onTap: () async {
                      setState(() {
                        _isSelected = false;
                      });
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.black.withOpacity(0.6),
                    ),
                  ),
                if (_isSelected)
                  Positioned(
                    top: MediaQuery.of(context).size.height * 0.04,
                    left: MediaQuery.of(context).size.width * 0.42,
                    child: GestureDetector(
                      child: ClipRRect(
                        child: Image.asset(profilePhoto, height: 50.0),
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                      ),
                      onTap: () async {
                        setState(() {
                          _isSelected = !_isSelected;
                        });
                      },
                    ),
                  ),
                if (_isSelected)
                  Column(children: [
                    SizedBox(
                      height: 55.0 + MediaQuery.of(context).size.height * 0.04,
                    ),
                    Stack(
                      children: [
                        Positioned(
                          left: MediaQuery.of(context).size.width * 0.49,
                          child: Container(
                            height: 20.0,
                            width: 20.0,
                            color: Colors.white,
                            transform: Matrix4.rotationZ(0.785398),
                          ),
                        ),
                        Column(
                          children: [
                            SizedBox(
                              height: 10.0,
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: user.getID() == widget.id
                                  ? 290.0
                                  : isFollowing
                                      ? 290
                                      : 130.0,
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: UserOptions(user.getID() == widget.id,
                                    _username, isFollowing),
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ])
              ]),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting)
          return LoadingPage();
        else
          return Container(
            child: Text("Error"),
          );
      },
    );
  }
}
