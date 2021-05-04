import 'package:flickr/Views/home.dart';
import 'package:flickr/Views/search.dart';
import 'package:flickr/Views/you.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  TabController _tabController;
  List<String> youBar = [
    'Home',
    'Search',
    'You',
    'Notifications',
    'Camera Roll'
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
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF212124), //or set color with: Color(0xFF0000FF)
    ));
    return Scaffold(
        // backgroundColor: Color(0xFF212124),
        body: NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            flexibleSpace: PreferredSize(
              preferredSize: Size.fromHeight(60.5),
              child: SafeArea(
                child: Container(
                  height: 57.0,
                  child: Material(
                    color: Color(0xFF212124),
                    child: TabBar(
                      // indicatorPadding: EdgeInsets.only(bottom: 20.0),
                      labelColor: Colors.white,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.transparent,
                      controller: _tabController,
                      tabs: [
                        Tab(
                          icon: Icon(Icons.home),
                        ),
                        Tab(
                          icon: Icon(Icons.search),
                        ),
                        Tab(icon: Icon(FontAwesomeIcons.userCircle)),
                        Tab(
                          icon: Icon(Icons.notifications),
                        ),
                        Tab(
                          icon: Icon(Icons.camera_alt),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            pinned: false,
          ),
        ];
      },
      body: TabBarView(controller: _tabController, children: [
        Home(),
        Search(),
        YouPage(),
        for (var i = 3; i < youBar.length; i++)
          Container(
            width: 10.0,
            height: 50.0,
            child: Center(
              child: Text('A place holder for the ${youBar[i]} Page'),
            ),
          )
      ]),
    ));
  }
}
