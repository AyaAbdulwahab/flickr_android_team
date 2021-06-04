import 'package:flickr/Models/user_model.dart';
import 'package:flickr/Views/camera.dart';
import 'package:flickr/Views/home.dart';
import 'package:flickr/Views/loading.dart';
import 'package:flickr/Views/search.dart';
import 'package:flickr/Views/you.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

/// The navigation bar is constructed using the [NavBar] Widget which conatins:
/// * The Home page
/// * The Search
/// * The You page
/// * The Notifications
/// * The Camera (if the user closed it or finished the uploaded, he'll be automatically redirected to the homePage)

class NavBar extends StatefulWidget {
  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> with TickerProviderStateMixin {
  TabController _tabController;
  bool _viewtabs = true;
  List<String> youBar = [
    'Home',
    'Search',
    'You',
    'Notifications',
    'Camera Roll'
  ];

  Future getImage() async {
    return await ImagePicker().getImage(source: ImageSource.camera);
  }

  callback(bool _hideTabBar) {
    setState(() {
      _viewtabs = _hideTabBar;
    });
  }

  Future<void> cameraCall() async {
    if (_tabController.index == 4) {
      PickedFile pk = await getImage();
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Camera(pk)));
      _tabController.index = 0;
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: youBar.length, vsync: this);
    _tabController.addListener(() async {
      await cameraCall();
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyModel>(context, listen: false);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Color(0xFF212124),
    ));
    return SafeArea(
      child: Scaffold(
          // backgroundColor: Color(0xFF212124),
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            if (_tabController.index != 1 || !_viewtabs)
              SliverAppBar(
                flexibleSpace: PreferredSize(
                  preferredSize: Size.fromHeight(60.5),
                  child: SafeArea(
                    child: Container(
                      height: 57.0,
                      child: Material(
                        color: Color(0xFF212124),
                        child: TabBar(
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
          YouPage(id: user.getID()),
          for (var i = 3; i < youBar.length - 1; i++)
            Container(
              width: 10.0,
              height: 50.0,
              child: Center(
                child: Text('A place holder for the ${youBar[i]} Page'),
              ),
            ),
          LoadingPage()
        ]),
      )),
    );
  }
}
