import 'package:flickr/Views/about.dart';
import 'package:flickr/Views/settings.dart';
import 'package:flickr/Views/user_options.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:charcode/charcode.dart';

class YouPage extends StatefulWidget {
  @override
  _YouPageState createState() => _YouPageState();
}

class _YouPageState extends State<YouPage> with TickerProviderStateMixin {
  bool _isSelected = false;
  String profilePhoto = 'assets/profile_pic.png';
  String coverPhoto = 'assets/cover_photo.jpg';
  int noOfFollowers = 0;
  int noOfFollowering = 1;

  TabController _tabController;
  String _username = "Aya Abdulwahab";
  List<String> youBar = [
    'About',
    'Stats',
    'Camera Roll',
    'Publics',
    'Albums',
    'Groups'
  ];

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
    return Stack(children: [
      NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
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
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(height: 20, width: 40.0),
                          Column(children: [
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * 0.05 +
                                      47,
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
                          ]),
                          IconButton(
                            icon: Icon(
                              Icons.more_vert,
                              size: 25.0,
                            ),
                            color: Colors.white,
                            onPressed: () => showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Settings();
                                }),
                          )
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
                      padding: const EdgeInsets.only(top: 4.0, bottom: 4.0),
                      child: TabBar(
                        indicatorPadding: EdgeInsets.only(bottom: 7.0),
                        indicatorWeight: 2,
                        isScrollable: true,
                        labelPadding: EdgeInsets.symmetric(horizontal: 14.0),
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
          body: TabBarView(controller: _tabController, children: [
            About(),
            for (var i = 1; i < youBar.length; i++)
              Center(
                child: Text('A place holder for the ${youBar[i]} Page'),
              )
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
                    height: 290.0,
                    color: Colors.white,
                    child: UserOptions(),
                  ),
                ],
              )
            ],
          )
        ])
    ]);
  }
}
