import 'package:flickr/Widgets/text_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

// Static Images to be changed later
List<String> images = [
  "assets/p1.jpg",
  "assets/p2.png",
  "assets/Portrait.jpg",
  "assets/port2.jpg",
  "assets/p4.jpg",
  "assets/p5.jpg",
  "assets/panda.jpg",
  "assets/zootopia.jpg",
  "assets/Rick.jpg",
  "assets/hades.jpg",
  "assets/p10.jpg"
];
List<String> searchedImages = [
  "assets/search1.jpg",
  "assets/search2.jpg",
  "assets/search3.jpg",
  "assets/search4.jpg",
  "assets/search5.png",
  "assets/p10.jpg",
  "assets/hades.jpg",
  "assets/p2.png"
];
List<String> peopleNames = [
  "Spongebob",
  "Donald Duck",
  "Buzz Lightyear",
  "Monalisa",
  "Nemo",
  "Timon"
];
List<String> profilePhotos = [
  "https://pyxis.nymag.com/v1/imgs/310/524/bfe62024411af0a9d9cd23447121704d7a-11-spongebob-squarepants.rsquare.w1200.jpg",
  "https://upload.wikimedia.org/wikipedia/en/a/a5/Donald_Duck_angry_transparent_background.png",
  "https://i.pinimg.com/originals/0e/81/53/0e8153e8a2c62459ca24a06ca9fb7069.png",
  "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ec/Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg/1200px-Mona_Lisa%2C_by_Leonardo_da_Vinci%2C_from_C2RMF_retouched.jpg",
  "https://stickershop.line-scdn.net/stickershop/v1/product/1348/LINEStorePC/main.png;compress=true",
  "https://i1.sndcdn.com/avatars-000514838841-sk6ksb-t500x500.jpg"
];
List<String> photosNumber = ["50", "13", "120", "3", "5", "89"];
List<String> followers = ["1.3K", "14k", "15K", "200", "983", "15K"];
List<String> groupsNames = [
  "Group1",
  "Group2",
  "Group3",
  "Group4",
  "Group5",
  "Group6"
];
List<String> groupsMembers = ["100", "10k", "564", "9k", "10", "34"];
List<String> groupsDiscussions = ["13", "110", "54", "45", "123", "78"];
List<String> groupsPhotos = ["91", "16.2k", "54", "9k", "10", "143"];
// ------------------------------------------------------------------------ //

class Search extends StatefulWidget {
  Function(bool) callback;
  Search(this.callback);
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin<Search> {
  TabController _tabController;
  bool _removeText = false;
  bool _cancelButton = false;
  bool _viewtabs = false;
  bool _searchedImagesGrid = false;
  Color _searchColor = Colors.grey.shade600;
  String _searchKey = "";
  List<String> _followButton = [
    "+ Follow",
    "+ Follow",
    "+ Follow",
    "+ Follow",
    "+ Follow",
    "+ Follow"
  ];
  final searchHolder = TextEditingController();
  final List<String> _tabs = ['Photos', 'People', 'Groups'];
  final List<String> entries = <String>[
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'h',
    'I',
    'g',
    'g',
    'j'
  ];
  final List<int> colorCodes = <int>[
    600,
    500,
    100,
    100,
    500,
    100,
    100,
    500,
    100,
    100,
    500,
    100
  ];

  // ------------------------------------------------------------------------ //
  toggleFollow(index) {
    if (_followButton[index] == "✓") {
      _followButton[index] = "+ Follow";
    } else {
      _followButton[index] = "✓";
    }
  }

  void initState() {
    super.initState();
    _tabController = new TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  bool get wantKeepAlive => true;

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
              onPressed: () {
                if (_searchKey != "") {
                  //TODO: Request for result
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
                      _viewtabs = true;
                      widget.callback(_viewtabs);
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
                  onFieldSubmitted: (searchKey) {
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
                        _viewtabs = false;
                        widget.callback(_viewtabs);
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
            Visibility(visible: !_viewtabs, child: ImagesGrid(images: images)),
            Visibility(
              visible: _viewtabs,
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
                          child: TabBarView(
                              controller: _tabController,
                              children: <Widget>[
                                ImagesGrid(images: searchedImages),
                                Container(
                                  //TODO: Request People
                                  child: ListView.builder(
                                    padding: const EdgeInsets.all(8),
                                    itemCount: peopleNames.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return buildListTile(index, 60, 60);
                                    },
                                  ),
                                ),
                                Container(
                                  //TODO: Request Groups
                                  child: ListView.separated(
                                    itemCount: groupsNames.length,
                                    padding: const EdgeInsets.all(8),
                                    itemBuilder:
                                        (BuildContext context, int index) {
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
                image: NetworkImage(profilePhotos[index]), fit: BoxFit.fill),
          ),
        ),
      ),
      title: Text(peopleNames[index],
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w600,
          )),
      subtitle: Text(
          photosNumber[index] + " photos - " + followers[index] + " followers",
          style: TextStyle(fontWeight: FontWeight.w600)),
      dense: true,
      trailing: OutlinedButton(
        onPressed: () {
          setState(() {
            //TODO: Request to edit followers
            toggleFollow(index);
            print("Follow");
          });
        },
        child: Text(_followButton[index],
            style: TextStyle(
              fontSize: 13.0,
              color: Colors.black,
            )),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(1.0),
          side: BorderSide(
            width: 2.0,
            color: Colors.black,
            style: BorderStyle.solid,
          ),
        ),
      ),
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

class ImagesGrid extends StatelessWidget {
  ImagesGrid({@required this.images});

//TODO: Request images and store them in the list the grid uses
  List<String> images;
  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: images.length, // list of images
      itemBuilder: (BuildContext context, int index) => GestureDetector(
        onTap: () {
          //TODO: Go to image page
          print("Image Pressed");
        },
        child: Container(
          child: Image.asset(images[index]),
        ),
      ),
      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
      mainAxisSpacing: 5.0,
      crossAxisSpacing: 5.0,
    );
  }
}
