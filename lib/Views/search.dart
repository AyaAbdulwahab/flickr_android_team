import 'package:flickr/Models/search_model.dart';
import 'package:flickr/Models/user_model.dart';
import 'package:flickr/View_Model/search_view_model.dart';
import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flickr/Constants/constants.dart';

// ------------------------------------------------------------------------ //
/// The [Search] page allows user search for photos, people, and groups, returns the search results filtered in 3 different tabs
class Search extends StatefulWidget {
  // Function(bool) callback;
  // Search(this.callback);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool _removeText = false;
  bool _cancelButton = false;
  bool _viewTabs = false;
  bool _searchedImagesGrid = false;
  Color _searchColor = Colors.grey.shade600;
  String _searchKey = "";
  List<SearchedUser> _usersResult = [];
  List<SearchedUser> _fetchedUsers = [];
  List<SearchedPhoto> _fetchedPhotos = [];
  List<SearchedPhoto> _photosResult = [];
  bool _hasMore;
  int _usersPageNumber;
  int _photosPageNumber;
  bool _usersError;
  bool _photosError;
  bool _loading;
  bool _photosLoading = false;
  final int _userPerCount = 16;
  final int _photosPerCount = 12;
  final int _nextPhotosThreshold = 5;
  final int _nextUsersThreshold = 5;

  ScrollController _scrollController;
  final searchHolder = TextEditingController();
  final List<String> _tabs = ['Photos', 'People', 'Groups'];

  // ------------------------------------------------------------------------ //

  Future viewUsers() async {
    try {
      print("---------------------->  viewUsers()");
      print(_usersPageNumber);
      print(_userPerCount);
      print(_searchKey);
      final user = Provider.of<MyModel>(context, listen: false);
      _fetchedUsers = await searchByUser(
          _searchKey, _userPerCount, _usersPageNumber, user.getToken());
      // print(_fetchedUsers);
      //
      setState(() {
        _usersResult.addAll(_fetchedUsers);
        // _hasMore = fetchedPhotos.length == _defaultPhotosPerPageCount;

        _loading = false;
        _usersPageNumber = _usersPageNumber + 1;
        print("----------------> Returning from viewUsers()");
        // notifyListeners();
        return 1;
      });
    } catch (e) {
      print(e);
      _loading = false;
      _usersError = true;
    }
  }

  Future viewPhotos() async {
    try {
      print("---------------------->  viewPhotos()");
      print(_photosPageNumber);
      print(_photosPerCount);
      final user = Provider.of<MyModel>(context, listen: false);
      print(_searchKey);
      _fetchedPhotos = await searchByPhoto(
          _searchKey, _photosPerCount, _photosPageNumber, user.getToken());
      // print(_fetchedUsers);
      setState(() {
        _photosResult.addAll(_fetchedPhotos);
        _photosLoading = false;
        _photosPageNumber = _photosPageNumber + 1;
        print("----------------> Returning from viewPhotos()");
        // notifyListeners();
        return 1;
      });
    } catch (e) {
      print(e);
      _photosLoading = false;
      _photosError = true;
    }
  }

  _scrollListener() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      setState(() {
        // print("comes to bottom $_photosLoading");
        _photosLoading = true;

        if (_photosLoading) {
          // print("RUNNING LOAD MORE");
          viewPhotos();
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("Ana fl init state");
    _tabController = new TabController(length: _tabs.length, vsync: this);
    _scrollController = new ScrollController(initialScrollOffset: 5.0)
      ..addListener(_scrollListener);
    _hasMore = true;
    _usersPageNumber = 1;
    _usersError = false;
    _loading = true;
    _photosPageNumber = 1;
    _photosError = false;
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: SafeArea(
        child: Scaffold(
          appBar:
              AppBar(backgroundColor: Colors.grey.shade800, actions: <Widget>[
            Expanded(
                child: IconButton(
              icon: Icon(Icons.search, color: _searchColor),
              onPressed: () async {
                if (_searchKey != "") {
                  //TODO: Request for result
                  _hasMore = true;
                  _usersPageNumber = 1;
                  _usersError = false;
                  _loading = true;
                  _usersResult = [];
                  _photosResult = [];
                  _photosPageNumber = 1;
                  _photosError = false;
                  await viewUsers();
                  await viewPhotos();
                  print("Button pressed");
                  setState(() {
                    _searchedImagesGrid = true;
                    FocusScope.of(context).requestFocus(FocusNode());
                  });
                }
              },
            )),
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: TextFormField(
                  controller: searchHolder,
                  onTap: () {
                    setState(() {
                      _searchColor = Colors.white;
                      _cancelButton = true;
                      _viewTabs = true;
                      // widget.callback(_viewTabs);
                    });
                  },
                  onChanged: (searchKey) {
                    setState(() {
                      if (searchKey == "") {
                        _removeText = false;
                      } else {
                        _removeText = true;
                      }

                      _searchKey = searchKey;
                    });
                  },
                  onFieldSubmitted: (searchKey) async {
                    _hasMore = true;
                    _usersPageNumber = 1;
                    _usersError = false;
                    _loading = true;
                    _usersResult = [];
                    _photosResult = [];
                    _photosPageNumber = 1;
                    _photosError = false;
                    await viewUsers();
                    await viewPhotos();
                    setState(() {
                      _searchedImagesGrid = true;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: textInputDecoration.copyWith(
                    hintText: 'Search Flickr',
                    hintStyle: TextStyle(color: Colors.grey.shade600),
                    disabledBorder: InputBorder.none,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                  ),
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Visibility(
                  visible: _removeText,
                  child: IconButton(
                      icon: Icon(Icons.cancel,
                          color: Colors.grey.shade600, size: 19.0),
                      onPressed: () {
                        setState(() {
                          searchHolder.clear();
                          _removeText = false;
                        });
                      }),
                )),
            Expanded(
              flex: 3,
              child: Visibility(
                visible: _cancelButton,
                child: Padding(
                  padding: const EdgeInsets.all(13.0),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        searchHolder.clear();
                        _cancelButton = false;
                        _removeText = false;
                        _searchColor = Colors.grey.shade600;
                        _viewTabs = false;
                        _usersResult = [];
                        _photosResult = [];
                        _photosPageNumber = 1;
                        _photosError = false;
                        _hasMore = true;
                        _usersPageNumber = 1;
                        _usersError = false;
                        _loading = true;
                        // widget.callback(_viewTabs);
                        _searchedImagesGrid = false;
                        FocusScope.of(context).requestFocus(FocusNode());
                      });
                    },
                    child: Text("Cancel",
                        style: TextStyle(
                          fontSize: 13.0,
                          color: Colors.white,
                        )),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.all(1.0),
                      side: BorderSide(
                        width: 2.0,
                        color: Colors.white,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
              ),
            )
          ]),
          // ),
          body: Stack(children: <Widget>[
            //TODO: Check
            // Visibility(visible: !_viewTabs, child: ImagesGrid(images: images)),
            Visibility(
              visible: _viewTabs,
              child: Container(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 50,
                        // margin: EdgeInsets.only(left: 60),
                        child: TabBar(
                          tabs: [
                            Container(
                              color: Colors.white,
                              child: Text(_tabs[0],
                                  style: TextStyle(fontSize: 15)),
                            ),
                            Container(
                              color: Colors.white,
                              width: 75.0,
                              child: Text(
                                _tabs[1],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                            Container(
                              color: Colors.white,
                              width: 75.0,
                              child: Text(
                                _tabs[2],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ],
                          unselectedLabelColor: Colors.grey.shade700,
                          indicatorColor: Colors.black,
                          labelColor: Colors.black,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorPadding: EdgeInsets.all(10),
                          isScrollable: false,
                          controller: _tabController,
                        ),
                      ),
                      Visibility(
                        visible: _searchedImagesGrid,
                        child: Container(
                          height: MediaQuery.of(context).size.height - 106,
                          child:
                              TabBarView(controller: _tabController, children: <
                                  Widget>[
                            StaggeredGridView.countBuilder(
                              crossAxisCount: 2,
                              controller: _scrollController,
                              scrollDirection: Axis.vertical,
                              itemCount: _photosResult.length, // list of images
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                onTap: () {
                                  //TODO: Go to image page
                                  print("Image Pressed");
                                },
                                child: Container(
                                  child: Image.network(
                                      _photosResult[index].originalSource),
                                ),
                              ),
                              staggeredTileBuilder: (int index) =>
                                  StaggeredTile.fit(1),
                              mainAxisSpacing: 5.0,
                              crossAxisSpacing: 5.0,
                            ),
                            Container(
                              //TODO: Request People
                              child: ListView.builder(
                                  padding: const EdgeInsets.all(8),
                                  itemCount: _usersResult.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    if (index ==
                                        _usersResult.length -
                                            _nextUsersThreshold) {
                                      print("Reached end of list");
                                      viewUsers();
                                    }
                                    if (index == _usersResult.length) {
                                      if (_usersError) {
                                        return Center(
                                            child: InkWell(
                                          onTap: () {
                                            setState(() {
                                              _loading = true;
                                              _usersError = false;
                                              print("Error");
                                              viewUsers();
                                            });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(16),
                                            child: Text(
                                                "Error while loading photos, tap to try again"),
                                          ),
                                        ));
                                      } else {}
                                    }
                                    return buildListTile(index, 60, 60);
                                  }),
                            ),
                            Container(
                              //TODO: Request Groups
                              child: ListView.separated(
                                controller: _scrollController,
                                itemCount: groupsNames.length,
                                padding: const EdgeInsets.all(8),
                                itemBuilder: (BuildContext context, int index) {
                                  return SearchGroupCard(index: index);
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        SizedBox(height: 10),
                              ),
                            )
                          ]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  ListTile buildListTile(int index, double width, double height) {
    return ListTile(
      leading: GestureDetector(
        onTap: () {
          //TODO: Go to user profile
          print("Photo pressed");
        },
        child: Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
                image: NetworkImage(profilePhotos[0]), fit: BoxFit.fill),
          ),
        ),
      ),
      title: Text(_usersResult[index].username,
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          )),
      subtitle: Text(
          _usersResult[index].photoCount.toString() +
              " photos - " +
              _usersResult[index].followerCount.toString() +
              " followers",
          style: TextStyle(fontWeight: FontWeight.w600)),
      dense: true,
    );
  }
}

class SearchGroupCard extends StatelessWidget {
  SearchGroupCard({@required this.index});
  int index;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          //TODO: Go to Group Page
          print("Card pressed");
        },
        child: Card(
          elevation: 1.0,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IntrinsicHeight(
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage(profilePhotos[index]),
                              fit: BoxFit.fill),
                        ),
                      ),
                      Container(
                        child: VerticalDivider(color: Colors.grey),
                      ),
                      SizedBox(width: 10.0),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(groupsNames[index],
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold)),
                            SizedBox(height: 20.0),
                            Text(groupsMembers[index] + " members",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600)),
                            Text(groupsPhotos[index] + " photos",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600)),
                            Text(groupsDiscussions[index] + " discussions",
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey.shade600)),
                          ])
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
